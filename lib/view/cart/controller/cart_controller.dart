import 'package:foodguru/app_values/export.dart';

class CartController extends GetxController {
  ScrollController scrollController = ScrollController();
  bool showButton = true;
  List<ItemModel> frequentlyItemsList = <ItemModel>[];

  @override
  void onInit() {
    scrollController.addListener(() {
      _scrollListener();
    });
    getCartList();
    super.onInit();
  }

  void _scrollListener() {
    if (scrollController.position.isScrollingNotifier.value) {
      showButton = true;
      update();
    } else {
      showButton = false;
      update();
    }
    debugPrint(showButton.toString());
  }

  List<ItemModel> itemsList = [];

  @override
  void dispose() {
    scrollController.removeListener(() {
      _scrollListener;
    });
    scrollController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    scrollController.removeListener(() {
      _scrollListener;
    });
    scrollController.dispose();
    super.onClose();
  }

  getCartList() async {
    await ItemNetwork.getCartItemsList().then((value) {
      itemsList = value ?? [];
      update();
      if(itemsList.isNotEmpty){
        fetchFrequentlyBoughtTogetherList();
      }
    });
  }

  fetchFrequentlyBoughtTogetherList() async {
    await ItemNetwork.getFrequentlyBoughtTogetherListCart(itemsList.first.outletId)
        .then((value) async {
      frequentlyItemsList = value ?? [];
      for (var element in frequentlyItemsList)  {
        element.images=await ItemImagesNetwork.getItemImagesById(element.itemId);
      }
      update();
    });
  }
}
