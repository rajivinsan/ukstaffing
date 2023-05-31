import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/models/api_response.dart';
import 'package:sterling/repository/APIBase/apiFunction.dart';
import 'package:sterling/repository/APIBase/api_response.dart';

import 'package:sterling/repository/APIBase/api_url.dart';

import 'package:sterling/services/local_db_helper.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/size_config.dart';

import 'package:sterling/views/auth/professional_detail_listing.dart';

import 'package:sterling/views/bottom_bar.dart';
import 'package:sterling/views/onboarding/professional_selector_screens.dart';
import 'package:sterling/views/widgets/common_button.dart';
import 'package:sterling/views/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;

import 'forget/forgot_password_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
  bool isPassword = true;
  bool isConfirmPassword = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: const Icon(
            Icons.verified_user_outlined,
            color: Colors.black,
          ),
          title: Text("Sign IN", style: codeProHeadStyle),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildField(
                  name: "Email",
                  controller: _firstName,
                  label: "Enter your Email",
                  validator: (val) {
                    if (val!.isEmpty || _firstName.text.trim().isEmpty) {
                      return "Please Enter First Name";
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
                CommonButton(
                    name: "Login",
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        if (_firstName.text == 'demoaccount@hotmail.com' &&
                            _password.text == 'Demo@123') {
                          LocaldbHelper.saveToken(token: '15');
                          LocaldbHelper.saveSignup(isSignUp: true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomBarScreen(),
                            ),
                          );
                        } else {
                          await fetchusersbyemail(_firstName.text)
                              .then((value) {
                            if (value.isNotEmpty &&
                                value[0].pass.trim() == _password.text.trim()) {
                              LocaldbHelper.saveToken(
                                  token: value[0].cid.toString());
                              LocaldbHelper.saveSignup(isSignUp: true);
                              LocaldbHelper.saveUserName(
                                  name:
                                      "${value[0].firstName} ${value[0].lastName}");

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => value[0].status == 1
                                      ? BottomBarScreen()
                                      : ProfessionalDetailListing(
                                          pagestate: 0,
                                        ),
                                ),
                              );
                            } else {
                              "Invalid account details".showErrorAlert(context);
                            }
                          });
                        }
                      }
                    }),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()),
                        );
                      },
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(color: Colors.orange),
                      )),
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectProfessionScreen()),
                        );
                      },
                      child: Text(
                        "Don't have account? Register Now",
                        style: TextStyle(fontSize: 18),
                      )),
                )
              ],
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

// To parse this JSON data, do
//
//
//    final register = registerFromJson(jsonString);

Future<List<Register>> fetchusersbyemail(String email) async {
  final response = await http
      .get(Uri.parse(ApiUrl.apiBaseUrl + ApiUrl.signUp + '/' + email));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return registerFromJson(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

Future<http.Response?> postByid(int cid, dynamic val) async {
  try {
    final response = await http.post(
      Uri.parse(
          ApiUrl.apiBaseUrl + ApiUrl.signUp + '/Postbyid/' + cid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(val),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return response;
    }
  } catch (exception) {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print(exception);
    return null;
  }
}

Future<List<Register>> fetchbyid(dynamic id) async {
  final response = await http
      .get(Uri.parse(ApiUrl.apiBaseUrl + ApiUrl.signUp + '/Getbyid/' + id));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return registerFromJson(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

List<Register> registerFromJson(String str) =>
    List<Register>.from(json.decode(str).map((x) => Register.fromJson(x)));

String registerToJson(List<Register> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Register {
  int cid;
  String firstName;
  String lastName;
  String email;
  String pass;
  int shift;
  String postcode;
  int profession;
  int shifttype;
  DateTime dated;
  int? status;
  double? lat;
  double? lon;

  Register({
    required this.cid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.pass,
    required this.shift,
    required this.postcode,
    required this.profession,
    required this.shifttype,
    required this.dated,
    this.status,
    this.lat,
    this.lon,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        cid: json["cid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        pass: json["pass"],
        shift: json["shift"],
        postcode: json["postcode"],
        profession: json["profession"],
        shifttype: json["shifttype"],
        dated: DateTime.parse(json["dated"]),
        status: json["status"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "pass": pass,
        "shift": shift,
        "postcode": postcode,
        "profession": profession,
        "shifttype": shifttype,
        "dated": dated.toIso8601String(),
        "status": status,
        "lat": lat,
        "lon": lon,
      };
}
