import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/provider/services_provider.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/auth/professionDetail/NMC/nmc_page.dart';
import 'package:sterling/views/auth/professionDetail/bankdetails/getting_paid_page.dart';
import 'package:sterling/views/auth/professionDetail/idbadge/id_badge_page.dart';
import 'package:sterling/views/auth/professionDetail/kin/next_of_kin_page.dart';
import 'package:sterling/views/auth/professionDetail/personaldeails/perosonal_detail_page.dart';
import 'package:sterling/views/auth/professionDetail/references/reference_page.dart';
import 'package:sterling/views/auth/professionDetail/training/training_page.dart';
import 'package:sterling/views/auth/professionDetail/workhistory/work_details_screen.dart';
import 'package:sterling/views/spalsh_screen.dart';
import 'package:sterling/views/widgets/common_button.dart';

import '../../services/local_db_helper.dart';
import '../bottom_bar.dart';
import 'professionDetail/background/background_main_screen.dart';

class ProfessionalDetailListing extends ConsumerWidget {
  const ProfessionalDetailListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    double overallProgress;
    final list = ref.watch(listingProvider);
    final unCompleteList =
        list.where((element) => element.isCompelete == false).toList();
    final compeletedList =
        list.where((element) => element.isCompelete == true).toList();

    if (compeletedList.isEmpty) {
      overallProgress = 0.0;
    } else {
      overallProgress = (compeletedList.length / list.length) * 100.floor();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "All Details",
          style: sourceCodeProStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: kPrimaryColor,
          ),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: KAppbarbackgroundColor,
        actions: [
          InkWell(
            onTap: () {
              LocaldbHelper.removeAllSharedPref();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SplashScreen()));
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Sign Out",
                      style: sourceSansStyle.copyWith(
                          color: kLightTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.logout,
                      color: kLightTextColor,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          LocaldbHelper.getToken().then((value) {
            print(value);
          });
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => BottomBarScreen()));
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.message,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: scaffoldBg,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Overall Progress",
                style: sourceCodeProStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              size20,
              Center(
                child: Text(
                  " ${overallProgress.ceil().toString()} %",
                  style: sourceCodeProStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 10,
                  child: LinearProgressIndicator(
                    color: kPrimaryColor,
                    value: overallProgress / 100, // percent filled
                    // valueColor: AlwaysStoppedAnimation<Color>(
                    //     kPrimaryColor.withOpacity(0.1)),
                    backgroundColor: kPrimaryColor.withOpacity(0.4),
                  ),
                ),
              ),
              size20,
              unCompleteList.isEmpty
                  ? const Text("All Data updated")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: unCompleteList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            switch (unCompleteList[index].id) {
                              case 1:
                                navigate(
                                    PerosnalDetailPage(
                                        id: unCompleteList[index].id),
                                    context);
                                break;
                              case 2:
                                navigate(const TrainingPage(), context);
                                break;
                              case 3:
                                navigate(
                                    WorkDetailsScreen(
                                        id: unCompleteList[index].id),
                                    context);
                                break;
                              case 4:
                                navigate(
                                  ReferencePage(
                                    id: unCompleteList[index].id,
                                  ),
                                  context,
                                );
                                break;
                              case 5:
                                navigate(
                                  GettingPage(
                                    id: unCompleteList[index].id,
                                  ),
                                  context,
                                );
                                break;
                              case 6:
                                navigate(
                                    BackGroundMainScreen(
                                      id: unCompleteList[index].id,
                                    ),
                                    context);

                                break;
                              case 7:
                                navigate(
                                    IdBadgePage(id: unCompleteList[index].id),
                                    context);
                                break;
                              case 8:
                                // "Page in progress wait!".showErrorAlert(context);
                                navigate(NmcPage(id: unCompleteList[index].id),
                                    context);
                                break;
                              case 9:
                                navigate(
                                    NextOfKinPage(id: unCompleteList[index].id),
                                    context);
                                break;
                              default:
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(
                                        0,
                                        4,
                                      ),
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      color: Color.fromRGBO(0, 0, 0, 0.5)),
                                ],
                                color: containerBackGroundColor),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    unCompleteList[index].name!,
                                    style: codeProHeadStyle.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        value: 0.0,
                                        color: kPrimaryColor,
                                        backgroundColor: const Color.fromRGBO(
                                            255, 255, 255, 0.4),
                                      ),
                                      Text(
                                        "0%",
                                        style: codeProHeadStyle.copyWith(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              Text(
                "Compeleted Details",
                style: sourceCodeProStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: compeletedList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(
                                  0,
                                  4,
                                ),
                                blurRadius: 4,
                                spreadRadius: 0,
                                color: Color.fromRGBO(0, 0, 0, 0.5)),
                          ],
                          color: const Color(0xffB0FFAE)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              compeletedList[index].name!,
                              style: codeProHeadStyle.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(2),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: const Color(
                                        0xff236AF2,
                                      ),
                                      width: 4)),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(
                                    0xff236AF2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              size20,
              CommonButton(
                  name: "Submit",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomBarScreen()));
                  })
            ],
          ),
        ),
      ),
    );
  }

  navigate(Widget child, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => child));
  }
}
