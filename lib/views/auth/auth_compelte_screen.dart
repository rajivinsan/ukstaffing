import 'package:flutter/material.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/auth/professional_detail_listing.dart';
import 'package:sterling/views/widgets/contimue_button.dart';

class AuthCompelteScreen extends StatelessWidget {
  const AuthCompelteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    var height = SizeConfig.screenHeight!;
    var width = SizeConfig.screenWidth!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: klightGreenColor,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        left: false,
        child: Column(
          children: [
            size20,
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                AppImages.globe,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: klightGreenColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(
                      40,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    size20,
                    Text(
                      "Profession",
                      style: codeProHeadStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        "Awesome work that means you are one step close to being completed !",
                        style: sourceCodeProStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    size20,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        AppImages.compelte,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ContinueBotton(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfessionalDetailListing(
                                      pagestate: 0,
                                    )),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
