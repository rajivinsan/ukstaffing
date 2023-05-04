// To parse this JSON data, do
//
//     final shiftDetailModel = shiftDetailModelFromJson(jsonString);

import 'dart:convert';

List<ShiftDetailModel> shiftDetailModelFromJson(String str) =>
    List<ShiftDetailModel>.from(
        json.decode(str).map((x) => ShiftDetailModel.fromJson(x)));

String shiftDetailModelToJson(List<ShiftDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShiftDetailModel {
  ShiftDetailModel({
    this.shiftid,
    this.category,
    this.date,
    this.shiftTime,
    this.postcode,
    this.company,
    this.price,
    this.shiftDetailModelBreak,
    this.lat,
    this.lon,
    this.distance,
    this.city,
    this.noCandidate,
    this.shiftType,
  });

  final int? shiftid;
  final int? category;
  final DateTime? date;
  final ShiftTime? shiftTime;
  final String? postcode;
  final int? company;
  final num? price;
  final String? shiftDetailModelBreak;
  final double? lat;
  final double? lon;
  final dynamic distance;
  final dynamic city;
  final int? noCandidate;
  final dynamic shiftType;

  factory ShiftDetailModel.fromJson(Map<String, dynamic> json) =>
      ShiftDetailModel(
        shiftid: json["shiftid"],
        category: json["category"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        shiftTime: json["shiftTime"] == null
            ? null
            : ShiftTime.fromJson(json["shiftTime"]),
        postcode: json["postcode"],
        company: json["company"],
        price: json["price"],
        shiftDetailModelBreak: json["break"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        distance: json["distance"],
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
        "break": shiftDetailModelBreak,
        "lat": lat,
        "lon": lon,
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
  final Map<String, double>? value;

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
