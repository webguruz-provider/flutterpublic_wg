import 'package:foodguru/app_values/export.dart';

Future<void> userTableCreate() async {
  await databaseHelper.createtables(databaseHelper.db!,
      tableName: DatabaseValues.tableUser,
      executeCommamd: """CREATE TABLE ${DatabaseValues.tableUser} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnFirstName} TEXT NOT NULL,
      ${DatabaseValues.columnLastName} TEXT NOT NULL,
      ${DatabaseValues.columnEmail} TEXT NOT NULL,
      ${DatabaseValues.columnImageUrl} TEXT,
      ${DatabaseValues.columnLoginType} TEXT,
      ${DatabaseValues.columnPhone} TEXT,
      ${DatabaseValues.columnPassword} TEXT NOT NULL,
      ${DatabaseValues.columnDeviceType} TEXT,
      ${DatabaseValues.columnDOB} TIMESTAMP NULL,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
}

Future<void> login(
    {String? email, String? password, Function()? onSuccess}) async {
  if (DataSettings.isDBActive == true) {
    await userTableCreate();
    List<Map<String, dynamic>>? itemMaps =
        await databaseHelper.getItems(DatabaseValues.tableUser);
    if (itemMaps != null) {
      List<UserDbModel> items =
          itemMaps.map((element) => UserDbModel.fromMap(element)).toList();
      int index = items.indexWhere((element) => email == element.email);
      if (index == -1) {
        showToast(TextFile.noUserFoundWithEmail.tr);
      } else {
        if (password == items[index].password) {
          PreferenceManger().saveRegisterData(items[index]);
          onSuccess!();
        } else {
          showToast(TextFile.incorrectPassword.tr);
        }
      }
    }
  }
}

Future<void> signUp({UserDbModel? userDbModel, Function()? onSuccess,isShowToast=true}) async {
  if (DataSettings.isDBActive == true) {
    await userTableCreate();
    List<Map<String, dynamic>>? itemMaps =
        await databaseHelper.getItems(DatabaseValues.tableUser);
    if (itemMaps != null) {
      List<UserDbModel> items =
          itemMaps.map((element) => UserDbModel.fromMap(element)).toList();
      int index =
          items.indexWhere((element) => element.email == userDbModel?.email);
      if (index == -1) {
        int index1 =
            items.indexWhere((element) => element.phone == userDbModel?.phone);
        if (index1 == -1) {
          await databaseHelper
              .insertItem(DatabaseValues.tableUser, model: userDbModel)
              .then((value) async {
            onSuccess!();
          }).onError((error, stackTrace) {
            if(isShowToast==true) {
              showToast(error.toString());
            }
          });
        } else {
          if(isShowToast==true){
            showToast(TextFile.userAlreadyExistsWithSamePhoneNumber.tr);
          }

        }
      } else {
        if(isShowToast==true){
          showToast(TextFile.userAlreadyExistsWithSameEmailID.tr);
        }

      }
    } else {
      debugPrint('Failed to fetch items from the database.');
    }
  }
}

Future<void> forgotPasswordMethod(
    {String? emailPhoneValue,
    Function(UserDbModel userDbModel)? onSuccess}) async {
  if (DataSettings.isDBActive == true) {
    await userTableCreate();
    List<Map<String, dynamic>>? itemMaps =
        await databaseHelper.getItems(DatabaseValues.tableUser);
    if (itemMaps != null) {
      List<UserDbModel> items =
          itemMaps.map((element) => UserDbModel.fromMap(element)).toList();
      int index = items.indexWhere((element) =>
          emailPhoneValue == element.email || emailPhoneValue == element.phone);
      if (index == -1) {
        if (GetUtils.isEmail(emailPhoneValue!)) {
          showToast(TextFile.noUserFoundWithEmail.tr);
        } else {
          showToast(TextFile.noUserFoundWithPhone.tr);
        }
      } else {
        onSuccess!(items[index]);
      }
    }
  }
}

Future<void> resetChangePassword(
    {UserDbModel? userDbModel, Function()? onSuccess}) async {
  if (DataSettings.isDBActive == true) {
    await userTableCreate();
    await databaseHelper
        .updateItem(DatabaseValues.tableUser,
            model: userDbModel, id: userDbModel?.id)
        .then((value) {
      onSuccess!();
    }).onError((error, stackTrace) {
      showToast(error.toString());
    });
  }




}
Future<UserDbModel?> getUserDetailsById({id}) async {
  List<UserDbModel> userList;
  if (DataSettings.isDBActive == true) {
    await userTableCreate();

    List<Map<String, dynamic>>? itemMaps = await databaseHelper.getItemsByQuery(
      DatabaseValues.tableUser,
      where:
      '${DatabaseValues.columnId} = ?',
      whereArgs: [id],
    );

    if (itemMaps != null) {
      userList = itemMaps
          .map((element) => UserDbModel.fromMap(element))
          .toList();
      debugPrint(userList.toString());
      return userList.first;
    } else {

      return null;
    }
  }
}

Future<void> updateProfile(
    {UserDbModel? userDbModel, Function()? onSuccess}) async {
  if (DataSettings.isDBActive == true) {
    List<Map<String, dynamic>>? itemMaps =
        await databaseHelper.getItems(DatabaseValues.tableUser);
    if (itemMaps != null) {
      List<UserDbModel> items =
          itemMaps.map((element) => UserDbModel.fromMap(element)).toList();
      int index =
          items.indexWhere((element) => element.email == userDbModel?.email);
      if (index == -1) {
        int index1 =
            items.indexWhere((element) => element.phone == userDbModel?.phone);
        if (index1 == -1) {
          print("sj");
        } else {
          showToast(TextFile.userAlreadyExistsWithSamePhoneNumber.tr);
        }
      } else {
        await databaseHelper.updateItem(DatabaseValues.tableUser, model: userDbModel,id: userDbModel?.id).then((value) async{
          onSuccess!();
        });
       // showToast(TextFile.userAlreadyExistsWithSameEmailID.tr);
      }
    } else {
      debugPrint('Failed to fetch items from the database.');
    }
  }
}
