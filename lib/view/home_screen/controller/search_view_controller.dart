import 'package:foodguru/app_values/export.dart';

class SearchViewController extends GetxController {
  RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;

  TextEditingController? searchController;
  FocusNode? searchNode;
  RxnString searchedValue = RxnString();
  RxInt viewType = 0.obs;
  RxList<RecentSearchesModel> recentSearchesList = <RecentSearchesModel>[].obs;

  @override
  void onInit() {
    searchController = TextEditingController();
    searchNode = FocusNode();
    fetchCategoryList();
    fetchRecentSearches();
    super.onInit();
  }

  addItemToRecentSearches({String? value, int? index}) async {
    if (index == 0) {
      var result = await Get.toNamed(AppRoutes.searchedItemListScreen,
          arguments: {keyName: searchController?.text.trim()});
      if (result != null) {
        fetchRecentSearches();
      }
    } else {
      var result = await Get.toNamed(AppRoutes.searchedRestaurantListScreen,
          arguments: {keyName: searchController?.text.trim()});
      if (result != null) {
        fetchRecentSearches();
      }
    }
    await RecentSearchesNetwork.addToRecentSearches(
      title: value ?? '',
      onSuccess: () {},
    );
    searchedValue.value = null;
    searchController?.clear();
  }

  fetchCategoryList() async {
    await CategoriesNetwork.getAllCategoriesList().then((value) {
      categoriesList.value = value ?? [];
    });
  }

  fetchRecentSearches() async {
    await RecentSearchesNetwork.getSearchesList().then((value) {
      recentSearchesList.value = value ?? [];
      recentSearchesList.refresh();
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  clearList() async {
    await RecentSearchesNetwork.clearList(onSuccess: () {
      recentSearchesList.clear();
    },);
  }

}
