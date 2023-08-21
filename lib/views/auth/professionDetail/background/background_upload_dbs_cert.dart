import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sterling/services/aws_amplify_services.dart';
import 'package:sterling/services/docs_picker_services.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/utility.dart';

import 'package:sterling/views/widgets/progressbar_appbar.dart';

import '../../../../constants/app_icon_constants.dart';
import '../../../../constants/color_constant.dart';
import '../../../../constants/text_style.dart';
import '../../../../provider/repository_provider.dart';
import '../../../../provider/services_provider.dart';

import '../../../../services/local_db_helper.dart';
import '../../../../utilities/ui/MProgressIndicator.dart';
import '../../../../utilities/ui/size_config.dart';
import '../../../widgets/contimue_button.dart';

class UploadBackgroundDBS extends ConsumerStatefulWidget {
  const UploadBackgroundDBS(
      {super.key, required this.accountName, required this.id});
  final String accountName;
  final int id;
  @override
  ConsumerState<UploadBackgroundDBS> createState() =>
      _UploadBackgroundDBSState();
}

class _UploadBackgroundDBSState extends ConsumerState<UploadBackgroundDBS> {
  String? dates;
  String? path;
  String? docsUrl;
  TextEditingController date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarProgress(name: "Upload", progress: 0.2),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Uplpad Certificate",
              style: sourceCodeProStyle.copyWith(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: textShadow,
              ),
            ),
            size20,
            size20,
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                ).then((value) {
                  if (value != null) {
                    date.text = value.toString().substring(0, 10);
                    setState(() {});
                  }
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                width: SizeConfig.screenWidth!,
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
                    Text(
                      date.text.trim().isEmpty ? 'Date' : date.text.trim(),
                      style: codeProHeadStyle.copyWith(
                          color: kLightTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    SvgPicture.asset(SvgAsset.calender)
                  ],
                ),
              ),
            ),
            size20,
            InkWell(
              onTap: () {
                showBottomSheet(context);
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
                        path != null ? path! : "Add Certificate",
                        style: signUpSubHeadStyle.copyWith(
                          color: kLightTextColor,
                          overflow: TextOverflow.ellipsis,
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
            Utility.vSize(30),
            // Center(
            //   child: Text.rich(
            //     TextSpan(
            //       children: [
            //         TextSpan(
            //           text: "If you don’t have DBS apply with us",
            //           style: sourceCodeProStyle.copyWith(fontSize: 17),
            //         ),
            //         TextSpan(
            //           text: ' email to support ',
            //           style: sourceCodeProStyle.copyWith(fontSize: 17),
            //         ),
            //         TextSpan(
            //           text: "@xyz.com",
            //           style: sourceCodeProStyle.copyWith(
            //               fontSize: 17,
            //               color: const Color.fromRGBO(35, 106, 242, 1)),
            //         )
            //       ],
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            const Spacer(),
            ContinueBotton(onTap: () {
              if (path == null) {
                "Please Upload Certificate".showErrorAlert(context);
              } else {
                uploadInS3AndgetUrl(ref);
              }
            })
          ],
        ),
      ),
    );
  }

  openCalender(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now());

    if (date != null) {
      setState(() {
        dates = date.toString().substring(0, 10);
      });
    }
  }

  uploadInS3AndgetUrl(WidgetRef ref) {
    MProgressIndicator.show(context);
    AwsS3Configuration.upload(path: path!).then((value) {
      if (value != "") {
        MProgressIndicator.hide();
        setState(() {
          docsUrl = value;
        });
        updateBackground(ref);
      }
    });
  }

  updateBackground(WidgetRef ref) {
    MProgressIndicator.show(context);
    ref
        .read(authRepositoryProvider)
        .backgroundChecks(
            accountName: widget.accountName,
            doc: docsUrl!,
            date: date.text.trim())
        .then(
      (value) {
        MProgressIndicator.hide();
        if (value.success) {
          ref.read(listingProvider.notifier).updateProfessionList(widget.id);
          LocaldbHelper.saveListingDetails(
            list: ref.watch(listingProvider),
          );
          "Record Save Succesfully".showSuccessAlert(context);
          // value.message.showSuccessAlert(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          value.message.showErrorAlert(context);
        }
      },
    );
  }

  showBottomSheet(BuildContext context) {
    SizeConfig.init(context);
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              size20,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    DocsPickerServices.getImages(index: 0).then((value) {
                      setState(() {
                        path = value;
                      });
                    });
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Select From Camera",
                        style: sourceSansStyle.copyWith(
                            color: lightTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              size20,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    DocsPickerServices.getImages(index: 1, isImage: false)
                        .then((value) {
                      setState(() {
                        path = value;
                      });
                    });
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.file_present_rounded,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Select From Gallery",
                        style: sourceSansStyle.copyWith(
                            color: lightTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              size20,
            ],
          );
        });
  }
}
