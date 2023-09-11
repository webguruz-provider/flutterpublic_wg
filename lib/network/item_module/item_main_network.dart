import 'package:foodguru/app_values/export.dart';

class ItemMainNetwork{
  static Future<void> itemsMainTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableItemsMain,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableItemsMain} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnReference} TEXT NOT NULL
    )""");
  }


  static Future<void> insertItemsMain({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await itemsMainTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableItemsMain);
      if (itemMaps!.isEmpty) {
        DummyLists.itemsMainList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableItemsMain, model: element)
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