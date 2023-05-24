// To parse this JSON data, do
//
//     final registration = registrationFromJson(jsonString);

import 'dart:convert';

List<Registration> registrationFromJson(String str) => List<Registration>.from(
    json.decode(str).map((x) => Registration.fromJson(x)));

String registrationToJson(List<Registration> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Registration {
  int cid;
  String firstName;
  String lastName;
  String email;
  String pass;
  int shift;
  String postcode;
  int profession;
  int shifttype;
  DateTime dated;
  int status;
  dynamic lat;
  dynamic lon;

  Registration({
    required this.cid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.pass,
    required this.shift,
    required this.postcode,
    required this.profession,
    required this.shifttype,
    required this.dated,
    required this.status,
    this.lat,
    this.lon,
  });

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        cid: json["cid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        pass: json["pass"],
        shift: json["shift"],
        postcode: json["postcode"],
        profession: json["profession"],
        shifttype: json["shifttype"],
        dated: DateTime.parse(json["dated"]),
        status: json["status"],
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "pass": pass,
        "shift": shift,
        "postcode": postcode,
        "profession": profession,
        "shifttype": shifttype,
        "dated": dated.toIso8601String(),
        "status": status,
        "lat": lat,
        "lon": lon,
      };
}
