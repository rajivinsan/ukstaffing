import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/provider/repository_provider.dart';
import 'package:sterling/services/aws_amplify_services.dart';
import 'package:sterling/services/docs_picker_services.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/MProgressIndicator.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/widgets/contimue_button.dart';
import 'package:sterling/views/widgets/progressbar_appbar.dart';

import '../../../../constants/color_constant.dart';
import '../../../../provider/services_provider.dart';
import '../../../../services/local_db_helper.dart';

class IdBadgePage extends ConsumerStatefulWidget {
  const IdBadgePage({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  ConsumerState<IdBadgePage> createState() => _IdBadgePageState();
}

class _IdBadgePageState extends ConsumerState<IdBadgePage> {
  String? docsPath;
  String? photo;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: const AppBarProgress(name: "ID Badge", progress: 0.2),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ContinueBotton(onTap: () {
          if (docsPath == null) {
            showBottomSheet(context);
          } else {
            uploadInS3AndgetUrl(ref);
          }
        }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ID Badge",
                style: sourceCodeProStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              size20,
              Text(
                "We need a photo for your Sterling Id badge. your face should be fully visible and the photo taken against a white or light background. Don't forget to smile!",
                style: signUpSubHeadStyle,
              ),
              size20,
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AppImages.badgeBorder),
                  Container(
                    height: SizeConfig.screenWidth! * 0.6,
                    padding: const EdgeInsets.all(20),
                    child: Center(
                        child: docsPath == null
                            ? Image.asset(
                                AppImages.badgeIcon,
                              )
                            : Image.file(File(docsPath!))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
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
                  onTap: () async {
                    final path = await DocsPickerServices.getImages(index: 0);
                    if (path != null) {
                      setState(() {
                        docsPath = path;
                      });
                      Navigator.pop(context);
                    }
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
                  onTap: () async {
                    final path = await DocsPickerServices.getImages(index: 1);
                    if (path != null) {
                      setState(() {
                        docsPath = path;
                      });
                      Navigator.pop(context);
                    }
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

  uploadInS3AndgetUrl(WidgetRef ref) {
    MProgressIndicator.show(context);
    AwsS3Configuration.upload(path: docsPath!).then((value) {
      if (value != "") {
        AwsS3Configuration.getUrl(key: value).then((value) {
          if (value != "") {
            MProgressIndicator.hide();
            setState(() {
              photo = value;
            });

            uploadIdbadge(ref: ref);
          }
        });
      }
    });
  }

  uploadIdbadge({required WidgetRef ref}) {
    MProgressIndicator.show(context);
    ref.read(authRepositoryProvider).posIdBadge(photo: photo!).then(
      (value) {
        MProgressIndicator.hide();
        if (value.success) {
          value.message.showErrorAlert(context);
          ref.read(listingProvider.notifier).updateProfessionList(widget.id);
          LocaldbHelper.saveListingDetails(
            list: ref.watch(listingProvider),
          );
          value.message.showSuccessAlert(context);
          Navigator.pop(context);
        } else {
          value.message.showErrorAlert(context);
        }
      },
    );
  }
}
