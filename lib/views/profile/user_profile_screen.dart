import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';
import '../../constants/text_style.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

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
                        children: const [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.tealAccent,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Amit Sharma",
                          ),
                        ],
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),

                            buildTile(context, () {}, "Edit My Profile",
                                Icons.person),
                            buildTile(
                              context,
                              () {},
                              "Notification",
                              Icons.notifications,
                            ),
                            buildTile(
                                context, () {}, "About us", Icons.attachment),
                            buildTile(context, () {}, "Refer a friend",
                                Icons.message),
                            buildTile(
                                context, () {}, "Rate our app", Icons.star),

                            buildTile(context, () {}, "Log out ", Icons.logout),

                            //
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

  buildTile(
      BuildContext context, Function()? onTap, String name, IconData icon) {
    return InkWell(
      onTap: onTap,
      child: Padding(
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
      ),
    );
  }
}
