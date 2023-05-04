import 'package:flutter/material.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/auth/signup_page1.dart';
import 'package:sterling/views/widgets/common_button.dart';
import 'package:sterling/views/widgets/custom_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextStyle labelStyle = sourceCodeProStyle.copyWith(
    fontSize: 16,
    color: Colors.black,
  );
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isPassword = false;
  bool isConfirmPassword = false;
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
              name: "Continue",
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage1(
                        email: _email.text.trim(),
                        firstName: _firstName.text.trim(),
                        lastName: _lastName.text.trim(),
                        password: _password.text.trim(),
                      ),
                    ),
                  );
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
                    name: "First Name",
                    controller: _firstName,
                    label: "Enter your first name",
                    validator: (val) {
                      if (val!.isEmpty || _firstName.text.trim().isEmpty) {
                        return "Please Enter First Name";
                      }
                      return null;
                    },
                  ),
                  buildField(
                    name: "Last Name",
                    label: "Enter your last name",
                    controller: _lastName,
                    validator: (val) {
                      if (val!.isEmpty || _lastName.text.trim().isEmpty) {
                        return "Please Enter Last Name";
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
                  buildField(
                    name: "Password",
                    isObsure: isPassword,
                    label: "Enter your password",
                    controller: _password,
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      child: Icon(
                        !isPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty && _password.text.trim().isEmpty) {
                        return "Please Enter Password";
                      }
                      return null;
                    },
                  ),
                  buildField(
                    isObsure: isConfirmPassword,
                    name: "Confirm Password",
                    label: "Please Confirm  password",
                    controller: _confirmPassword,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please Enter Confirm password ";
                      } else if (_password.text.trim() !=
                          _confirmPassword.text.trim()) {
                        return "Confirm password not match with password ";
                      }
                      return null;
                    },
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          isConfirmPassword = !isConfirmPassword;
                        });
                      },
                      child: Icon(
                        !isConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(
      {required String name,
      required String label,
      Widget? suffix,
      bool? isObsure,
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
          textInputAction: TextInputAction.next,
          suffix: suffix,
          label: label,
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
