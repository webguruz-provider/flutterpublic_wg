import 'package:foodguru/app_values/export.dart';

class ItemNetwork {
  static Future<void> itemsTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableItems,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableItems} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnItemId} INTEGER,
      ${DatabaseValues.columnItemName} TEXT,
      ${DatabaseValues.columnOutletId} INTEGER,
      ${DatabaseValues.columnCategoryId} TEXT,
      ${DatabaseValues.columnDescription} TEXT,
      ${DatabaseValues.columnItemPrice} TEXT,
      ${DatabaseValues.columnDiscountedPrice} TEXT,
      ${DatabaseValues.columnPointsPerQuantity} TEXT,
      ${DatabaseValues.columnIsVeg} INTEGER,
      ${DatabaseValues.columnLanguageId} INTEGER,
      ${DatabaseValues.columnIsSeasonalSpecial} INTEGER DEFAULT 0,
      ${DatabaseValues.columnRating} TEXT,
       ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<void> insertItems({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await itemsTableCreate();
      List<Map<String, dynamic>>? itemMaps =
          await databaseHelper.getItems(DatabaseValues.tableItems);
      if (itemMaps!.isEmpty) {
        DummyLists.itemsList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableItems, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            showToast(error.toString());
          });
        });
      }
    }
  }

  static Future<List<ItemModel>?> getAllItemsList() async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
   COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id
  GROUP BY  i.item_id 
  ORDER BY i.item_id ASC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList ?? [];
    }
  }

  static Future<List<ItemModel>?> getPreviouslyOrderedItemsList() async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
   COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id
  GROUP BY  i.item_id 
  ORDER BY i.item_id ASC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList ?? [];
    }
  }

  static Future<List<ItemModel>?> getSeasonalItemsList() async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
   COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id AND i.is_seasonal_special=1
  GROUP BY  i.item_id 
  ORDER BY i.item_id ASC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList ?? [];
    }
  }

  static Future<ItemModel?> getRandomSeasonalItem() async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
   COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id AND i.is_seasonal_special=1
  GROUP BY  i.item_id 
  ORDER BY RANDOM()
  LIMIT 1
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList?.first;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList?.first;
    }
  }

  static Future<List<ItemModel>?> getSearchAllItemsList() async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemSearchList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
  COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND r.language_id=o.language_id
  ORDER BY i.item_id ASC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemSearchList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemSearchList);
          return itemSearchList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemSearchList ?? [];
    }
  }

  static Future<ItemModel?> getItemById({int? id}) async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
       SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
  COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id AND i.item_id =$id
  GROUP BY  i.item_id
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          itemList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          itemList?.first.nutritionList =
              await NutritionNetwork.getNutritionDataById(id);
          itemList?.first.images =
              await ItemImagesNetwork.getItemImagesById(id);
          itemList?.first.isAddedToCart?.value =
              (await CartNetwork.getIsAddedToCartByItemId(id))!;
          itemList?.first.quantity?.value =
              (await CartNetwork.getCartQuantityByItemId(id))!;
          return itemList?.first;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemList?.first;
    }
  }

  static Future<List<ItemModel>?> getItemsByOutletId({id}) async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
    SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
  COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id AND i.outlet_id=$id
  GROUP BY  i.item_id
  ORDER BY i.item_id ASC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList ?? [];
    }
  }

  static Future<List<ItemModel>?> getSearchItemsByOutletId({id}) async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
    SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  WHERE r.language_id=i.language_id AND r.language_id=o.language_id AND i.outlet_id=$id
  ORDER BY i.item_id ASC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList ?? [];
    }
  }

  static Future<List<ItemModel>?> getItemsByCategoryId({id}) async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
  SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
  COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id AND (',' || i.category_id || ',') LIKE '%,$id,%'
  GROUP BY  i.item_id
  ORDER BY i.item_id ASC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList ?? [];
    }
  }

  static Future<List<ItemModel>?> getCartItemsList() async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      await databaseHelper.rawQuery("""
  SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
  COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id AND c.user_id=${userDbModel.id}
  GROUP BY  i.item_id
  ORDER BY c.created_on ASC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList ?? [];
    }
  }

  static Future<List<ItemModel>?> getFrequentlyBoughtTogetherList(
      outletId) async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      await databaseHelper.rawQuery("""
  SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
  COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id AND o.outlet_id=$outletId
  GROUP BY  i.item_id
  ORDER BY c.created_on ASC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList ?? [];
    }
  }

  static Future<List<ItemModel>?> getFrequentlyBoughtTogetherListCart(
      outletId) async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      await databaseHelper.rawQuery("""
  SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
  COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id AND o.outlet_id=$outletId  AND i.item_id NOT IN (SELECT item_id FROM cart WHERE user_id=${userDbModel.id})
  GROUP BY  i.item_id
  ORDER BY c.created_on ASC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList ?? [];
    }
  }

  static Future<List<ItemModel>?> getFavouritesItemsList() async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      await databaseHelper.rawQuery("""
        SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
  COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id AND f.user_id=${userDbModel.id}
  GROUP BY  i.item_id
  ORDER BY f.created_on ASC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList ?? [];
    }
  }

  static Future<List<ItemModel>?> recentlyOrderedList() async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      await databaseHelper.rawQuery("""
       SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
    WHEN f.item_id = i.item_id THEN 1
    ELSE 0
  END AS is_favourite,
  COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
  o.outlet, o.restaurant_id, o.rating AS outlet_rating, o.phone, o.gst_percentage,
  o.delivery_per_km, o.latitude, o.longitude, o.free_delivery_above,
  o.is_dine_in_available, o.coupon_id
FROM (
  SELECT DISTINCT item_id, created_on
  FROM ordersItem
  ORDER BY created_on DESC
  LIMIT 10
) AS latest_items
INNER JOIN ordersItem AS oi ON latest_items.item_id = oi.item_id AND latest_items.created_on = oi.created_on
INNER JOIN items AS i ON oi.item_id = i.item_id
INNER JOIN outlet AS o ON o.outlet_id = i.outlet_id
INNER JOIN restaurant AS r ON r.restaurant_id = o.restaurant_id
LEFT JOIN cart AS c ON i.item_id = c.item_id
LEFT JOIN favourites AS f ON i.item_id = f.item_id
LEFT JOIN feedback AS fb ON i.item_id = fb.item_id
LEFT JOIN orders AS ord ON ord.id = oi.order_id
WHERE r.language_id = i.language_id AND i.language_id = $languageId AND r.language_id = o.language_id AND ord.user_id=${userDbModel.id}
GROUP BY oi.item_id
ORDER BY latest_items.created_on DESC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList ?? [];
    }
  }
  static Future<List<ItemModel>?> recommendedItemsList() async {
    if (DataSettings.isDBActive == true) {
      List<ItemModel>? itemsList;
      await itemsTableCreate();
      // Get the language ID before executing the query
      int languageId = await PreferenceManger().getLanguageId();
      await databaseHelper.rawQuery("""
SELECT i.*,
  r.restaurant_name,
  c.quantity,
  CASE 
  WHEN f.item_id=i.item_id THEN 1
  ELSE 0
  END AS is_favourite,
   COALESCE(AVG(fb.rating_given), 0.0) AS average_rating,
     o.outlet,o.restaurant_id,o.rating AS outlet_rating,o.phone,o.gst_percentage,o.delivery_per_km,o.latitude,o.longitude,o.free_delivery_above,o.is_dine_in_available,o.coupon_id
  FROM items as i
  INNER JOIN outlet as o
  ON o.outlet_id=i.outlet_id
  INNER JOIN restaurant as r
  ON r.restaurant_id=o.restaurant_id
  LEFT JOIN cart as c
  ON i.item_id=c.item_id
  LEFT JOIN favourites as f
  ON i.item_id=f.item_id
  LEFT JOIN feedback as fb 
  ON i.item_id = fb.item_id
  WHERE r.language_id=i.language_id AND i.language_id=$languageId AND r.language_id=o.language_id
  GROUP BY  i.item_id 
  ORDER BY average_rating DESC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          debugPrint(itemMap.toString());
          itemsList =
              itemMap.map((element) => ItemModel.fromJson(element)).toList();
          //This Forloop is to get Images of Items
          await _itemsAddingForloop(itemsList);
          return itemsList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return itemsList ?? [];
    }
  }

  static Future<void> _itemsAddingForloop(List<ItemModel>? itemsList) async {
    itemsList?.forEach((element) async {
      element.images =
          await ItemImagesNetwork.getItemImagesById(element.itemId);
      element.isAddedToCart?.value =
          (await CartNetwork.getIsAddedToCartByItemId(element.itemId))!;
    });
  }
}
