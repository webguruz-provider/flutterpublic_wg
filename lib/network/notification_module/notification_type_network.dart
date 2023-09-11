import 'package:foodguru/app_values/export.dart';

class NotificationTypeNetwork{

  static Future<void> notificationTypeTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableNotificationType,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableNotificationType} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnReference} INTEGER NOT NULL,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }


  static Future<void> insertNotificationType({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await notificationTypeTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableNotificationType);
      if (itemMaps!.isEmpty) {
        DummyLists.notificationTypeList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableNotificationType, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
            showToast(error.toString());
          });
        });
      }
    }
  }



}