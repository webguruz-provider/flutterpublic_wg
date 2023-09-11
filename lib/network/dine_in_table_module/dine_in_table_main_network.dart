import 'package:foodguru/app_values/export.dart';

class DineInTableMainNetwork{
  static Future<void> dineInTableMainTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableDineInTableMain,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableDineInTableMain} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnSeatSize} INTEGER
    )""");
  }
  static Future<void> insertDineInTableMain({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await dineInTableMainTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableDineInTableMain);
      if (itemMaps!.isEmpty) {
        DummyLists.dineInMainTableList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableDineInTableMain, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
          });
        });
      }
    }
  }
}