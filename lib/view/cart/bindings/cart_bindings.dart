import 'package:foodguru/app_values/export.dart';

class CartBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<BillController>(() => BillController());
    Get.lazyPut<CouponController>(() => CouponController());
    Get.lazyPut<AddressListController>(() => AddressListController());
    Get.lazyPut<AddAddressController>(() => AddAddressController());
  }
}