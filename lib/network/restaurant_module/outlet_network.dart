import 'package:foodguru/app_values/export.dart';
import 'package:foodguru/network/dine_in_table_module/dine_in_table_network.dart';


class OutletNetwork {
  static Future<void> outletMainTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableOutlet,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableOutlet} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnRestaurantId} INTEGER,
      ${DatabaseValues.columnOutletId} INTEGER,
      ${DatabaseValues.columnOutlet} TEXT NOT NULL,
      ${DatabaseValues.columnRating} TEXT,
      ${DatabaseValues.columnPhone} TEXT,
      ${DatabaseValues.columnLanguageId} INTEGER,
      ${DatabaseValues.columnCity} TEXT,
      ${DatabaseValues.columnState} TEXT,
      ${DatabaseValues.columnCountry} TEXT,
      ${DatabaseValues.columnLatitude} DOUBLE,
      ${DatabaseValues.columnLongitude} DOUBLE,
      ${DatabaseValues.columnFreeDeliveryAbove} INTEGER,
      ${DatabaseValues.columnIsDineInAvailable} INTEGER DEFAULT 0,
      ${DatabaseValues.columnGstPercentage} INTEGER,
      ${DatabaseValues.columnDeliveryPerKm} INTEGER,
      ${DatabaseValues.columnCouponId} TEXT,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<void> insertOutlet({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await outletMainTableCreate();
      List<Map<String, dynamic>>? itemMaps =
          await databaseHelper.getItems(DatabaseValues.tableOutlet);
      if (itemMaps!.isEmpty) {
        DummyLists.outletList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableOutlet, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
          });
        });
      }
    }
  }

  static Future<List<RestaurantItemDataModel>?> getAllRestaurantList(
      {Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      List<RestaurantItemDataModel>? restaurantList;
      await outletMainTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
              SELECT o.id,
       o.outlet_id,
        COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
       r.restaurant_id,
       r.restaurant_name,
       r.category_id,
       r.logo,
       r.description,
       o.outlet,
       o.language_id,
       o.rating,
       o.phone,
       o.language_id,
       o.city,
       o.state,
       o.country,
       o.latitude,
       o.delivery_per_km,
       o.gst_percentage,
       o.longitude,
       o.free_delivery_above,
       o.is_dine_in_available
  FROM ${DatabaseValues.tableOutlet} as o
  INNER JOIN ${DatabaseValues.tableRestaurant} as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN feedback as fb 
  ON o.outlet_id = fb.outlet_id
  WHERE r.language_id=o.language_id AND o.language_id=$languageId 
  GROUP BY o.outlet_id  
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          restaurantList = itemMap
              .map((element) => RestaurantItemDataModel.fromMap(element))
              .toList();

          //This Forloop is to get Categories name from Description
          await _addingImagesAndCategories(restaurantList!);
          return restaurantList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return restaurantList ?? [];
    }
  }


  static Future<List<RestaurantItemDataModel>?> getRestaurantListByCouponId(id,
      {Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      List<RestaurantItemDataModel>? restaurantList;
      await outletMainTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
              SELECT o.id,
       o.outlet_id,
        COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
       r.restaurant_id,
       r.restaurant_name,
       r.category_id,
       r.logo,
       r.description,
       o.outlet,
       o.language_id,
       o.rating,
       o.phone,
       o.language_id,
       o.city,
       o.state,
       o.country,
       o.latitude,
       o.delivery_per_km,
       o.gst_percentage,
       o.longitude,
       o.free_delivery_above,
       o.is_dine_in_available
  FROM ${DatabaseValues.tableOutlet} as o
  INNER JOIN ${DatabaseValues.tableRestaurant} as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN feedback as fb 
  ON o.outlet_id = fb.outlet_id
  WHERE r.language_id=o.language_id AND o.language_id=$languageId AND (',' || o.coupon_id || ',') LIKE '%,$id,%'
  GROUP BY o.outlet_id  
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          restaurantList = itemMap
              .map((element) => RestaurantItemDataModel.fromMap(element))
              .toList();

          //This Forloop is to get Categories name from Description
          await _addingImagesAndCategories(restaurantList!);
          return restaurantList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return restaurantList ?? [];
    }
  }


  static Future<List<RestaurantItemDataModel>?> getSearchAllRestaurantList(
      {Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      List<RestaurantItemDataModel>? searchList;
      await outletMainTableCreate();
      // Get the language ID before executing the query
      await databaseHelper.rawQuery("""
              SELECT o.id,
       o.outlet_id,
        COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
       r.restaurant_id,
       r.restaurant_name,
       r.category_id,
       r.logo,
       r.description,
       
       o.outlet,
       o.language_id,
       o.rating,
       o.phone,
       o.language_id,
       o.city,
       o.state,
       o.country,
       o.latitude,
       o.delivery_per_km,
       o.gst_percentage,
       o.longitude,
       o.free_delivery_above,
       o.is_dine_in_available
  FROM ${DatabaseValues.tableOutlet} as o
  INNER JOIN ${DatabaseValues.tableRestaurant} as r
  ON r.restaurant_id=o.restaurant_id
   LEFT JOIN feedback as fb 
  ON o.outlet_id = fb.outlet_id
  WHERE r.language_id=o.language_id
  GROUP BY o.outlet_id  
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          searchList = itemMap
              .map((element) => RestaurantItemDataModel.fromMap(element))
              .toList();

          //This Forloop is to get Categories name from Description
          await _addingImagesAndCategories(searchList!);
          return searchList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return searchList ?? [];
    }
  }

  static Future<RestaurantItemDataModel?> getRestaurantById(
      {int? id, Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      List<RestaurantItemDataModel>? restaurantList;
      await outletMainTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
              SELECT o.id,
       o.outlet_id,
       COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
       r.restaurant_id,
       r.restaurant_name,
       r.category_id,
       r.logo,
       r.description,
       o.outlet,
       o.language_id,
       o.rating,
       o.phone,
       o.language_id,
       o.city,
       o.state,
       o.country,
         o.delivery_per_km,
       o.gst_percentage,
       o.latitude,
       o.longitude,
       o.free_delivery_above,
       o.is_dine_in_available
  FROM ${DatabaseValues.tableOutlet} as o
  INNER JOIN ${DatabaseValues.tableRestaurant} as r
  ON r.restaurant_id=o.restaurant_id
   LEFT JOIN feedback as fb 
  ON o.outlet_id = fb.outlet_id
  WHERE r.language_id=o.language_id AND o.language_id=$languageId AND o.outlet_id=$id
  GROUP BY o.outlet_id  
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          restaurantList = itemMap
              .map((element) => RestaurantItemDataModel.fromMap(element))
              .toList();

          //This Forloop is to get Categories name from Description

            List<int> ids = [];
            List<String> idStrings = restaurantList?.first.categoryId.split(',');
            ids.addAll(idStrings.map((idString) => int.parse(idString)));
            //Here in for loop we changed the value of description
          restaurantList?.first.categoryId = await CategoriesNetwork.getCategoriesById(ids);
            restaurantList?.first.images = await OutletImagesNetwork.getOutletImagesById(restaurantList?.first.outletId);
            restaurantList?.first.tableList = await DineInTableNetwork.getTableList(outletId: restaurantList?.first.outletId,);

          return restaurantList?.first;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return restaurantList?.first;
    }
  }

  static Future<List<RestaurantItemDataModel>?> getAllDineinList(
      {Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      List<RestaurantItemDataModel>? restaurantList;
      await outletMainTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
              SELECT o.id,
       o.outlet_id,
       COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
       r.restaurant_id,
       r.category_id,
       r.restaurant_name,
       r.logo,
       r.description,
       o.outlet,
       o.language_id,
       o.rating,
       o.phone,
       o.language_id,
       o.city,
       o.state,
       o.country,
       o.delivery_per_km,
       o.gst_percentage,
       o.latitude,
       o.longitude,
       o.free_delivery_above,
       o.is_dine_in_available
  FROM ${DatabaseValues.tableOutlet} as o
  INNER JOIN ${DatabaseValues.tableRestaurant} as r
  ON r.restaurant_id=o.restaurant_id
   LEFT JOIN feedback as fb 
  ON o.outlet_id = fb.outlet_id
  WHERE r.language_id=o.language_id AND o.language_id=$languageId AND o.is_dine_in_available=1
  GROUP BY o.outlet_id  
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          restaurantList = itemMap
              .map((element) => RestaurantItemDataModel.fromMap(element))
              .toList();
          //This For loop is to get Categories name from Description
          await _addingImagesAndCategories(restaurantList!);
          return restaurantList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return restaurantList ?? [];
    }
  }

  static Future<List<RestaurantItemDataModel>?> getSearchAllDineinList(
      {Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      List<RestaurantItemDataModel>? restaurantList;
      await outletMainTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
              SELECT o.id,
       o.outlet_id,
       r.restaurant_id,
       r.category_id,
       r.restaurant_name,
       r.logo,
       r.description,
       o.outlet,
       o.language_id,
       o.rating,
       o.phone,
       o.language_id,
       o.city,
       o.state,
       o.country,
       o.delivery_per_km,
       o.gst_percentage,
       o.latitude,
       o.longitude,
       o.free_delivery_above,
       o.is_dine_in_available
  FROM ${DatabaseValues.tableOutlet} as o
  INNER JOIN ${DatabaseValues.tableRestaurant} as r
  ON r.restaurant_id=o.restaurant_id
  WHERE r.language_id=o.language_id AND o.is_dine_in_available=1
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          restaurantList = itemMap
              .map((element) => RestaurantItemDataModel.fromMap(element))
              .toList();
          //This For loop is to get Categories name from Description
          await _addingImagesAndCategories(restaurantList!);
          return restaurantList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return restaurantList ?? [];
    }
  }

  static Future<void> _addingImagesAndCategories(List<RestaurantItemDataModel> restaurantList) async {
    for (var element in restaurantList) {
      List<int> ids = [];
      List<String> idStrings = element.categoryId.split(',');
      ids.addAll(idStrings.map((idString) => int.parse(idString)));
      //Here in for loop we changed the value of description
      element.categoryId = await CategoriesNetwork.getCategoriesById(ids);
      element.images =
          await OutletImagesNetwork.getOutletImagesById(element.outletId);
    }
  }
}
/*
SELECT id,
       outlet_id,
       coupon_id,
       address_id,
       item_total,
       gst,
       state_id,
       discount,
       payment_id,
       cancel_reason_id,
       delivery_charges,
       user_id,
       is_feedback_given,
       cooking_instructions,
       grand_total,
       table_id,
       order_type,
       number_of_persons,
       from_time,
       to_time,
       created_on
  FROM main.orders
 WHERE to_time between '2023-08-24 06:30:00.000' AND '2023-08-24 07:30:00.000' OR from_time between '2023-08-24 06:30:00.000' AND '2023-08-24 07:30:00.000' AND table_id IN (4);

 */