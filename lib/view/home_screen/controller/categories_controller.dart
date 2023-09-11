import 'package:foodguru/app_values/export.dart';

class CategoriesController extends GetxController{
  RxList<int> valueInItems = <int>[2, 3, 4].obs;
  RxnInt selectedValue=RxnInt();
  RxList<CategoryModel>categoriesList=<CategoryModel>[].obs;
  RxList<CategoryModel> searchList = <CategoryModel>[].obs;
  RxList<CategoryModel>tempCategoriesList=<CategoryModel>[].obs;


  @override
  void onInit() async{
    await fetchCategoryList();
    await  fetchSearchCategoryList();
    super.onInit();
  }

  fetchCategoryList() async {
    await CategoriesNetwork.getAllCategoriesList().then((value) {
      categoriesList.value=value??[];
      tempCategoriesList.value=categoriesList.value;
    });
    update();
  }
  fetchSearchCategoryList() async {
    await CategoriesNetwork.getSearchAllCategoriesList().then((value) {
      searchList.value=value??[];

    });
    update();
  }

  // searchFunction(String value){
  //   categoriesList.value = [];
  //   if (value.isNotEmpty) {
  //     for (int i = 0; i < tempCategoriesList.length; i++) {
  //       if (tempCategoriesList[i].categoryName!
  //           .toLowerCase()
  //           .contains(value.toLowerCase())) {
  //         categoriesList.add(
  //           tempCategoriesList[i],
  //         );
  //
  //       }
  //     }
  //   } else {
  //     categoriesList.value = tempCategoriesList;
  //   }
  //   update();
  // }

  searchFunction(String value) async{
    categoriesList.value = [];
    int languageId = await PreferenceManger().getLanguageId();
    if (value.isNotEmpty) {
      for (int i = 0; i < searchList.length; i++) {
        if (searchList[i].categoryName!.toLowerCase().contains(value.toLowerCase())) {
          for(int j=0 ; j< searchList.length; j++){
            if(searchList[j].categoryId == searchList[i].categoryId && searchList[j].languageId == languageId ){
              categoriesList.add(searchList[j]);
            }
          }

        }
      }

      categoriesList.value = categoriesList.toSet().toList();


    } else {
      categoriesList.value = tempCategoriesList;
    }
  }
}
