import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/utilities/ui/utility.dart';
import 'package:sterling/views/widgets/shadow_container.dart';

import '../widgets/common_button.dart';
import '../widgets/timesheet/timesheet_card.dart';

class PaymentTimeSheet extends StatefulWidget {
  const PaymentTimeSheet({super.key});

  @override
  State<PaymentTimeSheet> createState() => _PaymentTimeSheetState();
}

class _PaymentTimeSheetState extends State<PaymentTimeSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, bottom: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border.all(
                    color: kGreenColor,
                    width: 3,
                  )),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: kGreenColor),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kGreenColor),
                        padding: const EdgeInsets.all(2),
                        child: const Icon(
                          FontAwesomeIcons.exclamation,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      '''You can instantly receive 60% of your shift payments by tapping on them and enabling Instant Pay.''',
                      textAlign: TextAlign.left,
                      style: redHatMedium.copyWith(
                          color: klightTextColor, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            size20,
            ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                      onTap: () {
                        showSheet();
                      },
                      child: const TimeSheetCard())),
            )
          ],
        ),
      ),
    );
  }

  showSheet() {
    TextStyle subheadStyle =
        redHatMedium.copyWith(color: klightTextColor, fontSize: 18);
    TextStyle headStyle =
        redHatMedium.copyWith(color: Colors.black, fontSize: 18);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      builder: ((context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ShadowContainer(
                color: const Color.fromRGBO(5, 237, 70, 0.77),
                height: 50,
                radius: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        "Approved on",
                        style: headStyle,
                      ),
                      const Spacer(),
                      Text(
                        "9 Oct",
                        style: subheadStyle,
                      )
                    ],
                  ),
                ),
              ),
              size10,
              ShadowContainer(
                color: const Color.fromRGBO(5, 237, 70, 0.77),
                height: 50,
                radius: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        "Paid on",
                        style: headStyle,
                      ),
                      const Spacer(),
                      Text(
                        "9 Oct",
                        style: subheadStyle,
                      )
                    ],
                  ),
                ),
              ),
              size10,
              Card(
                color: const Color(
                  0xffEEE4E3,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(
                      0xffEEE4E3,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text("Rasemount Care Home ",
                                style: subheadStyle),
                          ),
                          Text("8 Oct", style: subheadStyle)
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text("Time Worked ", style: subheadStyle),
                          ),
                          Text("08:00 - 20:00", style: subheadStyle)
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text("Break(unpaid)", style: subheadStyle),
                          ),
                          Text(
                            "60 mins",
                            style: subheadStyle,
                          )
                        ],
                      ),
                      Utility.vSize(30),
                      Row(
                        children: [
                          Text(
                            "Total pay",
                            style: headStyle,
                          ),
                          const Spacer(),
                          Text(
                            "£169.00",
                            style: subheadStyle,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Utility.vSize(30),
              CommonButton(
                  name: "Close",
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        );
      }),
    );
  }
}
