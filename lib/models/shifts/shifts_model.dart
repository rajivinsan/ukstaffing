// To parse this JSON data, do
//
//     final shiftsListongModel = shiftsListongModelFromJson(jsonString);

import 'dart:convert';

List<ShiftsListongModel> shiftsListongModelFromJson(String str) =>
    List<ShiftsListongModel>.from(
        json.decode(str).map((x) => ShiftsListongModel.fromJson(x)));

String shiftsListongModelToJson(List<ShiftsListongModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShiftsListongModel {
  ShiftsListongModel({
    this.shiftid,
    this.category,
    this.date,
    this.shiftTime,
    this.postcode,
    this.company,
    this.price,
    this.distance,
    this.city,
    this.noCandidate,
    this.shiftType,
  });

  final int? shiftid;
  final String? category;
  final DateTime? date;
  final ShiftTime? shiftTime;
  final dynamic postcode;
  final String? company;
  final num? price;
  final double? distance;
  final dynamic city;
  final dynamic noCandidate;
  final dynamic shiftType;

  factory ShiftsListongModel.fromJson(Map<String, dynamic> json) =>
      ShiftsListongModel(
        shiftid: json["shiftid"],
        category: json["category"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        shiftTime: json["shiftTime"] == null
            ? null
            : ShiftTime.fromJson(json["shiftTime"]),
        postcode: json["postcode"],
        company: json["company"],
        price: json["price"],
        distance: json["distance"]?.toDouble(),
        city: json["city"],
        noCandidate: json["noCandidate"],
        shiftType: json["shiftType"],
      );

  Map<String, dynamic> toJson() => {
        "shiftid": shiftid,
        "category": category,
        "date": date?.toIso8601String(),
        "shiftTime": shiftTime?.toJson(),
        "postcode": postcode,
        "company": company,
        "price": price,
        "distance": distance,
        "city": city,
        "noCandidate": noCandidate,
        "shiftType": shiftType,
      };
}

class ShiftTime {
  ShiftTime({
    this.hasValue,
    this.value,
  });

  final bool? hasValue;
  final Map<String, dynamic>? value;

  factory ShiftTime.fromJson(Map<String, dynamic> json) => ShiftTime(
        hasValue: json["hasValue"],
        value: Map.from(json["value"]!)
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "hasValue": hasValue,
        "value":
            Map.from(value!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
