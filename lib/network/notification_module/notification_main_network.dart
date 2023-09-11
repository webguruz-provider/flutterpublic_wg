import 'package:foodguru/app_values/export.dart';
import 'package:foodguru/network/notification_module/notification_network.dart';

class NotificationMainNetwork {
  static Future<void> notificationMainTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableNotificationMain,
        executeCommamd:
        """CREATE TABLE ${DatabaseValues.tableNotificationMain} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnReference} INTEGER NOT NULL,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<void> addNotificationsMain(
      {required String reference,required String title,required String description,required int notificationType, Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await notificationMainTableCreate();
      Map<String, dynamic> map = <String, dynamic>{
        DatabaseValues.columnReference: reference,
      };
      await databaseHelper
          .insertItemMap(DatabaseValues.tableNotificationMain,
          model: map, isReturnId: true)
          .then((notificationId) async {
        final translator = GoogleTranslator();
        List<LanguageModel>? languagesList =
        await LanguageNetwork.getAllLanguageList();
        languagesList?.forEach((element) async {
         var titleTranstlated=await translator.translate(title, from: 'en', to: element.locale!);
         var descriptionTranstlated=await translator.translate(description, from: 'en', to: element.locale!);
          await NotificationNetwork.addNotifications(
              notificationId: notificationId,
              languageId: element.id!,
              notificationType: notificationType,
              title: titleTranstlated.text,
              description: descriptionTranstlated.text);
        });

        onSuccess!();
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    }
  }
}
