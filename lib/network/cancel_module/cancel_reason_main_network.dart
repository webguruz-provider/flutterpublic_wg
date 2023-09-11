import 'package:foodguru/app_values/export.dart';

class CancelReasonMainNetwork{

  static Future<void> cancelReasonMainTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableCancelReasonMain,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableCancelReasonMain} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnTitle} TEXT
    )""");
  }


  static Future<void> insertCancelReasonMain({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await cancelReasonMainTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableCancelReasonMain);
      if (itemMaps!.isEmpty) {
        for (var element in DummyLists.cancelReasonMainList) {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableCancelReasonMain, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            showToast(error.toString());
          });
        }
      }
    }
  }

}