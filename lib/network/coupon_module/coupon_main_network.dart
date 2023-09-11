import 'package:foodguru/app_values/export.dart';

class CouponMainNetwork{
  static Future<void> couponMainTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableCouponMain,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableCouponMain} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnOfferType} TEXT
    )""");
  }

  static Future<void> insertCouponMain({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await couponMainTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableCouponMain);
      if (itemMaps!.isEmpty) {
        DummyLists.couponMainList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableCouponMain, model: element)
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