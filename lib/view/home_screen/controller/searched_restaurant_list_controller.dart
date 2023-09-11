import 'package:foodguru/app_values/export.dart';

class SearchedRestaurantListController extends GetxController {
  TextEditingController? searchController;
  FocusNode? searchNode;
  int? couponId;
  RxList<RestaurantItemDataModel> restaurantList = <RestaurantItemDataModel>[].obs;
  RxList<RestaurantItemDataModel> searchList = <RestaurantItemDataModel>[].obs;
  RxList<RestaurantItemDataModel> tempRestaurantList = <RestaurantItemDataModel>[].obs;

  @override
  onInit() async {
    _initializeTextFieldsAndNodes();
    getArguments();
    await fetchRestaurantList();
    await fetchSearchRestaurantList();
    searchController?.addListener(() {
      searchFunction(searchController?.text ?? '');
    });

    super.onInit();
  }

  _initializeTextFieldsAndNodes() {
    searchController = TextEditingController();
    searchNode = FocusNode();
  }

  getArguments() {
    if (Get.arguments != null) {
      if(Get.arguments[keyName]!=null){
        searchController?.text = Get.arguments[keyName];
        searchController?.notifyListeners();
      }
      if(Get.arguments[keyId]!=null){
        couponId=Get.arguments[keyId];
      }
    }
  }

  fetchRestaurantList() async {
    if(couponId!=null){
        await OutletNetwork.getRestaurantListByCouponId(couponId).then((value) {
        restaurantList.value = value ?? [];
        tempRestaurantList.value = restaurantList.value;
      });
    }else{
      await OutletNetwork.getAllRestaurantList().then((value) {
        restaurantList.value = value ?? [];
        tempRestaurantList.value = restaurantList.value;
      });
    }


  }

  fetchSearchRestaurantList() async {
    await OutletNetwork.getSearchAllRestaurantList().then((value) {
      searchList.value = value ?? [];
      //tempRestaurantList.value = searchList.value;
    });
  }

  searchFunction(String value) async{
    restaurantList.value = [];
    int languageId = await PreferenceManger().getLanguageId();
    if (value.isNotEmpty) {
      for (int i = 0; i < searchList.length; i++) {
        if (searchList[i].restaurantName!.toLowerCase().contains(value.toLowerCase())) {
        for(int j=0 ; j< searchList.length; j++){
          if(searchList[j].outletId == searchList[i].outletId && searchList[j].languageId == languageId){
            restaurantList.add(searchList[j]);
          }
        }}}
      restaurantList.value = restaurantList.toSet().toList();
    } else {
      restaurantList.value = tempRestaurantList;
    }
  }

  @override
  void onClose() {
    searchController?.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    searchController?.dispose();
    super.dispose();
  }
}
