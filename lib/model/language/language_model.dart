import '../../app_values/export.dart';

class LanguageModel {
  int? id;
  String? title;
  String? locale;

  LanguageModel({this.title, this.id, this.locale});

  LanguageModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseValues.columnId];
    title = map[DatabaseValues.columnTitle];
    locale = map[DatabaseValues.columnLanguageCode];
  }

  LanguageModel.fromJson(Map<String, dynamic> map) {
    id = map[DatabaseValues.columnId];
    title = map[DatabaseValues.columnTitle];
    locale = map[DatabaseValues.columnLanguageCode];
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      DatabaseValues.columnId: id,
      DatabaseValues.columnTitle: title,
      DatabaseValues.columnLanguageCode: locale,
    };
    return map;
  }
}
