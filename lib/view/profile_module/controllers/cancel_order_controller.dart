import 'package:foodguru/app_values/export.dart';

class CancelOrderController extends GetxController {
  RxInt selectedReasonId = 0.obs;
  RxList<CancelReasonModel> cancelReasonList = <CancelReasonModel>[].obs;
  Rxn<OrderDataModel> orderModel = Rxn<OrderDataModel>();
  RxnInt id = RxnInt();

  RxList<String> cancelReasonList1 = <String>[
    'Waiting for long time.',
    'Unable to connect driver.',
    'Driver denied to go to destination.',
    'Driver denied to come to pick up.',
    'Wrong Address shown.',
    'The price is not reasonable.',
    'I want to order from another restaurant.',
    'Changed my mind.',
    'Other.',
  ].obs;

  @override
  void onInit() {
    getCancelReason();
    getArguments();
    getOrderDetails();
    super.onInit();
  }

  getCancelReason() async {
    await CancelReasonNetwork.getAllReasonsList().then((value) {
      cancelReasonList.value = value ?? [];
    });
  }

  cancelOrder() async {
    OrderDataSendModel orderDataSendModel = OrderDataSendModel(
      addressId: orderModel.value?.addressId,
      outletId: orderModel.value?.outletId,
      cookingInstructions: orderModel.value?.cookingInstructions,
      userId: orderModel.value?.userId,
      couponId: orderModel.value?.couponId,
      deliveryCharges: orderModel.value?.deliveryCharges,
      discount: orderModel.value?.discount,
      stateId: keyOrderCancel,
      grandTotal: orderModel.value?.grandTotal,
      gst: orderModel.value?.gst,
      paymentId: orderModel.value?.paymentId,
      cancelReasonId: selectedReasonId.value,
      itemTotal: orderModel.value?.itemTotal,
    );
    await OrderNetwork.changeStateOfOrder(
      data: orderDataSendModel.toJson(),
      id: orderModel.value?.id,
      onSuccess: () {
        Get.dialog(
          const CancelOrderDialog(),barrierDismissible: false,
          transitionCurve: Curves.bounceIn,
        );
      },
    );
  }

  getArguments() {
    if (Get.arguments != null) {
      if (Get.arguments[keyId] != null) {
        id.value = Get.arguments[keyId];
      }
    }
  }

  getOrderDetails() async {
    await OrderNetwork.getOrderById(id).then((value) async {
      orderModel.value = value;
      orderModel.value?.orderItemList =
          await OrderItemNetwork.getOrderItemsList(orderModel.value?.id);
      orderModel.value?.orderItemList?.forEach((element) async {
        element.images =
            await ItemImagesNetwork.getItemImagesById(element.itemId);
      });
    });
    orderModel.refresh();
  }
}
