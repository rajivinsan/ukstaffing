import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/app_constant.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/services/docs_picker_services.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/widgets/contimue_button.dart';

import '../../../../provider/repository_provider.dart';
import '../../../../provider/services_provider.dart';
import '../../../../services/aws_amplify_services.dart';
import '../../../../services/local_db_helper.dart';
import '../../../../utilities/ui/MProgressIndicator.dart';
import '../../../widgets/progressbar_appbar.dart';

class UploadScreen extends ConsumerStatefulWidget {
  const UploadScreen(
      {super.key,
      required this.uploadCertificateName,
      required this.id,
      required this.pagestate});
  final String uploadCertificateName;

  final int id;

  final int pagestate;
  @override
  ConsumerState<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends ConsumerState<UploadScreen> {
  String? dates;
  String? url;
  String? docs;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: const AppBarProgress(name: "Upload", progress: 0.2),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.uploadCertificateName,
              style: sourceCodeProStyle.copyWith(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: textShadow,
              ),
            ),
            size20,
            size20,
            // InkWell(
            //   onTap: () {
            //     openCalender();
            //   },
            //   child: Container(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            //     width: SizeConfig.screenWidth!,
            //     decoration: BoxDecoration(
            //         color: containerBackGroundColor,
            //         boxShadow: const [
            //           BoxShadow(
            //             offset: Offset(0, 4),
            //             blurRadius: 4,
            //             spreadRadius: 0,
            //             color: Color.fromRGBO(
            //               0,
            //               0,
            //               0,
            //               0.5,
            //             ),
            //           )
            //         ],
            //         borderRadius: BorderRadius.circular(10)),
            //     child: Row(
            //       children: [
            //         Text(
            //           dates == null ? 'Date' : dates!,
            //           style: codeProHeadStyle.copyWith(
            //               color: kLightTextColor,
            //               fontSize: 18,
            //               fontWeight: FontWeight.bold),
            //         ),
            //         const Spacer(),
            //         SvgPicture.asset(SvgAsset.calender)
            //       ],
            //     ),
            //   ),
            // ),
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
                        docs == null ? "Upload" : docs!,
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
            const Spacer(),
            ContinueBotton(onTap: () {
              if (docs != null) {
                uploadDoc();
              }
            })
          ],
        ),
      ),
    );
  }

  openCalender() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        dates = date.toString().substring(0, 10);
      });
    }
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
                        docs = value;
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
                        docs = value;
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

  uploadDoc() {
    MProgressIndicator.show(context);
    AwsS3Configuration.upload(path: docs!).then((value) {
      if (value != "") {
        AwsS3Configuration.getUrl(key: value).then((value) {
          //insert new doc
          if (value != "" && widget.pagestate == 0) {
            MProgressIndicator.hide();
            setState(() {
              url = value;
            });

            ref
                .read(authRepositoryProvider)
                .uploadDoc(
                    cid: 2, docType: widget.uploadCertificateName, url: url!)
                .then((value) {
              MProgressIndicator.hide();
              if (value.success) {
                value.message.showSuccessAlert(context);
                ref
                    .read(trainingListingProvider.notifier)
                    .updateProfessionList(widget.id);
                LocaldbHelper.saveTrainingListingDetails(
                    list: ref.watch(trainingListingProvider));
                final trainglist = ref.watch(trainingListingProvider);
                final traingunCompleteList = trainglist
                    .where((element) => element.isUploaded == false)
                    .toList();
                final traingcompeletedList = trainglist
                    .where((element) => element.isUploaded == true)
                    .toList();
                if (traingcompeletedList.length == certificationList.length) {
                  ref.read(listingProvider.notifier).updateProfessionList(2);
                  LocaldbHelper.saveListingDetails(
                    list: ref.watch(listingProvider),
                  );
                }
                Navigator.pop(context);
              } else {
                value.message.showErrorAlert(context);
              }
            });
          }

          //update existing doc
          if (value != "" && widget.pagestate == 1) {
            MProgressIndicator.hide();
            setState(() {
              url = value;
            });

            ref
                .read(authRepositoryProvider)
                .updateuploadDoc(
                    cid: 2, docType: widget.uploadCertificateName, url: url!)
                .then((value) {
              MProgressIndicator.hide();
              if (value.success) {
                value.message.showSuccessAlert(context);
                ref
                    .read(trainingListingProvider.notifier)
                    .updateProfessionList(widget.id);
                LocaldbHelper.saveTrainingListingDetails(
                    list: ref.watch(trainingListingProvider));
                final trainglist = ref.watch(trainingListingProvider);
                final traingunCompleteList = trainglist
                    .where((element) => element.isUploaded == false)
                    .toList();
                final traingcompeletedList = trainglist
                    .where((element) => element.isUploaded == true)
                    .toList();
                if (traingcompeletedList.length == certificationList.length) {
                  ref.read(listingProvider.notifier).updateProfessionList(2);
                  LocaldbHelper.saveListingDetails(
                    list: ref.watch(listingProvider),
                  );
                }
                Navigator.pop(context);
              } else {
                value.message.showErrorAlert(context);
              }
            });
          }
        });
      }
    });
  }
}
