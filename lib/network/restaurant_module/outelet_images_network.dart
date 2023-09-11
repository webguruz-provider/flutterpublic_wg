import 'package:foodguru/app_values/export.dart';

class OutletImagesNetwork{
  static Future<void> outletImagesTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableOutletImages,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableOutletImages} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnOutletId} INTEGER NOT NULL,
      ${DatabaseValues.columnImageUrl} TEXT,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }


  static Future<void> insertOutletImages({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await outletImagesTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableOutletImages);
      if (itemMaps!.isEmpty) {
        DummyLists.outletImages.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableOutletImages, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
          });
        });
      }
    }
  }

  static Future<List<RestaurantImagesDataModel>?> getOutletImagesById(id) async {
    if (DataSettings.isDBActive == true) {
      List<RestaurantImagesDataModel>? restaurantImagesList;
      await outletImagesTableCreate();
      await databaseHelper.getItemsByQuery(DatabaseValues.tableOutletImages,
        where: '${DatabaseValues.columnOutletId} =?',
        whereArgs: [id],
      ).then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          restaurantImagesList = itemMaps
              .map((element) => RestaurantImagesDataModel.fromJson(element))
              .toList();
          return restaurantImagesList;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return restaurantImagesList ?? [];
    }
  }

}