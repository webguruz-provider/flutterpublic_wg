import 'package:foodguru/app_values/export.dart';

class CartNetwork {
  static Future<void> cartTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableCart,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableCart} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnItemId} INTEGER,
      ${DatabaseValues.columnUserId} INTEGER,
      ${DatabaseValues.columnRestaurantId} INTEGER,
      ${DatabaseValues.columnQuantity} INTEGER DEFAULT 1,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<bool> isItemInCart(int itemId, int userId) async {
    List<Map<String, dynamic>> maps = await databaseHelper.query(
        DatabaseValues.tableCart,
        columns: [DatabaseValues.columnItemId],
        where:
            '${DatabaseValues.columnItemId} = ? AND ${DatabaseValues.columnUserId} = ?',
        whereArgs: [itemId, userId]);
    return maps.isNotEmpty;
  }

  static Future<void> addRemoveToCart(
      {required int itemId,
      required int restaurantId,
      required int quantity,
      ValueChanged<bool>? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await cartTableCreate();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      Map<String, dynamic> map = <String, dynamic>{
        DatabaseValues.columnItemId: itemId,
        DatabaseValues.columnUserId: userDbModel.id,
        DatabaseValues.columnRestaurantId: restaurantId,
        DatabaseValues.columnQuantity: quantity,
      };
      bool isItemInFavourites = await isItemInCart(itemId, userDbModel.id!);
      if (isItemInFavourites) {
        await removeFromCart(itemId: itemId);
        onSuccess!(false);
      } else {
        await addToCart(
            itemId: itemId, outletId: restaurantId, quantity: quantity,onSuccess: (value) {
          onSuccess!(true);
            },);

      }
    }
  }

  static Future<bool> isItemInCartWithSameOutlet({
    required int userId,
    required int restaurantId,
  }) async {
    List<Map<String, dynamic>> list = await databaseHelper.query(
      DatabaseValues.tableCart,
      where: "${DatabaseValues.columnUserId} = ?",
      whereArgs: [userId],
    );
    List<Map<String, dynamic>> listSameRestaurant = await databaseHelper.query(
      DatabaseValues.tableCart,
      where:
          "${DatabaseValues.columnUserId} = ? AND ${DatabaseValues.columnRestaurantId} = ?",
      whereArgs: [userId, restaurantId],
    );
    if (list.isEmpty) {
      return true;
    } else {
      return listSameRestaurant.isNotEmpty;
    }
  }

  static Future<void> addToCart(
      {required int itemId,
      required int outletId,
      required int? quantity,
      ValueChanged<bool>? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await cartTableCreate();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      bool isItemPresentWithSameRestaurantId =
          await isItemInCartWithSameOutlet(
              userId: userDbModel.id!, restaurantId: outletId);
      if (isItemPresentWithSameRestaurantId == true) {
        Map<String, dynamic> map = <String, dynamic>{
          DatabaseValues.columnItemId: itemId,
          DatabaseValues.columnUserId: userDbModel.id,
          DatabaseValues.columnRestaurantId: outletId,
          DatabaseValues.columnQuantity: quantity,
        };
        await databaseHelper
            .insertItemMap(DatabaseValues.tableCart, model: map)
            .then((value) {
          showToast(TextFile.addedToCart.tr);
          onSuccess!(true);
        }).onError((error, stackTrace) {
          debugPrint(error.toString());
        });
      } else {
        // showToast('Message');
        Get.dialog(Center(
            child: Container(
          margin: EdgeInsets.all(margin_40),
          padding: EdgeInsets.symmetric(vertical: margin_10,horizontal: margin_15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius_10)),
          child: Material(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                'An Item from Different Restaurant is already present in Cart. Do you want to remove it and add this item?',
                textAlign: TextAlign.center,
                style: AppStyle.txtDMSansBold12.copyWith(color: Colors.black),
              ),
              Row(children: [
                Expanded(
                  child: GetInkwell(
                    onTap: () async {
                      Get.back();
                     await databaseHelper.deleteTable(DatabaseValues.tableCart);
                      Map<String, dynamic> map = <String, dynamic>{
                        DatabaseValues.columnItemId: itemId,
                        DatabaseValues.columnUserId: userDbModel.id,
                        DatabaseValues.columnRestaurantId: outletId,
                        DatabaseValues.columnQuantity: quantity,
                      };
                      await databaseHelper
                          .insertItemMap(DatabaseValues.tableCart, model: map)
                          .then((value) {
                        showToast(TextFile.addedToCart.tr);
                        onSuccess!(true,);
                      }).onError((error, stackTrace) {
                        debugPrint(error.toString());
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(margin_8),
                      decoration: BoxDecoration(
                          color: ColorConstant.greenA700,
                          borderRadius: BorderRadius.circular(radius_25)),
                      child: Text('${TextFile.yes.tr}',
                          style: AppStyle.txtDMSansBold14.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(width: width_10),
                Expanded(
                  child: GetInkwell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(alignment: Alignment.center,
                      padding: EdgeInsets.all(margin_8),
                      decoration: BoxDecoration(
                          color: ColorConstant.red500,
                          borderRadius: BorderRadius.circular(radius_25)),
                      child: Text('${TextFile.no.tr}',
                          style: AppStyle.txtDMSansBold14.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ],).marginOnly(top: margin_15)
            ]),
          ),
        )));


      }
    }
  }

  static Future<void> removeFromCart({required int itemId}) async {
    if (DataSettings.isDBActive == true) {
      await cartTableCreate();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      await databaseHelper.delete(DatabaseValues.tableCart,
          where:
              '${DatabaseValues.columnItemId} = ? AND ${DatabaseValues.columnUserId} = ?',
          whereArgs: [itemId, userDbModel.id]).then((value) {
        showToast(TextFile.removedFromCart.tr);
      });
    }
  }

  static Future<void> updateQuantityOfCart(
      {required int itemId,
      required int restaurantId,
      required int? quantity,
      ValueChanged<bool>? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await cartTableCreate();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      Map<String, dynamic> map = <String, dynamic>{
        DatabaseValues.columnItemId: itemId,
        DatabaseValues.columnUserId: userDbModel.id,
        DatabaseValues.columnRestaurantId: restaurantId,
        DatabaseValues.columnQuantity: quantity,
      };
      debugPrint(map.toString());
      await databaseHelper.updateItemMap(DatabaseValues.tableCart,
          model: map,
          where:
              '${DatabaseValues.columnItemId} = ? AND ${DatabaseValues.columnUserId} = ?',
          whereArgs: [itemId, userDbModel.id]).then((value) {
        // showToast(TextFile.quantityUpdated.tr);
        onSuccess!(true);
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    }
  }

  static Future<bool?> getIsAddedToCartByItemId(id) async {
    if (DataSettings.isDBActive == true) {
      List<Map<String, dynamic>>? itemMaps;
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      await cartTableCreate();
      await databaseHelper.getItemsByQuery(
        DatabaseValues.tableCart,
        where:
            '${DatabaseValues.columnItemId} =? AND ${DatabaseValues.columnUserId} = ?',
        whereArgs: [id, userDbModel.id],
      ).then((value) {
        if (value != null) {
          itemMaps = value;
          return itemMaps!.isEmpty ? false : true;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return itemMaps!.isEmpty ? false : true;
    }
  }

  static Future<int?> getCartQuantityByItemId(id) async {
    if (DataSettings.isDBActive == true) {
      List<Map<String, dynamic>>? itemMaps;
      await cartTableCreate();
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      bool? isItemPresentInCart = await isItemInCart(id, userDbModel.id!);
      if (isItemPresentInCart == true) {
        await databaseHelper.getItemsByQuery(
          DatabaseValues.tableCart,
          where:
              '${DatabaseValues.columnItemId} =? AND ${DatabaseValues.columnUserId} = ?',
          whereArgs: [id, userDbModel.id],
        ).then((value) async {
          if (value != null) {
            itemMaps = value;
            isItemPresentInCart = await isItemInCart(id, userDbModel.id!);
            return itemMaps!.first["quantity"];
          }
          print(value);
        }).onError((error, stackTrace) {
          showToast(error.toString());
        });
        return itemMaps!.first["quantity"];
      } else {
        return 0;
      }
    }
  }
}
