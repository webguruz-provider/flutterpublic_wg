

import '../../data/database/databse_values.dart';

class WalletModel {
  int? id;
  int? wallet;
  int? userId;
  String? createdOn;

  WalletModel({
    this.id,
    this.wallet,
    this.userId,
    this.createdOn,
  });

  WalletModel.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseValues.columnId];
    wallet = map[DatabaseValues.columnWallet];
    userId = map[DatabaseValues.columnUserId];
    createdOn = map[DatabaseValues.createdOn];
  }
  WalletModel.fromJson(Map<String, dynamic> map) {
    id = map[DatabaseValues.columnId];
    wallet = map[DatabaseValues.columnWallet];
    userId = map[DatabaseValues.columnUserId];
    createdOn = map[DatabaseValues.createdOn];

  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      DatabaseValues.columnId: id,
      DatabaseValues.columnWallet: wallet,
      DatabaseValues.columnUserId: userId,
      DatabaseValues.createdOn: createdOn,
    };
    return map;
  }


  Map<String, Object?> toJson() {
    var map = <String, Object?>{
      DatabaseValues.columnId: id,
      DatabaseValues.columnWallet: wallet,
      DatabaseValues.columnUserId: userId,
      DatabaseValues.createdOn: createdOn,
    };
    return map;
  }
}