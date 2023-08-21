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
  final int? shiftid;
  final String? category;
  final DateTime? date;
  final Time? shiftTime;
  final Time? endTime;
  final dynamic postcode;
  final String? company;
  final double? price;
  final double? distance;
  final dynamic city;
  final dynamic noCandidate;
  final dynamic shiftType;
  final double? lat;
  final double? long;
  final dynamic status;
  final dynamic address;

  ShiftsListongModel({
    this.shiftid,
    this.category,
    this.date,
    this.shiftTime,
    this.endTime,
    this.postcode,
    this.company,
    this.price,
    this.distance,
    this.city,
    this.noCandidate,
    this.shiftType,
    this.lat,
    this.long,
    this.status,
    this.address,
  });

  factory ShiftsListongModel.fromJson(Map<String, dynamic> json) =>
      ShiftsListongModel(
        shiftid: json["shiftid"],
        category: json["category"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        shiftTime:
            json["shiftTime"] == null ? null : Time.fromJson(json["shiftTime"]),
        endTime:
            json["endTime"] == null ? null : Time.fromJson(json["endTime"]),
        postcode: json["postcode"],
        company: json["company"],
        price: json["price"],
        distance: json["distance"]?.toDouble(),
        city: json["city"],
        noCandidate: json["noCandidate"],
        shiftType: json["shiftType"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        status: json["status"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "shiftid": shiftid,
        "category": category,
        "date": date?.toIso8601String(),
        "shiftTime": shiftTime?.toJson(),
        "endTime": endTime?.toJson(),
        "postcode": postcode,
        "company": company,
        "price": price,
        "distance": distance,
        "city": city,
        "noCandidate": noCandidate,
        "shiftType": shiftType,
        "lat": lat,
        "long": long,
        "status": status,
        "address": address,
      };
}

class Time {
  final bool? hasValue;
  final Map<String, double>? value;

  Time({
    this.hasValue,
    this.value,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
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
