import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/provider/repository_provider.dart';
import 'package:sterling/services/local_db_helper.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/MProgressIndicator.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/utilities/ui/utility.dart';
import 'package:sterling/views/auth/auth_compelte_screen.dart';

import '../widgets/stepper_bottom_control.dart';
import '../widgets/stepper_form.dart';

class SignupProfessional extends ConsumerStatefulWidget {
  const SignupProfessional(
      {super.key,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.numberOfShift,
      required this.password,
      required this.postalCode});
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String postalCode;
  final String numberOfShift;
  @override
  SignupProfessionalState createState() => SignupProfessionalState();
}

class SignupProfessionalState extends ConsumerState<SignupProfessional> {
  int initialPage = 0;
  String slectedString = "";

  final PageController controller = PageController(initialPage: 0);
  String? professionStyle = "Carer";
  String? preferWork;
  List<SlectionWithPictureModel> list = [
    SlectionWithPictureModel(
        image: AppImages.carer, isSelected: true, name: "Carer"),
    SlectionWithPictureModel(
      image: AppImages.nurse,
      isSelected: false,
      name: "Nurse",
    )
  ];
  List<SlectionWithPictureModel> buildPrefWork = [
    SlectionWithPictureModel(
        image: AppImages.night, isSelected: true, name: "Day"),
    SlectionWithPictureModel(
      image: AppImages.day,
      isSelected: false,
      name: "Night",
    )
  ];
  int _activeStepIndex = 0;

  List<Widget> widgets = [];
  List<Step> step() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.indexed : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const SizedBox.shrink(),
          content: _buildSelectProfession(),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const SizedBox.shrink(),
          content: _buildPrefWorkSelection(),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight!;
    var width = SizeConfig.screenWidth!;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Create Account",
          style: sourceCodeProStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: kPrimaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: KAppbarbackgroundColor,
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Sign Out",
                  style: sourceSansStyle.copyWith(
                      color: kLightTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.logout,
                  color: kLightTextColor,
                  size: 20,
                )
              ],
            ),
          ))
        ],
      ),
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
      bottomSheet: SteppereBottomControl(
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
            // if (preferWork == null) {
            //   "Please Select Profession".showErrorAlert(context);
            // }

            if (professionStyle == null) {
              "Please Select Shift".showErrorAlert(context);
            } else {
              registerUser(context: context, ref: ref);
            }
          }
        },
        isShowBack: _activeStepIndex == 0,
      ),
    );
  }

  SingleChildScrollView _buildSelectProfession() {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //professional start here
            Text(
              "Profession and Shift Preference ",
              style: signUpHeadStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "what profession would you like to signup as? ",
              style: signUpSubHeadStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // runAlignment: WrapAlignment.center,
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  children: list
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            setState(() {
                              professionStyle = e.name;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, top: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: e.name == professionStyle
                                  ? kPrimaryColor
                                  : kCardColor,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  offset: Offset(0, 4),
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4,
                                              spreadRadius: 0,
                                              offset: Offset(0, 4),
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.25),
                                            ),
                                          ],
                                        ),
                                        child: Image.asset(
                                          e.image,
                                          height: 80,
                                        )),
                                    if (professionStyle == e.name)
                                      Container(
                                        margin: const EdgeInsets.all(6),
                                        padding: const EdgeInsets.all(0),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(
                                                5, 237, 70, 0.77)),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  e.name,
                                  style: sourceCodeProStyle.copyWith(
                                      fontSize: 24,
                                      color: e.name == professionStyle
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Utility.vSize(10)
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _buildPrefWorkSelection() {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //professional start here
            Text(
              "Shift Preference",
              style: signUpHeadStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Let us Know what type of nurse shifts you would prefer to work ",
              style: signUpSubHeadStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Wrap(
                  runSpacing: 10,
                  spacing: 25,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: buildPrefWork
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            setState(() {
                              preferWork = e.name;
                              e.isSelected = !e.isSelected!;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, top: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: e.isSelected! ? kPrimaryColor : kCardColor,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  offset: Offset(0, 4),
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4,
                                              spreadRadius: 0,
                                              offset: Offset(0, 4),
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.25),
                                            ),
                                          ],
                                        ),
                                        child: Image.asset(
                                          e.image,
                                          fit: BoxFit.contain,
                                          height: 130,
                                        )),
                                    if (e.isSelected!)
                                      Container(
                                        margin: const EdgeInsets.all(6),
                                        padding: const EdgeInsets.all(0),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(
                                                5, 237, 70, 0.77)),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  e.name,
                                  style: sourceCodeProStyle.copyWith(
                                      fontSize: 24,
                                      color: e.isSelected!
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Utility.vSize(10)
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }

  registerUser({required BuildContext context, WidgetRef? ref}) {
    Map<String, dynamic> body = {
      "firstName": widget.firstName,
      "lastName": widget.lastName,
      "email": widget.email,
      "pass": widget.password,
      "shift": int.parse(widget.numberOfShift),
      "postcode": widget.postalCode,
      "profession": professionStyle == "Carer" ? 1 : 2,
      "shifttype": 2,
    };
    try {
      final authProvider = ref!.read(authRepositoryProvider);
      MProgressIndicator.show(context);

      authProvider.userRegistration(body).then((value) {
        MProgressIndicator.hide();
        if (value.success) {
          value.message.showSuccessAlert(context);
          LocaldbHelper.saveSignup(isSignUp: true);
          LocaldbHelper.saveToken(token: value.data["cid"]);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AuthCompelteScreen()),
          );
        } else {
          value.message.showErrorAlert(context);
        }
      });
    } catch (e) {
      MProgressIndicator.hide();
      e.toString().showErrorAlert(context);
    }
  }
}

class SlectionWithPictureModel {
  final String image;
  final String name;
  bool? isSelected;
  SlectionWithPictureModel(
      {required this.image, required this.isSelected, required this.name});
}
