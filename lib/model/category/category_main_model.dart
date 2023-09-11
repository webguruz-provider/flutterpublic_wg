import 'package:foodguru/app_values/export.dart';

class CategoryMainModel {
  var categoryId;
  var categoryName;


  CategoryMainModel({
    this.categoryName,
    this.categoryId,

  });

  CategoryMainModel.fromMap(Map<String, dynamic> map) {
    categoryId = map[DatabaseValues.columnCategoryId];
    categoryName = map[DatabaseValues.columnCategoryName];

  }

  CategoryMainModel.fromJson(Map<String, dynamic> map) {
    categoryId = map[DatabaseValues.columnCategoryId];
    categoryName = map[DatabaseValues.columnCategoryName];

  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      DatabaseValues.columnCategoryId: categoryId,
      DatabaseValues.columnCategoryName: categoryName,

    };
    return map;
  }
}

