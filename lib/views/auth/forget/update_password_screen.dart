import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/views/auth/signin_page.dart';

class UpdatePassword extends StatefulWidget {
  UpdatePassword({required this.cid});

  final int cid;
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController _passController = TextEditingController();

  final TextEditingController _confirmPassController = TextEditingController();

  bool _isloading = false;

  final Formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: Formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Create New Password?',
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Your new password must be 6 digits or more ',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide: BorderSide(color: Colors.white24)),
                        labelText: 'New Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      validator: (value) {
                        if (_passController.text.length < 6) {
                          return "Password lenght should be 6 digits";
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _passController.text = value;
                        });
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 8, 8, 8),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide: BorderSide(color: Colors.white24)),
                        labelText: 'Confirm New Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                      ),

                      validator: (value) {
                        if (_passController.text ==
                            _confirmPassController.text) {
                        } else {
                          return "New password and Confirm Password not matched";
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _confirmPassController.text = value;
                        });
                      },
                      // ignore: missing_return
                    )),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 40,
                  width: 285,
                  child: _isloading
                      ? Center(child: CircularProgressIndicator())
                      : MaterialButton(
                          child: Text('Reset Password'),
                          onPressed: () {
                            if (!Formkey.currentState!.validate()) {
                              return;
                            }
                            setState(() {
                              _isloading = true;
                            });

                            Map<String, dynamic> reg() => {
                                  "cid": widget.cid,
                                  "pass": _passController.text,
                                };
                            print(widget.cid);

                            if (_passController.text ==
                                _confirmPassController.text) {
                              postByid(widget.cid, reg());

                              setState(() {
                                _isloading = false;
                              });
                              "Password Reset Successfully"
                                  .showSuccessAlert(context);

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()));
                              //Navigator.of(context).pop();
                            } else {}
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0),
                          color: Colors.indigo.shade600,
                          textColor:
                              Theme.of(context).primaryTextTheme.button!.color,
                        ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
