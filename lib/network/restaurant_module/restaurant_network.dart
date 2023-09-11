import 'package:foodguru/app_values/export.dart';

class RestaurantNetwork {
  static Future<void> restaurantTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableRestaurant,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableRestaurant} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnRestaurantId} INTEGER,
      ${DatabaseValues.columnRestaurantName} TEXT NOT NULL,
      ${DatabaseValues.columnLogo} TEXT,
      ${DatabaseValues.columnLanguageId} INTEGER,
      ${DatabaseValues.columnDescription} TEXT,
      ${DatabaseValues.columnCategoryId} TEXT,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<void> insertRestaurant({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await restaurantTableCreate();
      List<Map<String, dynamic>>? itemMaps =
          await databaseHelper.getItems(DatabaseValues.tableRestaurant);
      if (itemMaps!.isEmpty) {
        DummyLists.relatedRestaurantList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableRestaurant, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            showToast(error.toString());
          });
        });
      }
    }
  }

  static Future<List<RestaurantItemDataModel>?> getAllRestaurantList() async {
    if (DataSettings.isDBActive == true) {
      List<RestaurantItemDataModel>? restaurantItemDataModel;
      await restaurantTableCreate();
      await databaseHelper.getItems(DatabaseValues.tableRestaurant,
      ).then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          restaurantItemDataModel = itemMaps
              .map((element) => RestaurantItemDataModel.fromMap(element))
              .toList();
          return restaurantItemDataModel;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return restaurantItemDataModel ?? [];
    }
  }

  static Future<RestaurantItemDataModel?> getRestaurantById({id}) async {
    if (DataSettings.isDBActive == true) {
      RestaurantItemDataModel? restaurantItemDataModel;
      await restaurantTableCreate();
      await databaseHelper
          .getItemsById(DatabaseValues.tableRestaurant, id: id)
          .then((value) {
        if (value != null) {
          Map<String, dynamic>? itemMaps = value;
          restaurantItemDataModel = RestaurantItemDataModel.fromMap(itemMaps);
          return restaurantItemDataModel;
        }
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return restaurantItemDataModel;
    }
  }

  static Future<List<RestaurantItemDataModel>?>
      getDineInRestaurantList() async {
    if (DataSettings.isDBActive == true) {
      List<RestaurantItemDataModel>? restaurantItemDataModel;
      await restaurantTableCreate();
      await databaseHelper.getItemsByQuery(DatabaseValues.tableRestaurant,
          where: '${DatabaseValues.columnIsDineInAvailable} =? and ${DatabaseValues.columnLanguageCode} =?',
          whereArgs: [typeTrue,TranslationService.locale?.languageCode]).then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          restaurantItemDataModel = itemMaps
              .map((element) => RestaurantItemDataModel.fromMap(element))
              .toList();
          return restaurantItemDataModel;
        }
      }).onError((error, stackTrace) {
        showToast(error.toString(),isDarkMode: true);
        debugPrint(error.toString());

      });
      return restaurantItemDataModel;
    }
  }
}
