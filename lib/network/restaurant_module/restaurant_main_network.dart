import 'package:foodguru/app_values/export.dart';

class RestaurantMainNetwork {
  static Future<void> restaurantMainTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableRestaurantMain,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableRestaurantMain} (
      ${DatabaseValues.columnRestaurantId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnRestaurantName} TEXT NOT NULL
    )""");
  }

  static Future<void> insertRestaurantMain({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await restaurantMainTableCreate();
      List<Map<String, dynamic>>? itemMaps =
          await databaseHelper.getItems(DatabaseValues.tableRestaurantMain);
      if (itemMaps!.isEmpty) {
        DummyLists.mainRestaurantList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableRestaurantMain, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
          });
        });
      }
    }
  }
}
