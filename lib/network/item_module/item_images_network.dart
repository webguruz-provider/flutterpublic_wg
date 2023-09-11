import 'package:foodguru/app_values/export.dart';

class ItemImagesNetwork{
  static Future<void> itemImagesTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableItemsImages,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableItemsImages} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnItemId} INTEGER NOT NULL,
      ${DatabaseValues.columnImageUrl} TEXT,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }


  static Future<void> insertItemImages({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await itemImagesTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableItemsImages);
      if (itemMaps!.isEmpty) {
        DummyLists.itemImages.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableItemsImages, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
          });
        });
      }
    }
  }

  static Future<List<ItemImagesDataModel>?> getItemImagesById(id) async {
    if (DataSettings.isDBActive == true) {
      List<ItemImagesDataModel>? itemImagesList;
      await itemImagesTableCreate();
      await databaseHelper.getItemsByQuery(DatabaseValues.tableItemsImages,
        where: '${DatabaseValues.columnItemId} =?',
        whereArgs: [id],
      ).then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          itemImagesList = itemMaps
              .map((element) => ItemImagesDataModel.fromJson(element))
              .toList();
          return itemImagesList;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return itemImagesList ?? [];
    }
  }

}