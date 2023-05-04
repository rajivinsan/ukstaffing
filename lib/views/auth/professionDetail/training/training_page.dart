import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/provider/services_provider.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/views/auth/professionDetail/training/upload_Screen.dart';
import 'package:sterling/views/widgets/progressbar_appbar.dart';

class TrainingPage extends ConsumerWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig.init(context);
    final list = ref.watch(trainingListingProvider);
    final unCompleteList =
        list.where((element) => element.isUploaded == false).toList();
    final compeletedList =
        list.where((element) => element.isUploaded == true).toList();

    return Scaffold(
      appBar: const AppBarProgress(name: "Training", progress: 0.2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Training\nCertificates",
                style: sourceCodeProStyle.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              size10,
              Text(
                "Please use the fields below to upload your training certificates",
                style: sourceSansStyle.copyWith(
                  color: lightTextColor,
                  fontSize: 18,
                ),
              ),
              size20,
              Text(
                "Required Certifcates",
                style: signUpHeadStyle,
              ),
              size20,
              unCompleteList.isEmpty
                  ? const Text("All Data updated")
                  : ListView.builder(
                      itemCount: unCompleteList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UploadScreen(
                                  id: unCompleteList[index].id,
                                  uploadCertificateName:
                                      unCompleteList[index].name,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: containerBackGroundColor,
                                borderRadius: BorderRadius.circular(
                                  24,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      color: Color.fromRGBO(0, 0, 0, 0.5))
                                ]),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    unCompleteList[index].name,
                                    style: signUpSubHeadStyle,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 4,
                                      color: kPrimaryColor,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Color(0xff861A18),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
              compeletedList.isNotEmpty
                  ? Text(
                      "Uploaded Certifcates",
                      style: signUpHeadStyle,
                    )
                  : const SizedBox.shrink(),
              size20,
              ListView.builder(
                  itemCount: compeletedList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: containerBackGroundColor,
                            borderRadius: BorderRadius.circular(
                              24,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  color: Color.fromRGBO(0, 0, 0, 0.5))
                            ]),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                compeletedList[index].name,
                                style: signUpSubHeadStyle,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 4,
                                  color: kPrimaryColor,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: Color(0xff861A18),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class CertificateModel {
  late final String name;
  late final int id;
  bool? isUploaded;

  CertificateModel(
      {required this.id, required this.name, required this.isUploaded});
  CertificateModel copWith(
      {int? percent, final String? name, final int? id, bool? isCompelete}) {
    return CertificateModel(
      id: id ?? this.id,
      isUploaded: isCompelete ?? isUploaded,
      name: name ?? this.name,
    );
  }

  factory CertificateModel.fromJson(Map<String, dynamic> jsonData) {
    return CertificateModel(
        id: jsonData['id'],
        name: jsonData['name'],
        isUploaded: jsonData['isUploaded']);
  }

  static Map<String, dynamic> toMap(CertificateModel music) => {
        'id': music.id,
        'name': music.name,
        'isUploaded': music.isUploaded,
      };
  static String encode(List<CertificateModel> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => CertificateModel.toMap(music))
            .toList(),
      );

  static List<CertificateModel> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<CertificateModel>((item) => CertificateModel.fromJson(item))
          .toList();
}
