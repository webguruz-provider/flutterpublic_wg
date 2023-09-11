import 'package:foodguru/app_values/export.dart';

class NotificationNetwork {
  static Future<void> notificationTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableNotification,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableNotification} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnNotificationId} INTEGER NOT NULL,
      ${DatabaseValues.columnUserId} INTEGER NOT NULL,
      ${DatabaseValues.columnLanguageId} INTEGER,
      ${DatabaseValues.columnNotificationType} INTEGER,
      ${DatabaseValues.columnTitle} TEXT,
      ${DatabaseValues.columnDescription} TEXT,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<void> addNotifications(
      {required int notificationId,required int languageId,required int notificationType,required String title,required String description, Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      UserDbModel userDbModel=await PreferenceManger().getSavedLoginData();
      await notificationTableCreate();
      Map<String, dynamic> map = <String, dynamic>{
        DatabaseValues.columnNotificationId: notificationId,
        DatabaseValues.columnUserId: userDbModel.id,
        DatabaseValues.columnLanguageId: languageId,
        DatabaseValues.columnNotificationType: notificationType,
        DatabaseValues.columnTitle: title,
        DatabaseValues.columnDescription: description,
      };
      await databaseHelper
          .insertItemMap(DatabaseValues.tableNotification,
          model: map, isReturnId: true)
          .then((value) async {
        onSuccess!();
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    }
  }


  static Future<List<NotificationModel>?> getNotificationList() async {
    if (DataSettings.isDBActive == true) {
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      List<NotificationModel>? notificationList;
      int languageId = await PreferenceManger().getLanguageId();
      await notificationTableCreate();
      await databaseHelper.getItemsByQuery(DatabaseValues.tableNotification,
          where: '${DatabaseValues.columnUserId} = ? AND ${DatabaseValues.columnLanguageId} = ?',
          whereArgs: [userDbModel.id,languageId]).then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          notificationList = itemMaps
              .map((element) => NotificationModel.fromJson(element))
              .toList();
          return notificationList;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
        debugPrint(error.toString());
      });
      return notificationList ?? [];
    }
  }

}
