import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sterling/constants/app_icon_constants.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/provider/repository_provider.dart';
import 'package:sterling/routes/screen_routes.dart';
import 'package:sterling/utilities/extensions/Extensions.dart';
import 'package:sterling/utilities/ui/MProgressIndicator.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/widgets/contimue_button.dart';
import 'package:sterling/views/widgets/progressbar_appbar.dart';

import '../../../../provider/services_provider.dart';
import '../../../../services/local_db_helper.dart';

class WorkDetailsScreen extends ConsumerWidget {
  const WorkDetailsScreen({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    final workExperienceProvider = ref.watch(workListProvider);
    return Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ContinueBotton(onTap: () {
            if (ref.read(workListProvider).isNotEmpty) {
              MProgressIndicator.show(context);
              ref
                  .read(authRepositoryProvider)
                  .addWorkExperience(list: ref.read(workListProvider))
                  .then((value) {
                if (value.success) {
                  MProgressIndicator.hide();
                  value.message.showSuccessAlert(context);
                  ref.read(listingProvider.notifier).updateProfessionList(id);
                  LocaldbHelper.saveListingDetails(
                    list: ref.watch(listingProvider),
                  );
                  Navigator.pop(context);
                } else {
                  MProgressIndicator.hide();
                  value.message.showErrorAlert(context);
                }
              });
            }
          }),
        ),
        appBar: const AppBarProgress(
          name: "Work history",
          progress: 0.3,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Add Work Experience",
                textAlign: TextAlign.justify,
                style: sourceCodeProStyle.copyWith(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              size20,
              Text(
                "Please include any temperary work and any agencies that you've worked with you",
                style: sourceSansStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              size20,
              for (var item in workExperienceProvider)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.employerName,
                              style: codeProHeadStyle.copyWith(fontSize: 16),
                            ),
                            Row(
                              children: [
                                Text(
                                  item.startDate,
                                  style: sourceCodeProStyle.copyWith(
                                      color: lightTextColor, fontSize: 12),
                                ),
                                item.endDate == null || item.endDate == ""
                                    ? const SizedBox.shrink()
                                    : Text(
                                        " - ",
                                        style: sourceCodeProStyle.copyWith(
                                            color: lightTextColor,
                                            fontSize: 12),
                                      ),
                                Text(
                                  item.endDate == null ? "" : item.endDate!,
                                  style: sourceCodeProStyle.copyWith(
                                      color: lightTextColor, fontSize: 12),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          ref.read(workListProvider.notifier).removeWork(item);
                        },
                        child: SvgPicture.asset(SvgAsset.delete))
                  ],
                ),
              size20,
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ScreenRoute.addWorkExperiemce);
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: kPrimaryColor),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                ),
              ),
            ]),
          ),
        ));
  }
}
