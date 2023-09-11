import 'package:foodguru/app_values/export.dart';

class PaymentNetwork{

  static Future<void> pointsCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tablePoint,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tablePoint} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnUserId} INTEGER NOT NULL,
      ${DatabaseValues.columnPoints} INTEGER NOT NULL,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");


  }

  static Future<void> walletCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableWallet,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableWallet} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnUserId} INTEGER NOT NULL,
      ${DatabaseValues.columnWallet} INTEGER NOT NULL,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }



  static Future<void> addPoints(
      {
        Function()? onSuccess
      }) async {
    if (DataSettings.isDBActive == true) {
      await pointsCreate();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      Map<String, dynamic> map = <String, dynamic>{
        DatabaseValues.columnUserId: userDbModel.id ,
        DatabaseValues.columnPoints: 0,
      };
      await databaseHelper
          .insertItemMap(DatabaseValues.tablePoint, model: map)
          .then((value) {
       // showToast(TextFile.feedbackAddedSuccessfully.tr);
        onSuccess!();
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });

    }
  }

  static Future<void> getPointsByUserId({required  Function(PointsModel)? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      List<Map<String, dynamic>>? itemMaps;
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      await pointsCreate();
      await databaseHelper.getItemsByQuery(
        DatabaseValues.tablePoint,
        where:
        '${DatabaseValues.columnUserId} = ?',
        whereArgs: [userDbModel.id],
      ).then((value) {
        if (value != null) {
          itemMaps = value;
        var data=   PointsModel.fromJson(itemMaps![0]);
          onSuccess!(data);
        }
        print(value);

      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      //return itemMaps!.isEmpty ? false : true;
    }
  }

  static Future<void> updatePoints(
      {
        required int points,
       Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await pointsCreate();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      Map<String, dynamic> map = <String, dynamic>{
        DatabaseValues.columnUserId: userDbModel.id ,
        DatabaseValues.columnPoints: points,
      };
      debugPrint(map.toString());
      await databaseHelper.updateItemMap(DatabaseValues.tablePoint,
          model: map,
          where:
          '${DatabaseValues.columnUserId} = ?',
          whereArgs: [userDbModel.id]).then((value) {
            print("test");
        // showToast(TextFile.quantityUpdated.tr);
      //  onSuccess!(true);
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    }
  }


  static Future<void> updateWallet(
      {
        required int wallet,
        Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await walletCreate();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      Map<String, dynamic> map = <String, dynamic>{
        DatabaseValues.columnUserId: userDbModel.id ,
        DatabaseValues.columnWallet: wallet,
      };
      debugPrint(map.toString());
      await databaseHelper.updateItemMap(DatabaseValues.tableWallet,
          model: map,
          where:
          '${DatabaseValues.columnUserId} = ?',
          whereArgs: [userDbModel.id]).then((value) {
        print("test");
        // showToast(TextFile.quantityUpdated.tr);
         onSuccess!();
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    }
  }


  static Future<void> addWallet(
      {
        Function()? onSuccess
      }) async {
    if (DataSettings.isDBActive == true) {
      await walletCreate();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();

      Map<String, dynamic> map = <String, dynamic>{
        DatabaseValues.columnUserId: userDbModel.id ,
        DatabaseValues.columnWallet: 0,
      };
      await databaseHelper
          .insertItemMap(DatabaseValues.tableWallet, model: map)
          .then((value) {
        // showToast(TextFile.feedbackAddedSuccessfully.tr);
        onSuccess!();
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });

    }
  }

  static Future<void> getWalletByUserId({required  Function(WalletModel)? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      List<Map<String, dynamic>>? itemMaps;
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      await walletCreate();
      await databaseHelper.getItemsByQuery(
        DatabaseValues.tableWallet,
        where:
        '${DatabaseValues.columnUserId} = ?',
        whereArgs: [userDbModel.id],
      ).then((value) {
        if (value != null) {
          itemMaps = value;
          var data=  WalletModel.fromJson(itemMaps![0]);
          onSuccess!(data);
        }
        print(value);

      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      //return itemMaps!.isEmpty ? false : true;
    }
  }
}



