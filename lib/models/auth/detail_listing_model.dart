import 'dart:convert';

class ProfessionDetailsModel {
  int? percent;
  final String? name;
  final int id;
  bool isCompelete;
  ProfessionDetailsModel(
      {this.name, this.percent, required this.id, required this.isCompelete});

  ProfessionDetailsModel copWith(
      {int? percent, final String? name, final int? id, bool? isCompelete}) {
    return ProfessionDetailsModel(
        id: id ?? this.id,
        isCompelete: isCompelete ?? this.isCompelete,
        name: name ?? this.name,
        percent: percent ?? this.percent);
  }

  factory ProfessionDetailsModel.fromJson(Map<String, dynamic> jsonData) {
    return ProfessionDetailsModel(
        id: jsonData['id'],
        name: jsonData['name'],
        percent: jsonData['percent'],
        isCompelete: jsonData['isCompelete']);
  }

  static Map<String, dynamic> toMap(ProfessionDetailsModel music) => {
        'id': music.id,
        'name': music.name,
        'isCompelete': music.isCompelete,
        'percent': music.percent
      };
  static String encode(List<ProfessionDetailsModel> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>(
                (music) => ProfessionDetailsModel.toMap(music))
            .toList(),
      );

  static List<ProfessionDetailsModel> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<ProfessionDetailsModel>(
              (item) => ProfessionDetailsModel.fromJson(item))
          .toList();
}
