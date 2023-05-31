import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sterling/services/local_db_helper.dart';

import 'package:sterling/views/auth/professional_detail_listing.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/color_constant.dart';
import '../../constants/text_style.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String uname = "";
  @override
  void initState() {
    usname();
    super.initState();
  }

  void usname() async {
    var u = await LocaldbHelper.getUserName();
    setState(() {
      uname = u!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(
            "My Profile",
            style: codeProHeadStyle.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          backgroundColor: const Color(0xffF3F3F3),
          elevation: 1,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          //   controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.orangeAccent,
                            child: Icon(Icons.person, size: 50),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            uname.toUpperCase(),
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            ListTile(
                              //contentPadding: EdgeInsets.only(left: 9, right: 0.0),
                              //horizontalTitleGap: 9,
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        //pagestate 1 for record update
                                        ProfessionalDetailListing(
                                      pagestate: 1,
                                    ),
                                  ),
                                );
                              },
                              //minLeadingWidth: 1,
                              iconColor: Colors.red,
                              title: Text("Edit My Profile",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              leading: Icon(
                                Icons.person,
                                color: kPrimaryColor,
                              ),
                            ),
                            // ListTile(
                            //   //contentPadding: EdgeInsets.only(left: 9, right: 0.0),
                            //   //horizontalTitleGap: 9,
                            //   onTap: () async {},
                            //   //minLeadingWidth: 1,
                            //   iconColor: Colors.red,
                            //   title: Text("Notification",
                            //       style: TextStyle(
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w600)),
                            //   leading: Icon(
                            //     Icons.message,
                            //     color: kPrimaryColor,
                            //   ),
                            // ),
                            // ListTile(
                            //   //contentPadding: EdgeInsets.only(left: 9, right: 0.0),
                            //   //horizontalTitleGap: 9,
                            //   onTap: () async {},
                            //   //minLeadingWidth: 1,
                            //   iconColor: Colors.red,
                            //   title: Text("About Us",
                            //       style: TextStyle(
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w600)),
                            //   leading: Icon(
                            //     Icons.attachment,
                            //     color: kPrimaryColor,
                            //   ),
                            // ),
                            ListTile(
                              //contentPadding: EdgeInsets.only(left: 9, right: 0.0),
                              //horizontalTitleGap: 9,
                              onTap: () async {
                                Share.share(
                                    "Welcome to Sterling Staffing App, Install the app : https://play.google.com/store/apps/details?id=staffing.com.sterling&pli=1");
                              },
                              //minLeadingWidth: 1,
                              iconColor: Colors.red,
                              title: Text("Refer a friend",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              leading: Icon(
                                Icons.share,
                                color: kPrimaryColor,
                              ),
                            ),
                            ListTile(
                              //contentPadding: EdgeInsets.only(left: 9, right: 0.0),
                              //horizontalTitleGap: 9,
                              onTap: () async {
                                const url =
                                    'https://play.google.com/store/apps/details?id=staffing.com.sterling&pli=1';
                                if (!await launchUrl(Uri.parse(url))) {
                                  throw Exception('Could not launch');
                                }
                              },
                              //minLeadingWidth: 1,
                              iconColor: Colors.red,
                              title: Text("Rate our app",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              leading: Icon(
                                Icons.star,
                                color: kPrimaryColor,
                              ),
                            ),
                            ListTile(
                              //contentPadding: EdgeInsets.only(left: 9, right: 0.0),
                              //horizontalTitleGap: 9,
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                var d = prefs.clear();
                                if (await d) {
                                  Navigator.pushReplacementNamed(
                                      context, '/loginpage');
                                }
                              },
                              //minLeadingWidth: 1,
                              iconColor: Colors.red,
                              title: Text("Logout",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              leading: Icon(
                                Icons.logout_rounded,
                                color: kPrimaryColor,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
    // Scaffold(

    //   body: const Center(child: Text("User Profile")),
    // );
  }

  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var d = prefs.clear();
    if (await d) {
      Navigator.pushReplacementNamed(context, '/loginpage');
    }
  }

  buildTile(BuildContext context, String name, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 15, top: 15),
      child: Row(
        children: [
          Icon(
            icon,
            color: kPrimaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          const Spacer(),
        ],
      ),
    );
  }
}
