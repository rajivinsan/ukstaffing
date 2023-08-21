import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/constants/enum.dart';
import 'package:sterling/constants/text_style.dart';
import 'package:sterling/models/payment.dart';
import 'package:sterling/repository/APIBase/api_url.dart';
import 'package:sterling/utilities/ui/utility.dart';
import 'package:sterling/views/widgets/shadow_container.dart';
import 'package:sterling/views/widgets/shift_card_shimmer.dart';

import '../viewmodel/user_own_shift_view_model.dart';
import '../widgets/common_button.dart';
import '../widgets/paymentsheet/Paymentsheet_card.dart';
import '../widgets/timesheet/timesheet_card.dart';
import 'package:http/http.dart' as http;

class PaymentTimeSheet extends ConsumerStatefulWidget {
  const PaymentTimeSheet({super.key});

  @override
  ConsumerState<PaymentTimeSheet> createState() => _PaymentTimeSheetState();
}

class _PaymentTimeSheetState extends ConsumerState<PaymentTimeSheet> {
  @override
  Widget build(BuildContext context) {
    final timesheet = ref.watch(userTimeSheetProvider);

    switch (timesheet.status) {
      case Status.loadMore:
        return Container();
      case Status.error:
        return Container();

      case Status.loading:
        return const ShiftCardShimmer(
          length: 6,
        );

      case Status.success:
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                size20,
                ListView.builder(
                  itemCount: timesheet.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    DateTime startDate = timesheet.data![index].startDate;
                    DateTime endDate = timesheet.data![index].endDate;

                    var hoursDifference =
                        calculateHoursDifference(startDate, endDate);
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                            onTap: () {
                              showSheet(timesheet.data![index].shiftId);
                            },
                            child: PaymentSheetCard(
                              Company: timesheet.data![index].company,
                              Shift_Date: timesheet.data![index].date
                                  .toString()
                                  .substring(0, 10),
                              User_Spent_Time: '$hoursDifference ',
                              Pay_Amount:
                                  timesheet.data![index].payment.toString(),
                            )));
                  },
                )
              ],
            ),
          ),
        );
      case Status.referesh:
        return Container();
      default:
        return Container();
    }
  }

  String calculateHoursDifference(DateTime startDate, DateTime endDate) {
    Duration difference = endDate.difference(startDate);

    int totalMinutes = difference.inMinutes;
    int hours = totalMinutes ~/ 60; // Calculate hours
    int minutes = totalMinutes % 60; // Calculate remaining minutes

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  List<PaymentDetails> listdate = [];
  Future<List<PaymentDetails>> fetchAlbum(dynamic id) async {
    final response =
        await http.get(Uri.parse("${ApiUrl.apiBaseUrl}${ApiUrl.payMent}${id}"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      listdate = paymentDetailsFromJson((response.body));
      return listdate;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  showSheet(dynamic shiftid) {
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
                        "Paid on",
                        style: headStyle,
                      ),
                      // const Spacer(),
                      // Text(
                      //   "9 Oct",
                      //   style: subheadStyle,
                      // )
                    ],
                  ),
                ),
              ),
              size10,
              // ShadowContainer(
              //   color: const Color.fromRGBO(5, 237, 70, 0.77),
              //   height: 50,
              //   radius: 10,
              //   child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 10),
              //       child:
              //       // Row(
              //       //   children: [
              //       //     Text(
              //       //       "Paid on",
              //       //       style: headStyle,
              //       //     ),
              //       //     const Spacer(),
              //       //     Text(
              //       //       "9 Oct",
              //       //       style: subheadStyle,
              //       //     )
              //       //   ],
              //       // ),
              //       ),
              // ),
              size10,

              Expanded(
                child: FutureBuilder(
                  future: fetchAlbum(shiftid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: listdate.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.add_card),
                            title: Text((listdate[index]
                                    .date
                                    .toString()
                                    .substring(0, 10))
                                .toString()),
                            trailing: Column(children: [
                              Icon(Icons.currency_pound),
                              Text(listdate[index].amount.toString())
                            ]),
                          );
                        },
                      );
                    }
                  },
                ),
              )
              // Card
              // (
              //   color: const Color(
              //     0xffEEE4E3,
              //   ),
              //   child: Container(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: const Color(
              //         0xffEEE4E3,
              //       ),
              //     ),
              //     child: Column(
              //       children: [
              //         Row(
              //           children: [
              //             Expanded(
              //               child: Text("Rasemount Care Home ",
              //                   style: subheadStyle),
              //             ),
              //             Text("8 Oct", style: subheadStyle)
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             Expanded(
              //               child: Text("Time Worked ", style: subheadStyle),
              //             ),
              //             Text("08:00 - 20:00", style: subheadStyle)
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             Expanded(
              //               child: Text("Break(unpaid)", style: subheadStyle),
              //             ),
              //             Text(
              //               "60 mins",
              //               style: subheadStyle,
              //             )
              //           ],
              //         ),
              //         Utility.vSize(30),
              //         Row(
              //           children: [
              //             Text(
              //               "Total pay",
              //               style: headStyle,
              //             ),
              //             const Spacer(),
              //             Text(
              //               "£169.00",
              //               style: subheadStyle,
              //             )
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              //Utility.vSize(30),
              ,
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
