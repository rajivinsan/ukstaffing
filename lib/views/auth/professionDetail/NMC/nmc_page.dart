import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/views/widgets/custom_text_form_field.dart';
import 'package:sterling/views/widgets/progressbar_appbar.dart';

import '../../../../provider/repository_provider.dart';
import '../../../../provider/services_provider.dart';
import '../../../../services/local_db_helper.dart';
import '../../../../utilities/ui/MProgressIndicator.dart';
import '../../../widgets/stepper_bottom_control.dart';
import '../../../widgets/stepper_form.dart';

class NmcPage extends ConsumerStatefulWidget {
  const NmcPage({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  ConsumerState<NmcPage> createState() => _NmcPageState();
}

class _NmcPageState extends ConsumerState<NmcPage> {
  final PageController controller = PageController();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nmcPin = TextEditingController();
  final TextEditingController _nmcType = TextEditingController();
  int initialPage = 0;

  int _activeStepIndex = 0;
  List<Step> step() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.indexed : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const SizedBox.shrink(),
          content: NurseQualificationDate(date: _dateController),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.indexed : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const SizedBox.shrink(),
          content: NmcPin(nmcPin: _nmcPin),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const SizedBox.shrink(),
          content: NurseType(type: _nmcType),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarProgress(name: "Personal Details", progress: 0.2),
      body: CommonStepperForm(
          steps: step(),
          activeStepIndex: _activeStepIndex,
          onStepCancel: () {
            if (_activeStepIndex == 0) {
              return;
            }

            setState(() {
              _activeStepIndex -= 1;
            });
          },
          onStepContinue: () {
            if (_activeStepIndex < (step().length - 1)) {
              setState(() {
                _activeStepIndex += 1;
              });
            } else {
              print('Submited');
            }
          },
          onStepTapped: (index) {
            setState(() {
              _activeStepIndex = index;
            });
          }),
      bottomNavigationBar: SteppereBottomControl(
        backFunction: () {
          if (_activeStepIndex == 0) {
            return;
          }

          setState(() {
            _activeStepIndex -= 1;
          });
        },
        continueFunction: () {
          if (_activeStepIndex < (step().length - 1)) {
            if (_activeStepIndex == 0) {
              if (_dateController.text.trim().isEmpty) {
                "Please Provide Date".showErrorAlert(context);
              } else {
                setState(() {
                  _activeStepIndex += 1;
                });
              }
            }
            if (_activeStepIndex == 1) {
              if (_nmcPin.text.trim().isEmpty) {
                "Please Provide NMC Pin".showErrorAlert(context);
              } else {
                setState(() {
                  _activeStepIndex += 1;
                });
              }
            }
          } else {
            if (_nmcType.text.trim().isEmpty) {
              "Please Enter Nurse Type".showErrorAlert(context);
            } else {
              postNamc(ref);
            }
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const SignupProfessional()));
          }
        },
        isShowBack: _activeStepIndex == 0,
      ),
    );
  }

  postNamc(WidgetRef ref) {
    MProgressIndicator.show(context);
    ref
        .read(authRepositoryProvider)
        .postNmc(
            date: _dateController.text.trim(),
            nmcPin: _nmcPin.text.trim(),
            nurseType: _nmcType.text.trim())
        .then((value) {
      MProgressIndicator.hide();
      if (value.success) {
        value.message.showSuccessAlert(context);
        ref.read(listingProvider.notifier).updateProfessionList(widget.id);
        LocaldbHelper.saveListingDetails(
          list: ref.watch(listingProvider),
        );
        Navigator.pop(context);
      } else {
        value.message.showErrorAlert(context);
      }
    });
  }
}

class NurseQualificationDate extends StatefulWidget {
  const NurseQualificationDate({super.key, required this.date});
  final TextEditingController date;
  @override
  State<NurseQualificationDate> createState() => _NurseQualificationDateState();
}

class _NurseQualificationDateState extends State<NurseQualificationDate> {
  final TextEditingController _nurseDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "When did you qualify as nurse?",
          style: signUpHeadStyle,
        ),
        size20,
        Text(
          "Please ensure this is the same date as an your NMC registration",
          style: signUpSubHeadStyle,
        ),
        size20,
        InkWell(
          onTap: () async {
            await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
            ).then((value) {
              if (value != null) {
                setState(() {
                  widget.date.text = value.toString().substring(0, 10);
                });
              }
            });
          },
          child: CustomTextFormField(
            controller: widget.date,
            enable: false,
            label: "select Date",
            validator: (val) {
              return null;
            },
          ),
        )
      ],
    );
  }
}

class NmcPin extends StatelessWidget {
  const NmcPin({super.key, required this.nmcPin});
  final TextEditingController nmcPin;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What's your NMC PIN?",
          style: signUpHeadStyle,
        ),
        size20,
        Text(
          "We will use this to confirm your details with NMC Register",
          style: signUpSubHeadStyle,
        ),
        size20,
        CustomTextFormField(
          controller: nmcPin,
          label: "12A3456B",
          validator: (val) {
            return null;
          },
        )
      ],
    );
  }
}

class NurseType extends StatefulWidget {
  const NurseType({super.key, required this.type});
  final TextEditingController type;
  @override
  State<NurseType> createState() => _NurseTypeState();
}

class _NurseTypeState extends State<NurseType> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Nurse Type",
          style: signUpHeadStyle,
        ),
        size20,
        Text(
          "Please tell us which brand of nursing you are register with the NMC as",
          style: signUpSubHeadStyle,
        ),
        size20,
        CustomTextFormField(
          controller: widget.type,
          label: "Nurse Type",
          validator: (val) {
            return null;
          },
        )
      ],
    );
  }
}
