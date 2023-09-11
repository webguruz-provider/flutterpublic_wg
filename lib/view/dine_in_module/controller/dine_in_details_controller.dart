import 'package:foodguru/app_values/export.dart';

class DineInDetailsController extends GetxController {
  Rx<RestaurantItemDataModel> restaurantDataModel =
      RestaurantItemDataModel().obs;
  int? restaurantId;
  int? index;
  RxInt pageIndex = 0.obs;
  Rx<PopupMenuModel> selectedValue = PopupMenuModel(
          id: 1, title: 'Veg/Non-Veg', image: ImageConstant.imagesIcVegNonveg)
      .obs;
  RxList<PopupMenuModel> popupList = <PopupMenuModel>[
    PopupMenuModel(
        id: 1, title: 'Veg/Non-Veg', image: ImageConstant.imagesIcVegNonveg),
    PopupMenuModel(id: 2, title: 'Veg', image: ImageConstant.imagesIcVeg),
    PopupMenuModel(
        id: 3, title: 'Non-Veg', image: ImageConstant.imagesIcNonVeg),
  ].obs;
  List<ItemModel> tempItemsList = <ItemModel>[];

  RxList<ItemModel> itemsList = <ItemModel>[].obs;

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

  @override
  void onInit() {
    getArguments();
    getRestaurantDetails();
    getItemDetails();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      restaurantId = Get.arguments[keyId];
      index = Get.arguments[keyIndex];
    }
  }

  getRestaurantDetails() async {
    await OutletNetwork.getRestaurantById(id: restaurantId).then((value) {
      restaurantDataModel.value = value!;
    });
  }

  getItemDetails() async {
    await ItemNetwork.getItemsByOutletId(id: restaurantId).then((value) {
      itemsList.value = value!;
      tempItemsList = itemsList.value;

    });
  }
}
