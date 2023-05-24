// To parse this JSON data, do
//
//     final paymentDetails = paymentDetailsFromJson(jsonString);

import 'dart:convert';

List<PaymentDetails> paymentDetailsFromJson(String str) => List<PaymentDetails>.from(json.decode(str).map((x) => PaymentDetails.fromJson(x)));

String paymentDetailsToJson(List<PaymentDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentDetails {
    int srno;
    int shiftId;
    int cid;
    DateTime date;
    int amount;

    PaymentDetails({
        required this.srno,
        required this.shiftId,
        required this.cid,
        required this.date,
        required this.amount,
    });

    factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        srno: json["srno"],
        shiftId: json["shiftId"],
        cid: json["cid"],
        date: DateTime.parse(json["date"]),
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "srno": srno,
        "shiftId": shiftId,
        "cid": cid,
        "date": date.toIso8601String(),
        "amount": amount,
    };
}
