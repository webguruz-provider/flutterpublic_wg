import 'package:foodguru/app_values/export.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<OrderHistoryController>(() => OrderHistoryController());
    Get.lazyPut<OrderDetailsController>(() => OrderDetailsController());
    Get.lazyPut<CancelOrderController>(() => CancelOrderController());
    Get.lazyPut<WalletController>(() => WalletController());
    Get.lazyPut<PointsController>(() => PointsController());
    Get.lazyPut<ChangeLanguageController>(() => ChangeLanguageController());
    Get.lazyPut<FaqController>(() => FaqController());
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<FeedbackController>(() => FeedbackController());
    Get.lazyPut<AboutUsController>(() => AboutUsController());
    Get.lazyPut<StaticPagesController>(() => StaticPagesController());
    Get.lazyPut<ContactUsController>(() => ContactUsController());
  }

}