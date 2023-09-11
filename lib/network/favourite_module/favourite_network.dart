import 'package:foodguru/app_values/export.dart';

class FavouriteNetwork {
  static Future<void> favoriteTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableFavourites,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableFavourites} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnItemId} INTEGER,
      ${DatabaseValues.columnUserId} TEXT,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<bool> isItemInFavorites(int itemId, int userId) async {
    List<Map<String, dynamic>> maps = await databaseHelper.query(
        DatabaseValues.tableFavourites,
        columns: [DatabaseValues.columnItemId],
        where:
            '${DatabaseValues.columnItemId} = ? AND ${DatabaseValues.columnUserId} = ?',
        whereArgs: [itemId, userId]);
    return maps.isNotEmpty;
  }

  static Future<void> addRemoveToFavourites(
      {required int itemId, ValueChanged<int>? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await favoriteTableCreate();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      Map<String, dynamic> map = <String, dynamic>{
        DatabaseValues.columnItemId: itemId,
        DatabaseValues.columnUserId: userDbModel.id,
      };
      bool isItemInFavourites =
          await isItemInFavorites(itemId, userDbModel.id!);
      if (isItemInFavourites) {
        await databaseHelper.delete(DatabaseValues.tableFavourites,
            where:
                '${DatabaseValues.columnItemId} = ? AND ${DatabaseValues.columnUserId} = ?',
            whereArgs: [itemId, userDbModel.id]).then((value) {
          showToast(TextFile.removedFromSaved.tr);
          onSuccess!(typeFalse);
        });
      } else {
        await databaseHelper
            .insertItemMap(DatabaseValues.tableFavourites, model: map)
            .then((value) {
          showToast(TextFile.addedToSaved.tr);
          onSuccess!(typeTrue);
        }).onError((error, stackTrace) {
          debugPrint(error.toString());
        });
      }
    }
  }

  static Future<bool?> getFavouritesByItemId(id) async {
    if (DataSettings.isDBActive == true) {
      List<Map<String, dynamic>>? itemMaps;
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      await favoriteTableCreate();
      await databaseHelper.getItemsByQuery(
        DatabaseValues.tableFavourites,
        where:
            '${DatabaseValues.columnItemId} =? AND ${DatabaseValues.columnUserId} = ?',
        whereArgs: [id, userDbModel.id],
      ).then((value) {
        if (value != null) {
          itemMaps = value;
          return itemMaps!.isEmpty?false: true;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return itemMaps!.isEmpty?false: true;
    }
  }

}
