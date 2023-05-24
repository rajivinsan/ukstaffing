import 'dart:convert';

List<TimeSheet> timeSheetFromJson(String str) =>
    List<TimeSheet>.from(json.decode(str).map((x) => TimeSheet.fromJson(x)));

String timeSheetToJson(List<TimeSheet> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeSheet {
  int cid;
  int status;
  double payment;
  String company;
  DateTime date;
  ShiftTime shiftTime;
  DateTime startDate;
  DateTime endDate;
  int shiftId;
  TimeSheet({
    required this.cid,
    required this.status,
    required this.payment,
    required this.company,
    required this.date,
    required this.shiftTime,
    required this.startDate,
    required this.endDate,
    required this.shiftId,
  });

  factory TimeSheet.fromJson(Map<String, dynamic> json) => TimeSheet(
        cid: json["cid"],
        status: json["status"],
        payment: json["payment"],
        company: json["company"],
        date: DateTime.parse(json["date"]),
        shiftTime: ShiftTime.fromJson(json["shiftTime"]),
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        shiftId: json["shiftId"],
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "status": status,
        "payment": payment,
        "company": company,
        "date": date.toIso8601String(),
        "shiftTime": shiftTime.toJson(),
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "shiftId": shiftId,
      };
}

class ShiftTime {
  bool hasValue;
  Map<String, double> value;

  ShiftTime({
    required this.hasValue,
    required this.value,
  });

  factory ShiftTime.fromJson(Map<String, dynamic> json) => ShiftTime(
        hasValue: json["hasValue"],
        value: Map.from(json["value"])
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "hasValue": hasValue,
        "value": Map.from(value).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
