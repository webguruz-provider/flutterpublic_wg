import 'package:foodguru/app_values/export.dart';

class CategoriesMainNetwork{
  static Future<void> categoriesMainTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableCategoriesMain,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableCategoriesMain} (
      ${DatabaseValues.columnCategoryId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnCategoryName} TEXT NOT NULL
    )""");
  }


  static Future<void> insertCategoriesMain({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await categoriesMainTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableCategoriesMain);
      if (itemMaps!.isEmpty) {
        DummyLists.categoryMainList.forEach((element) async {
          await databaseHelper
              .insertItem(DatabaseValues.tableCategoriesMain, model: element)
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