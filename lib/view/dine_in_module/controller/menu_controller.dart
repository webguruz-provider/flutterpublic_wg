import 'package:foodguru/app_values/export.dart';

class MenuViewController extends GetxController {
  Rx<PopupMenuModel> selectedValue = PopupMenuModel(id: 1, title: 'Veg/Non-Veg', image: ImageConstant.imagesIcVegNonveg).obs;

  RxList<ItemModel> selectedItems=<ItemModel>[].obs;
  RxList<PopupMenuModel> popupList = <PopupMenuModel>[
    PopupMenuModel(
        id: 1, title: 'Veg/Non-Veg', image: ImageConstant.imagesIcVegNonveg),
    PopupMenuModel(id: 2, title: 'Veg', image: ImageConstant.imagesIcVeg),
    PopupMenuModel(
        id: 3, title: 'Non-Veg', image: ImageConstant.imagesIcNonVeg),
  ].obs;
  OrderDataSendModel? orderDataSendModel;
  TextEditingController? searchController;
  FocusNode? searchNode;
  RxString searchedValue=''.obs;

  RxList<ItemModel> tempItemsList = <ItemModel>[].obs;
  RxList<ItemModel> tempSearchItemsList = <ItemModel>[].obs;
  RxList<ItemModel> tempSearchList = <ItemModel>[].obs;

  RxList<ItemModel> itemsList = <ItemModel>[].obs;


  RxList<ItemModel> searchList = <ItemModel>[].obs;


  @override
  void onInit()async {
    _initializeTextFieldsAndNodes();
    searchController?.addListener(() {
      searchFunction(searchController?.text ?? '');
    });
    getArguments();
    getItemDetails();
    await getSearchItemDetails();
    super.onInit();
  }


  getArguments(){
    if(Get.arguments!=null){
      orderDataSendModel=Get.arguments[keyModel];
      debugPrint(orderDataSendModel?.outletId.toString());
    }

  }

  _initializeTextFieldsAndNodes(){
    searchController = TextEditingController();
    searchNode = FocusNode();
  }
  onCategorySelected(PopupMenuModel value) {
    selectedValue.value = value;
    itemsList.value = [];
    for (var i = 0; i < tempItemsList.length; ++i) {
      if (selectedValue.value.id == typeVeg) {
        if (tempItemsList[i].isVeg == typeTrue) {
          itemsList.add(tempItemsList[i]);
        }
      } else if (selectedValue.value.id == typeNonVeg) {
        if (tempItemsList[i].isVeg == typeFalse) {
          itemsList.add(tempItemsList[i]);
        }
      } else {
        itemsList.value = tempItemsList;
      }
    }
  }

  searchFunction(String value) async{
    itemsList.value = [];
    int languageId = await PreferenceManger().getLanguageId();
    if (value.isNotEmpty) {
      for (int i = 0; i < searchList.length; i++) {
        if (searchList[i].itemName!.toLowerCase().contains(value.toLowerCase())) {
          for(int j=0 ; j< searchList.length; j++){
            if(searchList[j].itemId == searchList[i].itemId && searchList[j].languageId == languageId ){
              itemsList.add(searchList[j]);
            }
          }

        }
      }

      itemsList.value = itemsList.toSet().toList();


    } else {
      itemsList.value = tempSearchList;
    }
  }
  getItemDetails() async {
    await ItemNetwork.getItemsByOutletId(
            id: Get.find<DineInDetailsController>().restaurantId)
        .then((value) {
      itemsList.value = value!;
      tempItemsList.value = itemsList.value;
      tempSearchItemsList.value = itemsList.value;
      tempSearchList.value = itemsList.value;
    });
  }

  getSearchItemDetails() async {
    await ItemNetwork.getSearchItemsByOutletId(
            id: Get.find<DineInDetailsController>().restaurantId)
        .then((value) {
      searchList.value = value!;
    });
  }


  navigateToOrderDetails(){
    Get.toNamed(AppRoutes.dineInBookingDetailScreen,arguments: {keyModel:orderDataSendModel,keyList:selectedItems.value});

  }
}
