import 'package:foodguru/app_values/export.dart';


class CancelReasonNetwork{
  static Future<void> cancelReasonTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableCancelReason,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableCancelReason} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnCancelReasonId} INTEGER,
      ${DatabaseValues.columnTitle} TEXT,
      ${DatabaseValues.columnLanguageId} INTEGER
   
    )""");
  }

  static Future<void> insertCancelReason({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await cancelReasonTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableCancelReason);
      if (itemMaps!.isEmpty) {
        for (var element in DummyLists.cancelReasonList) {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableCancelReason, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            showToast(error.toString());
          });
        }
      }
    }
  }
  static Future<List<CancelReasonModel>?> getAllReasonsList() async {
    if (DataSettings.isDBActive == true) {
      var languageId = await PreferenceManger().getLanguageId();
      List<CancelReasonModel>? cancelReasonList;
      await cancelReasonTableCreate();
      await databaseHelper.getItemsByQuery(DatabaseValues.tableCancelReason,
          where: '${DatabaseValues.columnLanguageId} = ?',
          whereArgs: [languageId]).then((value) {
        if (value != null) {
          debugPrint(value.toString());
          List<Map<String, dynamic>>? itemMaps = value;
          cancelReasonList = itemMaps
              .map((element) => CancelReasonModel.fromJson(element))
              .toList();
          return cancelReasonList;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return cancelReasonList ?? [];
    }
  }


}