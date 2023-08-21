import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/models/postcode.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/auth/signup_professional_details.dart';
import 'package:sterling/views/widgets/custom_text_form_field.dart';
import 'package:sterling/views/widgets/stepper_bottom_control.dart';
import 'package:sterling/views/widgets/stepper_form.dart';
import 'package:http/http.dart' as http;
import '../widgets/shifts_selection.dart';

late double _lat;
late double _lon;

class SignUpPage1 extends StatefulWidget {
  const SignUpPage1(
      {Key? key,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.password})
      : super(key: key);
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  @override
  State<SignUpPage1> createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1>
    with AutomaticKeepAliveClientMixin<SignUpPage1> {
  int _activeStepIndex = 0;

  TextEditingController postCode = TextEditingController();
  List<Widget> widgets = [];
  int shiftSelectionValue = 2;
  List<ShiftSelectionModel> data = [
    ShiftSelectionModel(value: 1, isSelected: false),
    ShiftSelectionModel(value: 2, isSelected: false),
    ShiftSelectionModel(value: 3, isSelected: false),
    ShiftSelectionModel(value: 4, isSelected: false),
    ShiftSelectionModel(value: 5, isSelected: false),
    ShiftSelectionModel(value: 6, isSelected: false),
  ];
  final formkey = GlobalKey<FormState>();
  List<Step> step() => [
        Step(
            state:
                _activeStepIndex <= 0 ? StepState.indexed : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const SizedBox.shrink(),
            content: NumberShiftsScreen(
              number: shiftSelectionValue,
              data: data,
            )),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const SizedBox.shrink(),
          content: PostalCodeScreen(
            formkey: formkey,
            postlCode: postCode,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final isLastStep = _activeStepIndex == step().length - 1;
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
             // print('Submited');
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
            if (formkey.currentState!.validate() &&
                (_lat != null && _lon != null)) {
             // print(postCode.text.trim());

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupProfessional(
                    email: widget.email,
                    firstName: widget.firstName,
                    lastName: widget.lastName,
                    numberOfShift: shiftSelectionValue.toString(),
                    password: widget.password,
                    postalCode: postCode.text.trim(),
                    lat: _lat,
                    lon: _lon,
                  ),
                ),
              );
            }
          }
        },
        isShowBack: _activeStepIndex == 0,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class NumberShiftsScreen extends StatelessWidget {
  NumberShiftsScreen({Key? key, required this.number, required this.data})
      : super(key: key);
  int number;
  List<ShiftSelectionModel> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Number of shifts",
              style: signUpHeadStyle.copyWith(shadows: textShadow),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Let us know the number of shifts you'd ideally like to work per week",
              style: signUpSubHeadStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            ShiftSelectionTile(
              data: data,
              selectedShift: number,
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PostalCodeScreen extends StatefulWidget {
  PostalCodeScreen({super.key, required this.postlCode, required this.formkey});
  final TextEditingController postlCode;
  GlobalKey<FormState> formkey;

  @override
  State<PostalCodeScreen> createState() => _PostalCodeScreenState();
}

class _PostalCodeScreenState extends State<PostalCodeScreen> {
  bool postvalidate = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Form(
      key: widget.formkey,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What's your PostalCode",
              style: signUpHeadStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "To verify your idendity and pay you correctly we'll need your address",
              style: signUpSubHeadStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              controller: widget.postlCode,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Enter Postal Code";
                }
                if (!postvalidate) {
                  return "invalid Post Code";
                }

                return null;
              },
              label: "Postcode",
              sufficIcon: postvalidate == true
                  ? Icon(
                      Icons.verified_rounded,
                      color: Colors.green,
                    )
                  : null,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    final response = await http.get(Uri.parse(
                        "https://api.postcodes.io/postcodes/" +
                            widget.postlCode.text));

                    if (response.statusCode == 200) {
                      var data = postcodeFromJson(response.body);

                      setState(() {
                        _lat = data.result.latitude;
                        _lon = data.result.longitude;

                        postvalidate = true;
                      });

                      widget.formkey.currentState!.validate();
                    } else if (response.statusCode == 404) {
                      setState(() {
                        postvalidate = false;
                      });
                      "Invalid postcode ".showErrorAlert(context);
                    } else {
                      // If the server did not return a 200 OK response,
                      // then throw an exception.
                      "error in api request ".showErrorAlert(context);
                    }
                  },
                  child: Text("Validate Postal Code")),
            )
          ],
        ),
      ),
    );
  }
}
