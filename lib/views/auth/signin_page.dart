import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/repository/APIBase/apiFunction.dart';
import 'package:sterling/repository/APIBase/api_url.dart';

import 'package:sterling/services/local_db_helper.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/auth/professional_detail_listing.dart';
import 'package:sterling/views/auth/signup_page1.dart';
import 'package:sterling/views/bottom_bar.dart';
import 'package:sterling/views/widgets/common_button.dart';
import 'package:sterling/views/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import '../home/dashboard_home_scree.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomBarScreen(),
                            ),
                          );
                        } else {
                          await fetchusers(_firstName.text).then((value) {
                            if (value[0].pass.trim() == _password.text.trim()) {
                              LocaldbHelper.saveToken(
                                  token: value[0].cid.toString());
                              LocaldbHelper.saveSignup(isSignUp: true);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomBarScreen(),
                                ),
                              );
                            }
                          });
                        }
                      }
                    })
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

Future<List<Register>> fetchusers(String email) async {
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
