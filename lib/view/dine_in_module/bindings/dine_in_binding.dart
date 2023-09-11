import 'package:foodguru/app_values/export.dart';

class DineInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DineInListController>(() => DineInListController());
    Get.lazyPut<DineInDetailsController>(() => DineInDetailsController());
    Get.lazyPut<MenuViewController>(() => MenuViewController());
    Get.lazyPut<DineInBookingDetailsController>(
        () => DineInBookingDetailsController());
    Get.lazyPut<DineInSelectRestaurantController>(
        () => DineInSelectRestaurantController());
    Get.lazyPut<DineInBookTableController>(() => DineInBookTableController());
  }
}
