import 'package:flutter/material.dart';
import 'package:sterling/constants/app_constant.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/ui/size_config.dart';
import 'package:sterling/utilities/ui/utility.dart';
import 'package:sterling/views/widgets/common_button.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final bool _value = false;

  String shifttype = "Day";
  List<RadioCheckModel> roleChecked = [
    RadioCheckModel(name: "Carer", isSelected: false),
    RadioCheckModel(name: "Support Worker", isSelected: false),
  ];
  List<RadioCheckModel> shiftChecked = [
    RadioCheckModel(name: "Night", isSelected: false),
    RadioCheckModel(name: "Day", isSelected: false),
  ];
  TextStyle headStyle = redHatMedium.copyWith(fontSize: 21);
  TextStyle subStyle = redHatNormal.copyWith(fontSize: 16);

  List<String> days = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];
  int selectedDays = 2;
  int selectedLoc = 0;

  List<RadioCheckModel> shiftLoc = [
    RadioCheckModel(name: "All Care Location", isSelected: false),
    RadioCheckModel(name: "Favourite Only", isSelected: false),
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Text(
              "Filter",
              style: redHatbold.copyWith(
                color: kPrimaryColor,
                fontSize: 24,
              ),
            ),
            const Spacer(),
            Text(
              "Clear all",
              style: redHatbold.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: SizeConfig.screenHeight! * 0.12,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CommonButton(
              name: "Show Shifts",
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   AppConstant.whichRoleWork,
              //   style: headStyle,
              // ),
              // for (int i = 0; i < roleChecked.length; i++)
              //   MediaQuery.removePadding(
              //     context: context,
              //     removeLeft: true,
              //     child: Theme(
              //       data: Theme.of(context).copyWith(
              //         unselectedWidgetColor:
              //             const Color.fromRGBO(11, 95, 255, 0.5),
              //       ),
              //       child: Row(
              //         children: [
              //           Checkbox(
              //             activeColor: const Color(0xff0B5FFF),
              //             value: roleChecked[i].isSelected,
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(2)),
              //             splashRadius: 2,
              //             onChanged: (value) {
              //               setState(() {
              //                 roleChecked[i].isSelected =
              //                     !roleChecked[i].isSelected!;
              //               });
              //             },
              //           ),
              //           Text(
              //             roleChecked[i].name,
              //             style: subStyle,
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // size20,
              Text(
                AppConstant.whichShiftPref,
                style: headStyle,
              ),
              for (int i = 0; i < shiftChecked.length; i++)
                MediaQuery.removePadding(
                  context: context,
                  removeLeft: true,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor:
                          const Color.fromRGBO(11, 95, 255, 0.5),
                    ),
                    child: Row(
                      children: [
                        Radio(
                          value: shiftChecked[i].name,
                          groupValue: shifttype,
                          onChanged: (value) {
                            setState(() {
                              shifttype = value.toString();
                            });
                          },
                        ),

                        // Checkbox(
                        //   activeColor: const Color(0xff0B5FFF),
                        //   value: shiftChecked[i].isSelected,
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(2)),
                        //   splashRadius: 2,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       shiftChecked[i].isSelected =
                        //           !shiftChecked[i].isSelected!;
                        //     });
                        //   },
                        // ),
                        Text(
                          shiftChecked[i].name,
                          style: subStyle,
                        )
                      ],
                    ),
                  ),
                ),
              size20,
              Text(
                AppConstant.whatDaysOfWeek,
                style: headStyle,
              ),
              size10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < days.length; i++)
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedDays = i;
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                selectedDays == i ? kbluteColor : Colors.white,
                            border: Border.all(
                              color: kbluteColor,
                            ),
                          ),
                          child: Text(
                            days[i],
                            style: subStyle.copyWith(
                              color: selectedDays == i
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )),
                    )
                ],
              ),
              size20,
              Text(
                AppConstant.minmumrate,
                style: headStyle,
              ),
              size10,
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kbluteColor),
                ),
                child: Text(
                  "All",
                  style: subStyle,
                ),
              ),
              size20,
              Text(
                AppConstant.travelWilling,
                style: headStyle,
              ),
              size10,
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kbluteColor),
                ),
                child: TextFormField(
                  style: subStyle,
                ),
              ),
              // size20,
              // Text(
              //   AppConstant.whichShiftPref,
              //   style: headStyle,
              // ),
              // size10,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     for (int i = 0; i < shiftLoc.length; i++)
              //       InkWell(
              //         onTap: () {
              //           setState(() {
              //             selectedLoc = i;
              //           });
              //         },
              //         child: Container(
              //             padding: const EdgeInsets.symmetric(
              //                 horizontal: 15, vertical: 10),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color:
              //                   selectedLoc == i ? kbluteColor : Colors.white,
              //               border: Border.all(
              //                 color: kbluteColor,
              //               ),
              //             ),
              //             child: Text(
              //               shiftLoc[i].name,
              //               style: subStyle.copyWith(
              //                 color: selectedLoc == i
              //                     ? Colors.white
              //                     : Colors.black,
              //               ),
              //             )),
              //       ),
              //   ],
              // ),
              Utility.vSize(SizeConfig.screenHeight! * 0.15)
            ],
          ),
        ),
      ),
    );
  }
}

class RadioCheckModel {
  final String name;
  bool? isSelected;
  RadioCheckModel({this.isSelected, required this.name});
}
