import 'package:foodguru/app_values/export.dart';

class OrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackOrderController>(() => TrackOrderController());
  }
}
