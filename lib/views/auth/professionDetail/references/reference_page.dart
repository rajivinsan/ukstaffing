import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/provider/repository_provider.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/MProgressIndicator.dart';
import 'package:sterling/utilities/ui/utility.dart';
import 'package:sterling/views/widgets/custom_text_form_field.dart';
import 'package:sterling/views/widgets/progressbar_appbar.dart';

import '../../../../constants/color_constant.dart';
import '../../../../provider/services_provider.dart';
import '../../../../services/local_db_helper.dart';
import '../../../../utilities/ui/size_config.dart';
import '../../../widgets/stepper_bottom_control.dart';
import '../../../widgets/stepper_form.dart';

class ReferencePage extends ConsumerStatefulWidget {
  const ReferencePage({super.key, required this.id});
  final int id;

  @override
  ConsumerState<ReferencePage> createState() => _ReferencePageState();
}

class _ReferencePageState extends ConsumerState<ReferencePage> {
  final TextEditingController _orginisation = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _employer = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  int initialPage = 0;
  bool isWorkingNow = false;

  final PageController controller = PageController(initialPage: 0);

  final formKey = GlobalKey<FormState>();

  int _activeStepIndex = 0;
  List<Step> step() => [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const SizedBox.shrink(),
            content: const ReferenceScreen()),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const SizedBox.shrink(),
            content: AddReferencePage(
              employeer: _employer,
              orginisation: _orginisation,
              email: _email,
              isWorking: isWorkingNow,
              formKey: formKey,
              endDate: _endDate,
              onTap: (val) {
                setState(() {
                  isWorkingNow = val!;
                });
              },
              startDate: _startDate,
            )),
      ];
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarProgress(name: "References", progress: 0.2),
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
              //print('Submited');
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
            setState(() {
              _activeStepIndex += 1;
            });
          } else {
            if (formKey.currentState!.validate()) {
              if (_startDate.text.trim().isEmpty) {
                "Please Enter Start Date".showErrorAlert(context);
              }
              if (!isWorkingNow) {
                if (_endDate.text.trim().isEmpty) {
                  "Please Enter End Date".showErrorAlert(context);
                } else {
                  addReference();
                }
              } else {
                addReference();
              }
            }
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const SignupProfessional(),
            //   ),
            // );
          }
        },
        isShowBack: _activeStepIndex == 0,
      ),
    );
  }

  addReference() {
    MProgressIndicator.show(context);
    ref
        .read(authRepositoryProvider)
        .addReference(
            employer: _employer.text.trim(),
            orginisation: _orginisation.text.trim() + ' -' + _email.text + '',
            startDate: _startDate.text.trim(),
            endDate: isWorkingNow ? null : _endDate.text.trim())
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
        Navigator.pop(context);
      }
    });
  }
}

class ReferenceScreen extends StatefulWidget {
  const ReferenceScreen({Key? key}) : super(key: key);

  @override
  State<ReferenceScreen> createState() => _ReferenceScreenState();
}

class _ReferenceScreenState extends State<ReferenceScreen> {
  String? statDate;
  String? endDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text(
            "Professional References",
            style: codeProHeadStyle.copyWith(shadows: textShadow),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            '''You need two professional references who are not your friends or family members. we can accept any previous healthcare employer, band 6 nurses or higher or up to one  agency.''',
            textAlign: TextAlign.justify,
            style: sourceCodeProStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
        Image.asset(AppImages.reference)
      ],
    );
  }
}

class AddReferencePage extends StatefulWidget {
  AddReferencePage(
      {super.key,
      required this.employeer,
      required this.orginisation,
      required this.email,
      required this.endDate,
      required this.formKey,
      required this.onTap,
      required this.isWorking,
      required this.startDate});
  final TextEditingController employeer;
  final TextEditingController orginisation;
  final TextEditingController email;
  final TextEditingController startDate;
  final TextEditingController endDate;
  final GlobalKey<FormState> formKey;
  final void Function(bool?)? onTap;
  bool? isWorking;
  @override
  State<AddReferencePage> createState() => _AddReferencePageState();
}

class _AddReferencePageState extends State<AddReferencePage> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profession References",
            style: codeProHeadStyle.copyWith(shadows: textShadow),
          ),
          Utility.vSize(5),
          CustomTextFormField(
            controller: widget.employeer,
            label: "Referee Name",
            validator: ((val) {
              if (val == null || widget.employeer.text.trim().isEmpty) {
                return "Please Enter Name";
              } else {
                return null;
              }
            }),
          ),
          Utility.vSize(10),
          CustomTextFormField(
            controller: widget.orginisation,
            label: "Orginisation",
            validator: ((val) {
              if (val == null || widget.orginisation.text.trim().isEmpty) {
                return "Please Enter Orginization Name";
              } else {
                return null;
              }
            }),
          ),
          Utility.vSize(10),
          CustomTextFormField(
            controller: widget.email,
            label: "Orginization Email",
            validator: ((val) {
              if (val == null || widget.email.text.trim().isEmpty) {
                return "Please Enter Orginization Email";
              }
              if (!widget.email.text.trim().isEmail()) {
                return "Please Enter valid email";
              }

              final emailEx = RegExp(
                  r'^((?!gmail\.com|yahoo\.com|hotmail\.com|rediff\.com).)*$');
              if (!emailEx.hasMatch(val)) {
                return 'Please enter professional email only';
              }
              return null;
            }),
          ),
          Utility.vSize(20),
          Text(
            "When did you work here?",
            style: sourceCodeProStyle.copyWith(fontSize: 20),
          ),
          Utility.vSize(10),
          InkWell(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              ).then((value) {
                if (value != null) {
                  widget.startDate.text = value.toString().substring(0, 10);
                  setState(() {});
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  color: containerBackGroundColor,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: Color.fromRGBO(
                        0,
                        0,
                        0,
                        0.5,
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.startDate.text.trim().isEmpty
                          ? "Start Date"
                          : widget.startDate.text.trim(),
                      style: signUpSubHeadStyle.copyWith(
                        color: kLightTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(SvgAsset.calender)
                ],
              ),
            ),
          ),
          //Utility.vSize(20),
          widget.isWorking!
              ? const SizedBox.shrink()
              : InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        widget.endDate.text = value.toString().substring(0, 10);
                        setState(() {});
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: containerBackGroundColor,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 0,
                            color: Color.fromRGBO(
                              0,
                              0,
                              0,
                              0.5,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.endDate.text.trim().isEmpty
                                ? "End Date"
                                : widget.endDate.text.trim(),
                            style: signUpSubHeadStyle.copyWith(
                              color: kLightTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(SvgAsset.calender)
                      ],
                    ),
                  ),
                ),
          // Utility.vSize(20),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "I currently work here",
                    textAlign: TextAlign.center,
                    style: sourceCodeProStyle.copyWith(
                      color: kbluteColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Checkbox(value: widget.isWorking, onChanged: widget.onTap)
              ],
            ),
          ),
          Utility.vSize(20),
        ],
      ),
    );
  }
}
