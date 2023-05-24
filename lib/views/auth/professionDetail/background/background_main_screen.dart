import 'package:flutter/material.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/utility.dart';
import 'package:sterling/views/auth/professionDetail/background/background_upload_dbs_cert.dart';
import 'package:sterling/views/widgets/custom_text_form_field.dart';

import '../../../../utilities/ui/size_config.dart';
import '../../../widgets/contimue_button.dart';
import '../../../widgets/progressbar_appbar.dart';

class BackGroundMainScreen extends StatefulWidget {
  const BackGroundMainScreen({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<BackGroundMainScreen> createState() => _BackGroundMainScreenState();
}

class _BackGroundMainScreenState extends State<BackGroundMainScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: const AppBarProgress(name: "Background Check", progress: 0.2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Utility.vSize(SizeConfig.screenHeight! * 0.10),
              Text(
                "Upload Certificate",
                style: sourceCodeProStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              size20,
              Text(
                "Are you registered on the DBS update service",
                style: sourceCodeProStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              size20,
              CustomTextFormField(
                controller: _controller,
                label: 'Account Name',
              ),
              size20,
              size20,
              // Container(
              //   padding: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(
              //       color: kPrimaryColor,
              //     ),
              //   ),
              //   child: Text(
              //     "If your certificate was issued before 11 May 2021, please get in touch with the team on our live chat in the right corner of your screen.",
              //     style: sourceCodeProStyle.copyWith(
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
              // size20,
              InkWell(
                onTap: () {
                  navigate();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: containerBackGroundColor,
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                          color: Color.fromRGBO(
                            0,
                            0,
                            0,
                            0.5,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Upload",
                          style: signUpSubHeadStyle.copyWith(
                            color: kLightTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.camera_alt,
                        color: kPrimaryColor,
                      )
                    ],
                  ),
                ),
              ),
              size20,
              size20,
              ContinueBotton(onTap: () {
                navigate();
              })
            ],
          ),
        ),
      ),
    );
  }

  navigate() {
    if (_controller.text.trim().isEmpty) {
      "Please Enter Account Name".showErrorAlert(context);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UploadBackgroundDBS(
                    id: widget.id,
                    accountName: _controller.text.trim(),
                  )));
    }
  }
}
