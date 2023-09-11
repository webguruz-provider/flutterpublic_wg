import 'package:foodguru/app_values/export.dart';

class RestaurantDetailsController extends GetxController {
  TextEditingController? searchController;
  FocusNode? searchNode;
  RxString searchedValue=''.obs;
  Rxn<RestaurantItemDataModel> restaurantDetail = Rxn<RestaurantItemDataModel>();
  RxnInt outletId = RxnInt();
  RxnInt index = RxnInt();



  Rx<PopupMenuModel> selectedValue = PopupMenuModel(id: 1, title: 'Veg/Non-Veg', image: ImageConstant.imagesIcVegNonveg).obs;
  RxList<PopupMenuModel> popupList = <PopupMenuModel>[
    PopupMenuModel(id: typeNonVeg, title: 'Veg/Non-Veg', image: ImageConstant.imagesIcVegNonveg),
    PopupMenuModel(id: typeVeg, title: 'Veg', image: ImageConstant.imagesIcVeg),
    PopupMenuModel(id: typeNonVeg, title: 'Non-Veg', image: ImageConstant.imagesIcNonVeg),
  ].obs;
  RxList<ItemModel> itemsList = <ItemModel>[].obs;
  RxList<ItemModel> searchList = <ItemModel>[].obs;
  RxList<ItemModel> tempRestaurantList = <ItemModel>[].obs;

  @override
  void onInit()async {
   _initializeTextFieldsAndNodes();
    searchController?.addListener(() {
      searchFunction(searchController?.text ?? '');
    });


    getArguments();
    getRestaurantDetails();
    getItemDetails();
    await fetchSearchRestaurantList();


    super.onInit();
  }
  _initializeTextFieldsAndNodes(){
    searchController = TextEditingController();
    searchNode = FocusNode();
  }
  fetchSearchRestaurantList() async {
    await ItemNetwork.getSearchItemsByOutletId(id: outletId).then((value) {
      searchList.value = value ?? [];
    });
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
      itemsList.value = tempRestaurantList;
    }
  }
  getArguments() {
    if (Get.arguments != null) {
      outletId.value = Get.arguments[keyId];
      index.value = Get.arguments[keyIndex];
    }
  }

  getRestaurantDetails() async {
    await OutletNetwork.getRestaurantById(id: outletId.value).then((value) {
      restaurantDetail.value = value;
    });
  }

  getItemDetails() async {
    await ItemNetwork.getItemsByOutletId(id: outletId).then((value) {
      itemsList.value = value!;
      tempRestaurantList.value = itemsList.value;
    });
  }
}

class PopupMenuModel {
  int? id;
  String? title;
  String? image;

  PopupMenuModel({this.id, this.title, this.image});
}
