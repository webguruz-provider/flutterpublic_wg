import 'package:foodguru/app_values/export.dart';

class OrderSuccessController extends GetxController {
  bool fromDineInView = false;
  Rxn<UserDbModel> userDbModel = Rxn<UserDbModel>();

  @override
  void onInit() {
    if (Get.arguments != null) {
      fromDineInView = Get.arguments[fromDineInKey];
    }
    getRegisterData();
    super.onInit();
  }

  getRegisterData() async {
    userDbModel.value = await PreferenceManger().getSavedLoginData();
  }
}
