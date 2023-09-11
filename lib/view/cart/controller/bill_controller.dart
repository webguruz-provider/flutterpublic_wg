import 'package:foodguru/app_values/export.dart';

import '../../../network/payment_module/payment_network.dart';

class BillController extends GetxController {
  RxDouble itemTotal = 0.0.obs;
  RxDouble points = 0.0.obs;
  RxInt pointValue = 0.obs;
  RxDouble gst = 0.0.obs;
  RxDouble discount = 0.0.obs;
  RxDouble deliveryCharges = 0.0.obs;
  RxDouble grandTotal = 0.0.obs;
  TextEditingController? cookingInstructionController;
  FocusNode? cookingInstructionNode;
  RxnString cookingInstructions = RxnString();
  RxList<ItemModel> itemsList = <ItemModel>[].obs;
  Rxn<CouponModel> couponModel = Rxn<CouponModel>();
  Rxn<AddressModel> addressModel = Rxn<AddressModel>();
  RxnInt orderType=RxnInt();

  RxBool isChecked= false.obs;
  @override
  void onInit() {
    initializeControllersAndNodes();
    getArguments();
    findingTotal();
    localDbGetPoints();
    super.onInit();
  }

  initializeControllersAndNodes() {
    cookingInstructionController = TextEditingController();
    cookingInstructionNode = FocusNode();
  }

  getArguments() {
    if (Get.arguments != null) {
      itemsList.value = Get.arguments[keyModel];
      orderType.value=Get.arguments[keyOrderType];
    }
  }

  findingTotal() {
    itemTotal.value = itemsList.fold(
        0, (previousValue, element) =>
            previousValue + int.parse(element.discountedPrice ?? '1') *
                element.quantity!.value);

    points.value = itemsList.fold(
        0,
        (previousValue, element) =>
            previousValue +
            int.parse(element.pointsPerQuantity ?? '1') *
                element.quantity!.value);

    debugPrint('asdsadasd '+points.value.toString());
    gst.value = (itemTotal.value * 18) / 100;
    if (couponModel.value != null) {
      if (itemTotal.value <
          int.parse(couponModel.value!.minimumOrder.toString())) {
        couponModel.value = null;
        discount.value = 0;
        showToast(TextFile.selectedCouponRemoved.tr);
      } else {
        if (couponModel.value?.couponId == 4) {
          // discount.value=deliveryCharges.value;
          // discount.value=deliveryCharges.value;
          deliveryCharges.value = 0;
        } else {
          discount.value = (itemTotal.value *
                  int.parse(couponModel.value!.value.toString())) /
              100;
          if (discount.value >
              int.parse(couponModel.value!.maximumDiscount.toString())) {
            discount.value = double.parse(
                couponModel.value?.maximumDiscount.toString() ?? '0');
          }
        }
      }
    } else {
      discount.value = 0;
    }
    if(orderType.value==keyOrderTypeTakeaway){
      deliveryCharges.value=0;
    }else{
      if (couponModel.value?.id == 4) {
        deliveryCharges.value = 0;
      } else {
        deliveryCharges.value = 30;
      }
    }



    grandTotal.value =
        itemTotal.value + gst.value - discount.value + deliveryCharges.value;
    debugPrint(grandTotal.toString());
  }

  getCartList() async {
    await ItemNetwork.getCartItemsList().then((value) {
      itemsList.value = value ?? [];
      update();
    });
  }

  navigateToPaymentScreen() async {
    if (addressModel.value != null) {
      UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
      OrderDataSendModel orderDataSendModel = OrderDataSendModel(
        orderType: orderType.value,
        stateId: keyOrderPlaced,
        addressId: addressModel.value?.id,
        outletId: itemsList.first.outletId,
        cookingInstructions: cookingInstructions.value,
        userId: userDbModel.id,
        couponId: couponModel.value?.id,
        deliveryCharges: deliveryCharges.value,
        discount: discount.value,
        grandTotal: grandTotal.value,
        gst: gst.value,
        itemTotal: itemTotal.value,
      );
      debugPrint(jsonEncode(orderDataSendModel));
      Get.toNamed(AppRoutes.paymentScreen,
          arguments: { keyModel: orderDataSendModel, keyList: itemsList,point: points.value,pointUse: isChecked.value});
    } else {
      showToast(TextFile.pleaseSelectAddress.tr);
    }
  }

  localDbGetPoints() async {
    await PaymentNetwork.getPointsByUserId(
      onSuccess: (value) async {
        pointValue.value= value.points ?? 0;

      },
    );
  }
}
