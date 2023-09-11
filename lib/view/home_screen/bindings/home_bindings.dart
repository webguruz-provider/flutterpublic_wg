import 'package:foodguru/app_values/export.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CategoriesController>(() => CategoriesController());
    Get.lazyPut<ItemListController>(() => ItemListController());
    Get.lazyPut<SearchViewController>(() => SearchViewController());
    Get.lazyPut<SearchedRestaurantListController>(() => SearchedRestaurantListController());
    Get.lazyPut<SearchedItemListController>(() => SearchedItemListController());
    Get.lazyPut<ItemDetailsController>(() => ItemDetailsController());
    Get.lazyPut<RestaurantDetailsController>(() => RestaurantDetailsController());
    Get.lazyPut<NotificationsController>(() => NotificationsController());
    Get.lazyPut<SpecialOffersController>(() => SpecialOffersController());
  }
}
