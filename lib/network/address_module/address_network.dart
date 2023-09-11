import 'package:foodguru/app_values/export.dart';

class AddressNetwork {
  static Future<void> addressTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableAddress,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableAddress} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnUserId} INTEGER NOT NULL,
      ${DatabaseValues.columnAddress} TEXT NOT NULL,
      ${DatabaseValues.columnCity} TEXT ,
      ${DatabaseValues.columnState} TEXT,
      ${DatabaseValues.columnCountry} TEXT,
      ${DatabaseValues.columnPinCode} TEXT,
      ${DatabaseValues.columnLatitude} DOUBLE NOT NULL,
      ${DatabaseValues.columnLongitude} DOUBLE NOT NULL,
      ${DatabaseValues.columnAddressType} INTEGER,
      ${DatabaseValues.columnIsManualAddress} INTEGER
    )""");
  }

  static Future<void> addAddress({Function()? onSuccess, data}) async {
    if (DataSettings.isDBActive == true) {
      await addressTableCreate();
      await databaseHelper
          .insertItemMap(
        isReturnId: true,
        DatabaseValues.tableAddress,
        model: data,
      ).then((value) {
        onSuccess!();
        showToast(TextFile.addressAddedSuccessfully.tr);
      }).onError((error, stackTrace) {
        showToast(error.toString());
        debugPrint(error.toString());
      });
    }
  }
  static Future<void> updateAddress({Function()? onSuccess,id, data}) async {
    if (DataSettings.isDBActive == true) {
      await addressTableCreate();
      await databaseHelper
          .updateItemMap(
        DatabaseValues.tableAddress,id: id,
        model: data,
      )
          .then((value) {
        onSuccess!();
        showToast(TextFile.addressAddedSuccessfully.tr);
      }).onError((error, stackTrace) {
        showToast(error.toString());
        debugPrint(error.toString());
      });
    }
  }

  static Future<bool> isDuplicateEntry(
      {userId, address, latitude, longitude}) async {
    await addressTableCreate();
    List<Map<String, dynamic>> result = await databaseHelper.rawQuery(
        """ SELECT COUNT(*) as count FROM address WHERE ${DatabaseValues.columnUserId} = $userId AND  ${DatabaseValues.columnAddress} = "$address" AND ${DatabaseValues.columnLatitude} = $latitude AND ${DatabaseValues.columnLongitude} = $longitude""");
    return result.isNotEmpty && result.first['count'] > 0;
  }

  static Future<List<AddressModel>?> getAllAddressList() async {
    if (DataSettings.isDBActive == true) {
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      List<AddressModel>? addressList;
      await addressTableCreate();
      await databaseHelper.getItemsByQuery(DatabaseValues.tableAddress,
          where: '${DatabaseValues.columnUserId} = ?',
          whereArgs: [userDbModel.id]).then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          debugPrint(itemMaps.toString());
          addressList = itemMaps
              .map((element) => AddressModel.fromJson(element))
              .toList();
          return addressList;
        }
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return addressList ?? [];
    }
  }

  static Future<void>deleteAddress(id, {Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await addressTableCreate();
      await databaseHelper.delete(DatabaseValues.tableAddress,id: id).then((value) {
        onSuccess!();
        showToast(TextFile.addressDeletedSuccessfully.tr);
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    }
  }
}
