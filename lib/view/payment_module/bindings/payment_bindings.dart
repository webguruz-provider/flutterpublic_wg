import 'package:foodguru/app_values/export.dart';

class PaymentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(() => PaymentController());
    Get.lazyPut<AddCardController>(() => AddCardController());
    Get.lazyPut<AddMoneyController>(() => AddMoneyController());
    Get.lazyPut<OrderSuccessController>(() => OrderSuccessController());
  }
}
