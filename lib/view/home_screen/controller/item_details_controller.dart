import 'package:foodguru/app_values/export.dart';

class ItemDetailsController extends GetxController {
  RxInt carouselIndex = 0.obs;
  RxBool shouldAnimate = false.obs;
  Rxn<ItemModel> itemModel = Rxn<ItemModel>();
  RxList<ItemModel> frequentlyItemsList = <ItemModel>[].obs;
  int? id;

  @override
  void onInit() {
    getArguments();
    getItemDetails();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      if (Get.arguments[keyId] != null) {
        id=Get.arguments[keyId];
      }
    }
  }

  getItemDetails() async {
    await ItemNetwork.getItemById(id: id).then((value) {
      itemModel.value = value;
      debugPrint(itemModel.value?.averageRating.toString());
      debugPrint(itemModel.value?.itemName);
      fetchFrequentlyBoughtTogetherList();
    });
  }
  fetchFrequentlyBoughtTogetherList() async {
    await ItemNetwork.getFrequentlyBoughtTogetherList(itemModel.value?.outletId).then((value) async {
      frequentlyItemsList.value=value??[];
      frequentlyItemsList.value.removeWhere((element) => itemModel.value?.itemId==element.itemId);
      for (var element in frequentlyItemsList)  {
        element.images=await ItemImagesNetwork.getItemImagesById(element.itemId);
      }
      frequentlyItemsList.refresh();
    });
  }
}
