import 'package:foodguru/app_values/export.dart';


class DineInTableNetwork {
  static Future<void> dineInTableTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableDineInTable,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableDineInTable} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnTableId} INTEGER,
      ${DatabaseValues.columnOutletId} INTEGER,
      ${DatabaseValues.columnIsAvailable} INTEGER
    )""");
  }

  static Future<void> insertDineInTable({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await dineInTableTableCreate();
      List<Map<String, dynamic>>? itemMaps =
          await databaseHelper.getItems(DatabaseValues.tableDineInTable);
      if (itemMaps!.isEmpty) {
        DummyLists.dineInTableList.forEach((element) async {
          await databaseHelper
              .insertItemMap(DatabaseValues.tableDineInTable, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            debugPrint(error.toString());
          });
        });
      }
    }
  }

  static Future<List<TableModel>?> getTableList(
      {outletId,fromTime,toTime}) async {
    if (DataSettings.isDBActive == true) {
      List<TableModel>? tableList;
      await dineInTableTableCreate();
      await databaseHelper.rawQuery("""
          SELECT dt.*,
       tm.seat_size,
 IFNULL(match_count, 0) AS match_count
  FROM dineInTable as dt
  INNER JOIN dineInTableMain as tm
  on tm.id=dt.table_id
  LEFT JOIN (
    SELECT dt.id, COUNT(*) AS match_count
    FROM dineInTable AS dt
    JOIN orders AS ord
    ON ',' || ord.table_id || ',' LIKE '%,' || CAST(dt.id AS TEXT) || ',%'
    WHERE to_time BETWEEN '${fromTime}' AND '${toTime}'
       OR from_time BETWEEN '${fromTime}' AND '${toTime}'
    GROUP BY dt.id
) AS counts
ON dt.id = counts.id
 WHERE outlet_id = $outletId
 ORDER BY tm.seat_size DESC
  """).then((value) async {
        if (value != null) {
          List<Map<String, dynamic>> itemMap = value;
          tableList = itemMap
              .map((element) => TableModel.fromJson(element))
              .toList();
          debugPrint(itemMap.toString());
          return tableList;
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
      return tableList ?? [];
    }
  }
}
