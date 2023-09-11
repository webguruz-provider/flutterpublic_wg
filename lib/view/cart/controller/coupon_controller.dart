import 'package:foodguru/app_values/export.dart';

class CouponController extends GetxController {
  RxnDouble itemTotal = RxnDouble();
  List<int> couponId = [];
  RxList<CouponModel> couponList = <CouponModel>[].obs;

  @override
  void onInit() {
    getArguments();
    getAllCoupons();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      itemTotal.value = Get.arguments[keyItemTotal];
      if (Get.arguments[keyIdList] != null) {
        couponId = Get.arguments[keyIdList];
        debugPrint(couponId.toString());
      }
    }
  }

  getAllCoupons() async {
    await CouponNetwork.getCouponsById(couponId).then((value) {
      couponList.value = value;
    });
  }
}
