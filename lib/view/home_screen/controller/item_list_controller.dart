import 'package:foodguru/app_values/export.dart';

class ItemListController extends GetxController{
  RxString category=''.obs;
  RxnInt categoryId=RxnInt();
  bool isSeasonalSpecial=false;
  bool isRecentlyOrdered=false;
  int itemListType=0;
  @override
  void onInit() {

    _getArguments();
    fetchData();

    super.onInit();
  }

  RxList<ItemModel> itemsList = <ItemModel>[

  ].obs;

  _getArguments() {
    if(Get.arguments!=null){
      category.value=Get.arguments[keyCategory];
      if(Get.arguments[keyId]!=null){
        categoryId.value=Get.arguments[keyId];
      }
      if(Get.arguments[keyItemListType]!=null){
        itemListType=Get.arguments[keyItemListType];
      }

    }
  }




  fetchData(){
    if(categoryId.value!=null){
      getItemListByCategoryId();
    }else if(itemListType==keyItemSeasonalSpecial){
      getSeasonalItemsList();
    }else if(itemListType==keyItemRecentlyOrdered){
      getRecentlyOrderedItemsList();
    }else if(itemListType==keyItemRecommended){
      getRecommendedList();
    }
    else{
      getAllItemList();
    }

  }
  getAllItemList() async {
    await ItemNetwork.getAllItemsList().then((value) {
      itemsList.value=value!;
      itemsList.refresh();
    });
  }

  getSeasonalItemsList() async {
    await ItemNetwork.getSeasonalItemsList().then((value) {
      itemsList.value=value!;
      itemsList.refresh();
    });
  }
  getRecentlyOrderedItemsList() async {
    await ItemNetwork.recentlyOrderedList().then((value) {
      itemsList.value=value!;
      itemsList.refresh();
    });
  }
  getRecommendedList() async {
    await ItemNetwork.recommendedItemsList().then((value) {
      itemsList.value=value!;
      itemsList.refresh();
    });
  }

  getItemListByCategoryId() async {
    await ItemNetwork.getItemsByCategoryId(id: categoryId.value).then((value) {
      itemsList.value=value!;
      itemsList.refresh();
    });
  }




}