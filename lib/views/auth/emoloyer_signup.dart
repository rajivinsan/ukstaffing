import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/provider/repository_provider.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/MProgressIndicator.dart';
import 'package:sterling/views/auth/thanks.dart';

import '../../constants/color_constant.dart';
import '../../constants/text_style.dart';
import '../../utilities/ui/size_config.dart';
import '../widgets/common_button.dart';
import '../widgets/custom_text_form_field.dart';

class EmployerSignUp extends ConsumerStatefulWidget {
  const EmployerSignUp({Key? key}) : super(key: key);

  @override
  ConsumerState<EmployerSignUp> createState() => _EmployerSignUpState();
}

class _EmployerSignUpState extends ConsumerState<EmployerSignUp> {
  TextStyle labelStyle = sourceCodeProStyle.copyWith(
    fontSize: 16,
    color: Colors.black,
  );
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isPassword = false;
  bool isConfirmPassword = false;
  final List<String> _sex = [
    "Nurse",
    "Support Worker",
  ];
  String selectProf = "Nurse";
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          bottomSheet: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: CommonButton(
                name: "Submit",
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    MProgressIndicator.show(context);
                    ref
                        .read(authRepositoryProvider)
                        .postEmployerQuery(
                            name: _firstName.text,
                            email: _email.text,
                            phone: _password.text,
                            profession: "Employer",
                            message: _messageController.text,
                            urls: "",
                            type: 1)
                        .then(
                      (value) {
                        MProgressIndicator.hide();
                        if (value.success) {
                          value.message.showSuccessAlert(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ThankYouPage()),
                          );
                        } else {
                          value.message.showErrorAlert(context);
                        }
                      },
                    );

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SignUpPage1(
                    //       email: _email.text.trim(),
                    //       firstName: _firstName.text.trim(),
                    //       lastName: _lastName.text.trim(),
                    //       password: _password.text.trim(),
                    //     ),
                    //   ),
                    // );
                  }
                }),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
            title: Text("Sign Up", style: codeProHeadStyle),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildField(
                      name: " Name",
                      controller: _firstName,
                      label: "Enter your  name",
                      validator: (val) {
                        if (val!.isEmpty || _firstName.text.trim().isEmpty) {
                          return "Please Enter First Name";
                        }
                        return null;
                      },
                    ),

                    buildField(
                      name: "Email",
                      label: "Enter your email",
                      controller: _email,
                      validator: (val) {
                        if (val!.isEmpty || _email.text.trim().isEmpty) {
                          return "Please Enter Email";
                        }
                        if (!_email.text.trim().isEmail()) {
                          return "Please Enter valid email";
                        }
                        return null;
                      },
                    ),
                    // size10,
                    // Text(
                    //   "What's your Gender?",
                    //   style: labelStyle,
                    // ),
                    size10,
                    // size10,
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 10, vertical: 15),
                    //   decoration: BoxDecoration(
                    //       color: containerBackGroundColor,
                    //       borderRadius: BorderRadius.circular(6),
                    //       border: Border.all(color: lightTextColor)),
                    //   width: MediaQuery.of(context).size.width,
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton<String>(
                    //       dropdownColor: containerBackGroundColor,
                    //       hint: const Text("What’s your gender ?"),
                    //       value: selectProf,
                    //       onChanged: (val) {
                    //         setState(
                    //           () {
                    //             selectProf = val!;
                    //           },
                    //         );
                    //       },
                    //       isDense: true,
                    //       items: _sex.map((String value) {
                    //         return DropdownMenuItem<String>(
                    //           value: value,
                    //           child: Text(value),
                    //         );
                    //       }).toList(),
                    //     ),
                    //   ),
                    // ),
                    // size10,
                    size10,
                    buildField(
                      name: "Mobile No.",
                      isObsure: isPassword,
                      label: "Enter your Mobile No.",
                      inputType: TextInputType.phone,
                      controller: _password,
                      validator: (val) {
                        if (val!.isEmpty && _password.text.trim().isEmpty) {
                          return "Please Enter Mobile No.";
                        }
                        return null;
                      },
                    ),
                    Text(
                      "Enter your message",
                      style: labelStyle,
                    ),
                    size10,
                    TextFormField(
                      controller: _messageController,
                      maxLines: 8,
                      validator: (val) {
                        if (val!.isEmpty && _password.text.trim().isEmpty) {
                          return "Please Enter Your Message";
                        }
                        return null;
                      },
                      // style: textFiledStyle,
                      decoration: InputDecoration(
                        fillColor: containerBackGroundColor,
                        filled: true,
                        hintText: "Message",
                        hintStyle: sourceCodeProStyle.copyWith(
                            color: lightTextColor,
                            fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0.0)),
                          borderSide: BorderSide(
                            color: const Color(0xff012213).withOpacity(0.1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(0.0)),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                          borderSide: BorderSide(
                            color: const Color(0xff012213).withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                    // buildField(
                    //   name: "Password",
                    //   isObsure: isPassword,
                    //   label: "Enter your password",
                    //   controller: _password,
                    //   suffix: InkWell(
                    //     onTap: () {
                    //       setState(() {
                    //         isPassword = !isPassword;
                    //       });
                    //     },
                    //     child: Icon(
                    //       !isPassword ? Icons.visibility : Icons.visibility_off,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    //   validator: (val) {
                    //     if (val!.isEmpty && _password.text.trim().isEmpty) {
                    //       return "Please Enter Password";
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // buildField(
                    //   isObsure: isConfirmPassword,
                    //   name: "Confirm Password",
                    //   label: "Please Confirm  password",
                    //   controller: _confirmPassword,
                    //   validator: (val) {
                    //     if (val!.isEmpty) {
                    //       return "Please Enter Confirm password ";
                    //     } else if (_password.text.trim() !=
                    //         _confirmPassword.text.trim()) {
                    //       return "Confirm password not match with password ";
                    //     }
                    //     return null;
                    //   },
                    //   suffix: InkWell(
                    //     onTap: () {
                    //       setState(() {
                    //         isConfirmPassword = !isConfirmPassword;
                    //       });
                    //     },
                    //     child: Icon(
                    //       !isConfirmPassword
                    //           ? Icons.visibility
                    //           : Icons.visibility_off,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: SizeConfig.screenHeight! * 0.20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildField(
      {required String name,
      required String label,
      Widget? suffix,
      TextInputAction? textInputAction,
      bool? isObsure,
      TextInputType? inputType,
      String? Function(String?)? validator,
      TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: labelStyle,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextFormField(
          textInputAction: textInputAction ?? TextInputAction.next,
          suffix: suffix,
          label: label,
          inputType: inputType ?? TextInputType.text,
          obscureText: isObsure,
          validator: validator,
          controller: controller,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
