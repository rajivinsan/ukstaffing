import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/views/auth/forget/update_password_screen.dart';
import 'package:sterling/views/auth/signin_page.dart';

enum AuthMode { forgot, verify }

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool submitValid = false;
  AuthMode _authMode = AuthMode.forgot;
  late int RandOtp;
  bool loading = false;
  dynamic cid;
  int opt = 0;
  final TextEditingController _otpController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  void initState() {
    super.initState();
  }

  bool verify() {
    return (RandOtp.toString() == _otpController.text) ? true : false;
  }

  int generateRandom() {
    int min = 11000;
    int max = 99999;

    return min + Random().nextInt((max + 1) - min);
  }

  void sendOtp() async {}

  void sendResetLink(BuildContext context) async {
    final smtpServer = gmail('sterlingstaffing8@gmail.com', 'bzdmcrdcgyirrfrf');
    // Replace 'your_email@gmail.com' and 'your_password' with your actual email and password
    RandOtp = generateRandom();
    final message = Message()
      ..from = const Address('sterlingstaffing8@gmail.com')
      ..recipients.add(_emailController.text)
      ..subject = 'Password Reset'
      ..text = 'Verification Code for email verification: ${RandOtp}';

    try {
      final sendReport = await send(message, smtpServer);
      setState(() {
        submitValid = true;
        loading = false;
      });

      "reset link sent on email".showInfoAlert(context);
    } catch (e) {
      print('Error sending email: $e');
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to send reset link. Please try again.'),
      ));
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.forgot) {
      setState(() {
        _authMode = AuthMode.verify;
      });
    } else {
      setState(() {
        _authMode = AuthMode.forgot;
      });
    }
  }

  final Formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: Formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _authMode == AuthMode.forgot
                    ? 'Forgot Your Password?'
                    : 'Verify Your Email',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                _authMode == AuthMode.forgot
                    ? 'Enter the Email address associated with'
                    : 'Please enter the 6 digit code sent to',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Text(
                _authMode == AuthMode.forgot
                    ? 'your account'
                    : _emailController.text,
                style: TextStyle(fontSize: 17)),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: _authMode == AuthMode.forgot
                  ? TextFormField(
                      decoration: InputDecoration(
                          suffix: loading
                              ? CircularProgressIndicator(
                                  color: Colors.orangeAccent,
                                )
                              : null,
                          contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: Colors.white24)),
                          labelText: 'Email',
                          labelStyle: TextStyle(fontWeight: FontWeight.w500),
                          enabled: !loading),
                      controller: _emailController,
                      validator: (value) {
                        if (_emailController.text.isEmpty) {
                          return "Enter email account";
                        }
                        if (!_emailController.text.trim().isEmail()) {
                          return "Please Enter valid email";
                        }
                      },
                      // ignore: missing_return
                    )
                  : (submitValid)
                      ? TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                borderSide: BorderSide(color: Colors.white24)),
                            labelText: 'Code',
                            labelStyle: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          controller: _otpController,
                          validator: (value) {
                            if (_otpController.text.isEmpty) {
                              return "Enter verification code";
                            }
                          },
                          // ignore: missing_return
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
            ),
            SizedBox(
              height: _authMode == AuthMode.forgot ? 50 : 30,
            ),
            if (_authMode == AuthMode.verify)
              MaterialButton(
                  onPressed: () {
                    sendResetLink(context);
                  },
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                      fontSize: 17,
                      letterSpacing: 1,
                      shadows: [
                        Shadow(color: Colors.indigo, offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.indigo,
                      decorationThickness: 2,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  )),
            SizedBox(
              height: 40,
              width: 285,
              child: MaterialButton(
                child: Text(
                    _authMode == AuthMode.forgot ? 'Verify Email' : 'Confirm'),
                onPressed: () async {
                  if (_authMode == AuthMode.forgot) {
                    //sendOtp();
                    if (Formkey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      var response =
                          await fetchusersbyemail(_emailController.text);
                      if (response.isNotEmpty) {
                        sendResetLink(context);
                        _switchAuthMode();

                        setState(() {
                          cid = response[0].cid;
                          loading = false;
                        });
                      } else {
                        setState(() {
                          loading = false;
                        });
                        "Invalid account details".showErrorAlert(context);
                      }
                    }
                  } else {
                    if (Formkey.currentState!.validate()) {
                      if (verify()) {
                        _otpController.clear();
                        // Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UpdatePassword(
                                  cid: cid,
                                )));
                      } else {
                        "Invalid code".showErrorAlert(context);
                      }
                    }
                    //getCurrentUser();
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                color: Colors.indigo.shade600,
                textColor: Theme.of(context).primaryTextTheme.button!.color,
              ),
            ),
            SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
}
