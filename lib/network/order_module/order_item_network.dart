import 'package:foodguru/app_values/export.dart';


class OrderItemNetwork{
  static Future<void> orderItemTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableOrdersItem,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableOrdersItem} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnOrderId} INTEGER,
      ${DatabaseValues.columnItemId} INTEGER,
      ${DatabaseValues.columnOrderPrice} INTEGER,
      ${DatabaseValues.columnQuantity} INTEGER,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }
  static Future<void> addOrderItem({Function()? onSuccess,data}) async {
    if (DataSettings.isDBActive == true) {
      await databaseHelper
          .insertItemMap(DatabaseValues.tableOrdersItem, model: data)
          .then((value) async {
        debugPrint(value.toString());
        onSuccess!();
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
    }
  }
  static Future<List<OrderItemDataModel>?> getOrderItemsList(orderId) async {
    if (DataSettings.isDBActive == true) {
      List<OrderItemDataModel>? orderList;
      await orderItemTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      await databaseHelper.rawQuery("""
  SELECT i.*,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,o.outlet,
  COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
  r.restaurant_name,ordItem.quantity,ordItem.order_price, ordItem.order_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  INNER JOIN ordersItem as ordItem
  ON i.item_id=ordItem.item_id
  INNER JOIN orders as ord
  ON ordItem.order_id=ord.id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id AND ord.user_id=${userDbModel.id} AND ord.id=$orderId
  GROUP BY  i.item_id
  ORDER BY ordItem.id ASC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          orderList =
              itemMap.map((element) => OrderItemDataModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          return orderList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return orderList ?? [];
    }
  }
}