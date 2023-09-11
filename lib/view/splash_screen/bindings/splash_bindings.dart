import 'package:foodguru/app_values/export.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreferenceManger>(() => PreferenceManger());
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
