import 'package:foodguru/app_values/export.dart';

class NutritionNetwork {
  static Future<void> nutritionTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableNutrition,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableNutrition} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnItemId} INTEGER NOT NULL,
      ${DatabaseValues.columnNutritionId} INTEGER NOT NULL,
      ${DatabaseValues.columnNutritionText} TEXT NOT NULL,
      ${DatabaseValues.columnMaxValue} INTEGER NOT NULL,
      ${DatabaseValues.columnValue} INTEGER NOT NULL,
      ${DatabaseValues.columnLanguageId} INTEGER NOT NULL,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<void> insertNutritionData({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await nutritionTableCreate();
      List<Map<String, dynamic>>? itemMaps =
          await databaseHelper.getItems(DatabaseValues.tableNutrition);
      if (itemMaps!.isEmpty) {
        DummyLists.nutritionList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableNutrition, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            showToast(error.toString());
          });
        });
      }
    }
  }

  static Future<List<NutritionModel>?> getNutritionDataById(itemId) async {
    if (DataSettings.isDBActive == true) {
      var languageId = await PreferenceManger().getLanguageId();
      List<NutritionModel>? nutritionList;
      await nutritionTableCreate();
      await databaseHelper.getItemsByQuery(DatabaseValues.tableNutrition,
          where:
              '${DatabaseValues.columnItemId} = ? AND ${DatabaseValues.columnLanguageId} = ?',
          whereArgs: [
            itemId,languageId
          ]).then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          debugPrint(itemMaps.toString());
          nutritionList = itemMaps
              .map((element) => NutritionModel.fromJson(element))
              .toList();
          return nutritionList;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return nutritionList ?? [];
    }
  }
}
