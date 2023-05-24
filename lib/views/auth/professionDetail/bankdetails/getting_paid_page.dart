import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/provider/repository_provider.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/views/widgets/custom_text_form_field.dart';
import 'package:sterling/views/widgets/progressbar_appbar.dart';
import 'package:sterling/views/widgets/stepper_bottom_control.dart';

import '../../../../provider/services_provider.dart';
import '../../../../services/local_db_helper.dart';
import '../../../../utilities/ui/MProgressIndicator.dart';
import '../../../widgets/stepper_form.dart';

class GettingPage extends ConsumerStatefulWidget {
  const GettingPage({Key? key, required this.id, required this.pagestate})
      : super(key: key);
  final int id;
  final int pagestate;
  @override
  GettingPageState createState() => GettingPageState();
}

class GettingPageState extends ConsumerState<GettingPage> {
  int initialPage = 0;
  TextEditingController inN = TextEditingController();
  final TextEditingController bankAccountName = TextEditingController();
  final TextEditingController bankshortcode = TextEditingController();
  final TextEditingController accNo = TextEditingController();
  final PageController controller = PageController(initialPage: 0);
  var bankFormKey = GlobalKey<FormState>();
  int _activeStepIndex = 0;
  List<Step> step() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.indexed : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const SizedBox.shrink(),
          content: InsuurenceNumber(controller: inN),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.indexed : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const SizedBox.shrink(),
          content: BankAccountNumber(
            formKey: bankFormKey,
            accNo: accNo,
            bankAccountName: bankAccountName,
            bankshortcode: bankshortcode,
          ),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const AppBarProgress(name: "Getting Paid", progress: 0.2),
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
            if (inN.text.isNotEmpty) {
              if (inN.text.length == 9) {
                setState(() {
                  _activeStepIndex += 1;
                });
              } else {
                "Please Enter Valid 9 Digit Insurance Nunmber"
                    .showErrorAlert(context);
              }
            } else {
              "Please Enter National Insurance Nunmber".showErrorAlert(context);
            }
          } else {
            if (bankFormKey.currentState!.validate() && widget.pagestate == 0) {
              MProgressIndicator.show(context);
              ref
                  .read(authRepositoryProvider)
                  .postBankDetails(
                      nin: inN.text.trim(),
                      bankCode: bankshortcode.text,
                      name: bankAccountName.text,
                      accNo: accNo.text)
                  .then((value) {
                if (value.success) {
                  MProgressIndicator.hide();
                  value.message.showSuccessAlert(context);
                  ref
                      .read(listingProvider.notifier)
                      .updateProfessionList(widget.id);
                  LocaldbHelper.saveListingDetails(
                    list: ref.watch(listingProvider),
                  );
                  Navigator.pop(context);
                } else {
                  value.message.showErrorAlert(context);
                }
                print(value);
              });
            }
            if (bankFormKey.currentState!.validate() && widget.pagestate == 1) {
              MProgressIndicator.show(context);
              ref
                  .read(authRepositoryProvider)
                  .updateBankDetails(
                      nin: inN.text.trim(),
                      bankCode: bankshortcode.text,
                      name: bankAccountName.text,
                      accNo: accNo.text)
                  .then((value) {
                if (value.success) {
                  MProgressIndicator.hide();
                  value.message.showSuccessAlert(context);
                  ref
                      .read(listingProvider.notifier)
                      .updateProfessionList(widget.id);
                  LocaldbHelper.saveListingDetails(
                    list: ref.watch(listingProvider),
                  );
                  Navigator.pop(context);
                } else {
                  value.message.showErrorAlert(context);
                }
                print(value);
              });
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
}

class InsuurenceNumber extends StatelessWidget {
  const InsuurenceNumber({Key? key, required this.controller})
      : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What's your national insurance number?",
          style: signUpHeadStyle,
        ),
        size10,
        Text(
          "We need this to pay you",
          style: signUpSubHeadStyle,
        ),
        size10,
        CustomTextFormField(
          controller: controller,
          label: "QQKKK",
          validator: (val) {
            if (val!.length != 9) {
              return "Enter Valid 9 Digit Insurance Number";
            }

            return null;
          },
        )
      ],
    );
  }
}

class BankAccountNumber extends StatelessWidget {
  const BankAccountNumber(
      {Key? key,
      required this.formKey,
      required this.accNo,
      required this.bankAccountName,
      required this.bankshortcode})
      : super(key: key);
  final TextEditingController bankAccountName;
  final TextEditingController bankshortcode;
  final TextEditingController accNo;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What's the name on your bank account?",
              style: signUpHeadStyle,
            ),
            size10,
            Text(
              "We need this to pay you",
              style: signUpSubHeadStyle,
            ),
            size10,
            CustomTextFormField(
              controller: bankAccountName,
              label: "Bank Account Name",
              validator: (val) {
                if (val == null || bankAccountName.text.isEmpty) {
                  return "Please enter bank acc no";
                }
                return null;
              },
            ),
            size10,
            Text(
              "What's the bank short code?",
              style: signUpHeadStyle,
            ),
            size10,
            Text(
              "We need this to pay you",
              style: signUpSubHeadStyle,
            ),
            size10,
            CustomTextFormField(
              controller: bankshortcode,
              label: "Sort Code",
              validator: (val) {
                if (val == null || bankshortcode.text.trim().isEmpty) {
                  return "Please enter bank sort code";
                }

                if (bankshortcode.text.length != 6) {
                  return "Please enter valid 6 digit bank code";
                }
                return null;
              },
            ),
            size10,
            Text(
              "What's your bank account number?",
              style: signUpHeadStyle,
            ),
            size10,
            Text(
              "We need this to pay you",
              style: signUpSubHeadStyle,
            ),
            size10,
            CustomTextFormField(
              controller: accNo,
              inputType: TextInputType.number,
              label: "Account Number",
              validator: (val) {
                if (val == null || accNo.text.trim().isEmpty) {
                  return "Please enter bank account number";
                }
                if (accNo.text.length != 8) {
                  return "Please enter valid 8 digit account number";
                }
                return null;
              },
            ),
            size20,
            size20,
          ],
        ),
      ),
    );
  }
}

class BanckShortCode extends StatelessWidget {
  BanckShortCode({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What's the bank short code?",
          style: signUpHeadStyle,
        ),
        size10,
        Text(
          "We need this to pay you",
          style: signUpSubHeadStyle,
        ),
        size10,
        CustomTextFormField(
          controller: _controller,
          label: "QQKKK",
          validator: (val) {
            return null;
          },
        )
      ],
    );
  }
}

class BacnkAccNumber extends StatelessWidget {
  BacnkAccNumber({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What's your bank account number?",
          style: signUpHeadStyle,
        ),
        size10,
        Text(
          "We need this to pay you",
          style: signUpSubHeadStyle,
        ),
        size10,
        CustomTextFormField(
          controller: _controller,
          label: "QQKKK",
          validator: (val) {
            return null;
          },
        )
      ],
    );
  }
}
