import 'package:foodguru/app_values/export.dart';

class NutritionMainNetwork{
  static Future<void> nutritionMainTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableNutritionMain,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableNutritionMain} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnReference} TEXT NOT NULL
    )""");
  }

  static Future<void> insertNutritionMain({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await nutritionMainTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableNutritionMain);
      if (itemMaps!.isEmpty) {
        DummyLists.nutritionMainList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableNutritionMain, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            showToast(error.toString());
          });
        });
      }
    }
  }
}