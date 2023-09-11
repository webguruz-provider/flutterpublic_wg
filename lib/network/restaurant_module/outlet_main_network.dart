import 'package:foodguru/app_values/export.dart';


class OutletMainNetwork {
  static Future<void> outletMainTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableOutletMain,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableOutletMain} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnRestaurantId} INTEGER,
      ${DatabaseValues.columnOutlet} TEXT NOT NULL,
       ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<void> insertOutletMain({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await outletMainTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableOutletMain);
      if (itemMaps!.isEmpty) {
        DummyLists.mainOutletList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableOutletMain, model: element)
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
