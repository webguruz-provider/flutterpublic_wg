import 'package:foodguru/app_values/export.dart';

class RecentSearchesNetwork {
  static Future<void> recentSearchTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableRecentSearch,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableRecentSearch} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnUserId} INTEGER NOT NULL,
      ${DatabaseValues.columnTitle} INTEGER NOT NULL,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<void> addToRecentSearches(
      {required String title, Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await recentSearchTableCreate();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();

      bool isItemPresent = await isItemAlreadyPresent(title, userDbModel.id!);
      if (isItemPresent) {
        await databaseHelper.delete(
          DatabaseValues.tableRecentSearch,
          where:
              "${DatabaseValues.columnUserId} = ? AND ${DatabaseValues.columnTitle} = ?",
          whereArgs: [userDbModel.id, title],
        ).then((value) async {
          Map<String, dynamic> map = <String, dynamic>{
            DatabaseValues.columnUserId: userDbModel.id,
            DatabaseValues.columnTitle: title,
          };
          await databaseHelper
              .insertItemMap(DatabaseValues.tableRecentSearch, model: map)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
          });
        });
      } else {
        Map<String, dynamic> map = <String, dynamic>{
          DatabaseValues.columnUserId: userDbModel.id,
          DatabaseValues.columnTitle: title,
        };
        await databaseHelper
            .insertItemMap(DatabaseValues.tableRecentSearch, model: map)
            .then((value) {
          onSuccess!();
        }).onError((error, stackTrace) {
          debugPrint(error.toString());
        });
      }
    }
  }

  static Future<bool> isItemAlreadyPresent(String title, int userId) async {
    List<Map<String, dynamic>> results = await databaseHelper.query(
      DatabaseValues.tableRecentSearch,
      where:
          "${DatabaseValues.columnUserId} = ? AND ${DatabaseValues.columnTitle} = ?",
      whereArgs: [userId, title],
    );
    return results.isNotEmpty;
  }

  static Future<List<RecentSearchesModel>?> getSearchesList() async {
    if (DataSettings.isDBActive == true) {
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      List<RecentSearchesModel>? recentList;
      await recentSearchTableCreate();
      await databaseHelper.getItemsByQuery(DatabaseValues.tableRecentSearch,
          where: '${DatabaseValues.columnUserId} = ?',
          whereArgs: [userDbModel.id]).then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          recentList = itemMaps
              .map((element) => RecentSearchesModel.fromJson(element))
              .toList();
          return recentList;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
        debugPrint(error.toString());
      });
      return recentList ?? [];
    }
  }

  static Future clearList({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      await databaseHelper.delete(DatabaseValues.tableRecentSearch,
          where: "${DatabaseValues.columnUserId} = ?",
          whereArgs: [userDbModel.id]).then((value) {
        if (onSuccess != null) {
          onSuccess();
        }
      });
    }
  }
}
