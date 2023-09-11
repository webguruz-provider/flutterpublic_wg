import 'package:foodguru/app_values/export.dart';
import 'package:sembast_web/sembast_web.dart';


class DatabaseHelper {
  Database? db;

  Future<bool> isTableExists(Database database, String tableName) async {
    final List<Map<String, dynamic>> tables = await database.query(
      'sqlite_master',
      where: 'type = ? AND name = ?',
      whereArgs: ['table', tableName],
    );
    return tables.isNotEmpty;
  }

  Future<void> createtables(Database database,
      {tableName, executeCommamd}) async {
    final bool tableExists = await isTableExists(database, tableName);

    if (!tableExists) {
      await database.execute(executeCommamd);
      print('Table Created');
    } else {
      print('Table already exists $tableName');
    }
  }

  Future<Database?> dpOpen() async {


    if (GetPlatform.isWeb) {
      var factory = databaseFactoryWeb;
     var dbb = await factory.openDatabase(
        DatabaseValues.dbName, version: DatabaseValues.dbVersion,);
      db=dbb as Database?;
      debugPrint(db?.path);
      return db;
    } else {
            db = await openDatabase(
        DatabaseValues.dbName,
        version: DatabaseValues.dbVersion,
        onConfigure: (Database database) async {},
      );
      debugPrint(db?.path);
      return db;
    }
  }

  Future<dynamic> insertItem(String tableName, {dynamic model}) async {
    await db?.insert(
      tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint("Data Inserted Successfully into $tableName ${model}");
    return model;
  }

  Future<dynamic> insertItemMap(String tableName,
      {dynamic model, isReturnId = false}) async {
    try {
      final id = await db?.insert(
        tableName,
        model,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint("Data Inserted Successfully into $tableName ${model}");
      // debugPrint(id.toString());
      return isReturnId == true ? id : model;
    }
    catch (e) {
      return e;
    }
  }


  Future<dynamic> rawQuery(query,) async {
    return await db?.rawQuery(query,);
  }

  Future<dynamic> query(query,
      {List<String>? columns, where, List<Object?>? whereArgs}) async {
    return await db?.query(
        query, columns: columns, where: where, whereArgs: whereArgs);
  }


  Future<List<Map<String, dynamic>>?> getItems(tableName) async {
    if (db == null) {
      debugPrint('Database is not open. Open the database first.');
      return null;
    }
    return await db?.query(tableName);
  }

  Future<Map<String, dynamic>?> getItemsById(tableName, {id}) async {
    if (db == null) {
      debugPrint('Database is not open. Open the database first.');
      return null;
    }
    List<Map<String, dynamic>>?item = await db?.query(
      tableName,
      where: '${DatabaseValues.columnId} = ?',
      whereArgs: [id],
    );
    return item?.first;
  }

  Future<List<Map<String, dynamic>>?> getItemsByQuery(tableName,
      {required String? where, required List<
          Object?>?whereArgs, orderBy}) async {
    if (db == null) {
      debugPrint('Database is not open. Open the database first.');
      return null;
    }
    List<Map<String, dynamic>>?item = await db?.query(
        tableName,
        where: where,
        whereArgs: whereArgs, orderBy: orderBy
    );
    return item;
  }

  Future<int?> delete(tableName,
      {int? id, where, List<Object?>? whereArgs}) async {
    debugPrint('Item Deleted Successfully');
    return await db?.delete(tableName,
        where: where ?? '${DatabaseValues.columnId} = ?',
        whereArgs: whereArgs ?? [id]);
  }

  Future<int?> deleteTable(tableName) async {
    debugPrint('Item Deleted Successfully');
    return await db?.delete(tableName,);
  }

  Future<dynamic> updateItem(String tableName, {dynamic model, id}) async {
    if (id != null) {
      int? rowsAffected = await db?.update(
        tableName,
        model.toMap(),
        where: '${DatabaseValues.columnId} = ?',
        whereArgs: [id],
      );

      if (rowsAffected! > 0) {
        debugPrint("Data Updated Successfully ");
      } else {
        debugPrint("Data Update Failed ");
      }
    } else {
      debugPrint("Cannot update item with null ID");
    }
  }

  Future<void> updateItemMap(String tableName,
      {dynamic model, id, String? where, List<Object?>? whereArgs}) async {
    int? rowsAffected = await db?.update(
      tableName,
      model,
      where: where ?? '${DatabaseValues.columnId} = ?',
      whereArgs: whereArgs ?? [id],
    );

    if (rowsAffected! > 0) {
      debugPrint("Data Updated Successfully ");
    } else {
      debugPrint("Data Update Failed ");
    }
  }

  Future<void> deleteTable1(Database database, {tableName}) async {
    try {
      database.execute("DROP TABLE IF EXISTS ${tableName}");
      debugPrint('Table Deleted Successfully');
    } catch (e) {
      debugPrint('Error Deleting Table $e');
    }
  }
}
