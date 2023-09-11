import 'package:foodguru/app_values/export.dart';

class CategoryModel {
  int? id;
  int? categoryId;
  String? categoryName;
  int? languageId;
  String? imageUrl;

  CategoryModel(
      {this.id,
      this.imageUrl,
      this.categoryName,
      this.languageId,
      this.categoryId});

  CategoryModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseValues.columnId];
    categoryName = map[DatabaseValues.columnCategoryName];
    imageUrl = map[DatabaseValues.columnImageUrl];
    languageId = map[DatabaseValues.columnLanguageId];
    categoryId = map[DatabaseValues.columnCategoryId];

  }

  CategoryModel.fromJson(Map<String, dynamic> map) {
    id = map[DatabaseValues.columnId];
    categoryName = map[DatabaseValues.columnCategoryName];
    imageUrl = map[DatabaseValues.columnImageUrl];
    languageId = map[DatabaseValues.columnLanguageId];
    categoryId = map[DatabaseValues.columnCategoryId];
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      DatabaseValues.columnId: id,
      DatabaseValues.columnImageUrl: imageUrl,
      DatabaseValues.columnCategoryName: categoryName,
      DatabaseValues.columnLanguageId: languageId,
      DatabaseValues.columnCategoryId: categoryId,
    };
    return map;
  }
}
