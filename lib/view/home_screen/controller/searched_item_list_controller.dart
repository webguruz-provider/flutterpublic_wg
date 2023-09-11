import 'package:foodguru/app_values/export.dart';

class SearchedItemListController extends GetxController {
  TextEditingController? searchController;
  FocusNode? searchNode;
  RxString searchedValue=''.obs;
  Timer? debounce;
  RxList<ItemModel> itemsList = <ItemModel>[].obs;
  RxList<ItemModel> searchList = <ItemModel>[].obs;
  RxList<ItemModel> tempRestaurantList = <ItemModel>[].obs;

  @override
  void onInit()async {
    _initializeTextFieldsAndNodes();
    await  getItemDetails();
    await fetchSearchRestaurantList();
    searchController?.addListener(() {
      searchFunction(searchController?.text ?? '');
    });
    getArguments();


    super.onInit();
  }
  _initializeTextFieldsAndNodes(){
    searchController = TextEditingController();
    searchNode = FocusNode();
  }
  getArguments(){
    if(Get.arguments!=null){
      searchController?.text=Get.arguments[keyName];
      searchedValue.value=Get.arguments[keyName];
    }
  }
  getItemDetails() async {
    await ItemNetwork.getAllItemsList().then((value) {
      itemsList.value=value!;
      tempRestaurantList.value = itemsList.value;
    });
  }

  fetchSearchRestaurantList() async {
    await ItemNetwork.getSearchAllItemsList().then((value) {
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

}
