import 'package:foodguru/app_values/export.dart';

class OrderDetailsController extends GetxController {
  RxBool isCompleted = false.obs;
  Rxn<OrderDataModel> orderModel = Rxn<OrderDataModel>();
  RxnInt id = RxnInt();

  @override
  void onInit() {
    getArguments();
    getOrderDetails();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      isCompleted.value = Get.arguments[isOrderCompleted];
      if (Get.arguments[keyId] != null) {
        id.value = Get.arguments[keyId];
      }
    }
  }


  getOrderDetails() async {
    await OrderNetwork.getOrderById(id).then((value) async {
      orderModel.value = value;
      orderModel.value?.orderItemList = await OrderItemNetwork.getOrderItemsList(orderModel.value?.id);
      orderModel.value?.orderItemList?.forEach((element) async {
        element.images= await ItemImagesNetwork.getItemImagesById(element.itemId);
      });
    });
    orderModel.refresh();
  }
}
