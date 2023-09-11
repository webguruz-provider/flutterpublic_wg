import 'package:foodguru/app_values/export.dart';

class OrderNetwork {
  static Future<void> orderTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableOrders,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableOrders} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnOutletId} INTEGER,
      ${DatabaseValues.columnCouponId} INTEGER,
      ${DatabaseValues.columnAddressId} INTEGER,
      ${DatabaseValues.columnItemTotal} DOUBLE,
      ${DatabaseValues.columnGst} DOUBLE,
      ${DatabaseValues.columnStateId} INTEGER DEFAULT 1,
      ${DatabaseValues.columnDiscount} DOUBLE,
      ${DatabaseValues.columnPaymentId} TEXT DEFAULT 0,
      ${DatabaseValues.columnCancelReasonId} INTEGER DEFAULT NULL,
      ${DatabaseValues.columnDeliveryCharges} DOUBLE,
      ${DatabaseValues.columnUserId} INTEGER,
      ${DatabaseValues.columnIsFeedbackGiven} INTEGER DEFAULT 0,
      ${DatabaseValues.columnCookingInstructions} TEXT,
      ${DatabaseValues.columnGrandTotal} DOUBLE,
      ${DatabaseValues.columnTableId} TEXT,
      ${DatabaseValues.columnOrderType} INTEGER,
      ${DatabaseValues.ColumnNumberOfPersons} INTEGER,
      ${DatabaseValues.columnFromTime} TEXT,
      ${DatabaseValues.columnToTime} TEXT,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<void> addOrder(
      {Function()? onSuccess,
      required data,
      required List<ItemModel>? itemList}) async {
    if (DataSettings.isDBActive == true) {
      await orderTableCreate();
      await databaseHelper
          .insertItemMap(DatabaseValues.tableOrders,
              model: data, isReturnId: true)
          .then((value) async {
        debugPrint(value.toString());
        OrderItemNetwork.orderItemTableCreate();
        itemList!.forEach((element) async {
          Map<String, dynamic> map = <String, dynamic>{
            DatabaseValues.columnOrderId: value,
            DatabaseValues.columnItemId: element.itemId,
            DatabaseValues.columnOrderPrice: element.discountedPrice,
            DatabaseValues.columnQuantity: element.quantity?.value,
          };
          debugPrint(map.toString());
          return await OrderItemNetwork.addOrderItem(
            data: map,
            onSuccess: () async {
              onSuccess!();
            },
          );
        });
        await NotificationMainNetwork.addNotificationsMain(
          reference: 'order placed',
          title: 'Order is Placed',
          notificationType: 1,
          description: 'Your Order is Placed Successfully',onSuccess: () {
        }, );
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
    }
  }
  static Future<void> addDineInOrder(
      {Function()? onSuccess,
      required data,
      required List<ItemModel>? itemList}) async {
    if (DataSettings.isDBActive == true) {
      await orderTableCreate();
      await databaseHelper
          .insertItemMap(DatabaseValues.tableOrders,
              model: data, isReturnId: true)
          .then((value) async {
        debugPrint(value.toString());
        OrderItemNetwork.orderItemTableCreate();
        itemList!.forEach((element) async {
          Map<String, dynamic> map = <String, dynamic>{
            DatabaseValues.columnOrderId: value,
            DatabaseValues.columnItemId: element.itemId,
            DatabaseValues.columnOrderPrice: element.discountedPrice,
            DatabaseValues.columnQuantity: 1,
          };
          debugPrint(map.toString());
          return await OrderItemNetwork.addOrderItem(
            data: map,
            onSuccess: () async {
              onSuccess!();
            },
          );
        });
        await NotificationMainNetwork.addNotificationsMain(
          reference: 'order placed',
          title: 'Order is Placed',
          notificationType: 1,
          description: 'Your Dine in Order is Placed Successfully',onSuccess: () {
        }, );
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
    }
  }

  static Future<void> changeStateOfOrder({
    Function()? onSuccess,
    required data,
    required int id,
  }) async {
    // 3 Cancel
    if (DataSettings.isDBActive == true) {
      await orderTableCreate();
      await databaseHelper
          .updateItemMap(DatabaseValues.tableOrders, model: data, id: id)
          .then((value) {
        onSuccess!();
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
    }
  }

  static Future<List<OrderDataModel>?> getAllOrders() async {
    if (DataSettings.isDBActive == true) {
      int languageId=await PreferenceManger().getLanguageId();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      List<OrderDataModel>? orderList;
      await orderTableCreate();
      await databaseHelper.rawQuery("""SELECT 
    ord.*, 
    a.address, 
    a.longitude AS address_longitude, 
    a.latitude AS address_latitude,
    o.longitude AS outlet_longitude, 
    o.latitude AS outlet_latitude
FROM 
    orders AS ord
LEFT JOIN 
    address AS a ON ord.address_id = a.id
INNER JOIN 
    outlet AS o ON ord.outlet_id = o.outlet_id
WHERE 
    ord.user_id = ${userDbModel.id} AND o.language_id=$languageId
ORDER BY 
    ord.created_on DESC
  """).then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          debugPrint(itemMaps.toString());
          orderList = itemMaps
              ?.map((element) => OrderDataModel.fromJson(element))
              .toList();
          return orderList;
        }
        print(value);
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        showToast(error.toString());
      });
      return orderList ?? [];
    }
  }

  static Future<OrderDataModel?> getOrderById(id) async {
    if (DataSettings.isDBActive == true) {
      List<OrderDataModel>? orderList;
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      int languageId=await PreferenceManger().getLanguageId();

      await orderTableCreate();
      await databaseHelper.rawQuery("""SELECT 
    ord.*, 
    a.address, 
    a.longitude AS address_longitude, 
    a.latitude AS address_latitude,
    o.longitude AS outlet_longitude, 
    o.latitude AS outlet_latitude
FROM 
    orders AS ord
LEFT JOIN 
    address AS a ON ord.address_id = a.id
INNER JOIN 
    outlet AS o ON ord.outlet_id = o.outlet_id
WHERE 
    ord.user_id = ${userDbModel.id} AND o.language_id=$languageId AND ord.id=$id
  """).then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          debugPrint(itemMaps.toString());
          orderList = itemMaps
              ?.map((element) => OrderDataModel.fromJson(element))
              .toList();
          return orderList?.first;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return orderList?.first;
    }
  }
}
