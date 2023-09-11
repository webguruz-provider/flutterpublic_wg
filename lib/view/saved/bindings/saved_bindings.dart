import 'package:foodguru/app_values/export.dart';

class SavedBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SavedController>(() => SavedController());

  }

}