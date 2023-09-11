import 'package:foodguru/app_values/export.dart';

class OrderHistoryController extends GetxController{
  RxList<OrderDataModel>ordersList=<OrderDataModel>[].obs;
@override
  void onInit() {
  getAllOrders();
    super.onInit();
  }

getAllOrders() async {
  await OrderNetwork.getAllOrders().then((value) async {
    ordersList.value=value??[];
    for (var element in ordersList)  {
      element.orderItemList=await OrderItemNetwork.getOrderItemsList(element.id).onError((error, stackTrace) {
        showToast(error.toString());
      });
      ordersList.refresh();
    }
  });
}

}