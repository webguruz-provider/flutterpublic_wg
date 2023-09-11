import 'package:foodguru/app_values/export.dart';

class CouponNetwork{
  static Future<void> couponTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableCoupon,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableCoupon} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnCouponId} INTEGER NOT NULL,
      ${DatabaseValues.columnCouponName} TEXT,
      ${DatabaseValues.columnDescription} TEXT,
      ${DatabaseValues.columnImageUrl} TEXT,
      ${DatabaseValues.columnValue} INTEGER DEFAULT NULL,
      ${DatabaseValues.columnMinimumOrder} INTEGER,
      ${DatabaseValues.columnMaximumDiscount} INTEGER DEFAULT NULL
    )""");
  }

  static Future<void> insertCoupon({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await couponTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableCoupon);
      if (itemMaps!.isEmpty) {
        DummyLists.couponList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableCoupon, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
          });
        });
      }
    }
  }

  static Future<List<CouponModel>> getAllCoupons() async {
    List<CouponModel>couponList=[];
    if (DataSettings.isDBActive == true) {

      await couponTableCreate();
      List<Map<String, dynamic>>? itemMaps = await databaseHelper.getItems(
        DatabaseValues.tableCoupon,
      );
      debugPrint(itemMaps.toString());
      couponList=itemMaps!.map((element) => CouponModel.fromJson(element)).toList();
      return couponList;
    }
    return couponList;
  }



  
  static Future<List<CouponModel>> getCouponsById(List<int> id) async {
    List<CouponModel>couponList=[];
    if (DataSettings.isDBActive == true) {

      await couponTableCreate();
      List<Map<String, dynamic>>? itemMaps = await databaseHelper.getItemsByQuery(
        DatabaseValues.tableCoupon,
        where:
        '${DatabaseValues.columnId} IN (${id.map((id) => '?').join(',')})',
        whereArgs: [...id],
      );
      debugPrint(itemMaps.toString());
      couponList=itemMaps!.map((element) => CouponModel.fromJson(element)).toList();
      return couponList;
    }
    return couponList;
  }



}