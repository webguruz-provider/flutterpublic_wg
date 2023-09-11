import 'package:foodguru/app_values/export.dart';

class LanguageNetwork{
  static Future<void> languageTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableLanguage,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableLanguage} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnTitle} TEXT NOT NULL,
      ${DatabaseValues.columnLanguageCode} TEXT
    )""");
  }
  static Future<void> insertLanguage({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await languageTableCreate();
      List<Map<String, dynamic>>? itemMaps =
      await databaseHelper.getItems(DatabaseValues.tableLanguage);
      if (itemMaps!.isEmpty) {
        DummyLists.languageList.forEach((element) async {
          await databaseHelper
              .insertItem(DatabaseValues.tableLanguage, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            showToast(error.toString());
          });
        });
      }
    }
  }
  static Future<List<LanguageModel>?> getAllLanguageList() async {
    if (DataSettings.isDBActive == true) {
      List<LanguageModel>? languageList;
      await languageTableCreate();
      await databaseHelper
          .getItems(DatabaseValues.tableLanguage)
          .then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          languageList = itemMaps
              .map((element) => LanguageModel.fromMap(element))
              .toList();
          return languageList;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return languageList ?? [];
    }
  }
}