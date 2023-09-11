import 'package:foodguru/app_values/export.dart';

class CategoriesNetwork {
  static Future<void> categoriesTableCreate() async {
    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableCategories,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableCategories} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnLanguageId} INTEGER,
      ${DatabaseValues.columnCategoryId} INTEGER,
      ${DatabaseValues.columnCategoryName} TEXT NOT NULL,
      ${DatabaseValues.columnImageUrl} TEXT,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  static Future<void> insertCategory({Function()? onSuccess}) async {
    if (DataSettings.isDBActive == true) {
      await categoriesTableCreate();
      List<Map<String, dynamic>>? itemMaps =
          await databaseHelper.getItems(DatabaseValues.tableCategories);
      if (itemMaps!.isEmpty) {
        DummyLists.categoryList.forEach((element) async {
          await databaseHelper
              .insertItem(DatabaseValues.tableCategories, model: element)
              .then((value) {
            onSuccess!();
          }).onError((error, stackTrace) {
            showToast(error.toString());
            debugPrint(error.toString());
          });
        });
      } else {
        debugPrint("Categories Data Already Added");
      }
    }
  }

  static Future<List<CategoryModel>?> getAllCategoriesList() async {
    if (DataSettings.isDBActive == true) {
      var languageId = await PreferenceManger().getLanguageId();
      List<CategoryModel>? categoryList;
      await categoriesTableCreate();
      await databaseHelper.getItemsByQuery(DatabaseValues.tableCategories,
          where: '${DatabaseValues.columnLanguageId} = ?',
          whereArgs: [languageId],
        orderBy: '${DatabaseValues.createdOn} DESC'
      ).then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          categoryList = itemMaps
              .map((element) => CategoryModel.fromMap(element))
              .toList();
          return categoryList;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return categoryList ?? [];
    }
  }

  static Future<List<CategoryModel>?> getSearchAllCategoriesList() async {
    if (DataSettings.isDBActive == true) {
      List<CategoryModel>? categoryList;
      await categoriesTableCreate();
      await databaseHelper.getItems(DatabaseValues.tableCategories,

          ).then((value) {
        if (value != null) {
          List<Map<String, dynamic>>? itemMaps = value;
          categoryList = itemMaps
              .map((element) => CategoryModel.fromMap(element))
              .toList();
          return categoryList;
        }
        print(value);
      }).onError((error, stackTrace) {
        showToast(error.toString());
      });
      return categoryList ?? [];
    }
  }

  static Future<String> getCategoriesById(List<int> id) async {
    if (DataSettings.isDBActive == true) {
      var languageId = await PreferenceManger().getLanguageId();
      await categoriesTableCreate();

      List<Map<String, dynamic>>? itemMaps = await databaseHelper.getItemsByQuery(
        DatabaseValues.tableCategories,
        where:
        '${DatabaseValues.columnLanguageId} = ? AND ${DatabaseValues.columnCategoryId} IN (${id.map((id) => '?').join(',')})',
        whereArgs: [languageId, ...id],
      );

      if (itemMaps != null) {
        List<CategoryModel> tempcategoryList = itemMaps
            .map((element) => CategoryModel.fromMap(element))
            .toList();
        List<String> categoryList=[];
        tempcategoryList.forEach((element) {
          categoryList.add(element.categoryName??'');
        });
        return categoryList.join(', ');
      } else {
        print(itemMaps);
        return '';
      }
    } else {
      return '';
    }
  }


  static getCategoriesString(List<int> id) {
    List<String> listString = [];
    id.forEach((element) {
      listString.add('${DatabaseValues.columnCategoryId} =?');
    });
    debugPrint(listString.join(','));
  }

  static getCategoriesId(List<int> id) {
    List<String> listString = [];
    id.forEach((element) {
      listString.add('$element');
    });
    debugPrint(listString.join(','));
  }
}
