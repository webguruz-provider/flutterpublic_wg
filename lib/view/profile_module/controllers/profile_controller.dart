import 'dart:io';

import 'package:foodguru/app_values/export.dart';
import 'package:foodguru/network/payment_module/payment_network.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  CustomLoader customLoader = CustomLoader();
  RxBool notificationToggle = false.obs;
  Rxn<UserDbModel> userDbModel = Rxn<UserDbModel>();
  Rxn<File> imageFile = Rxn<File>();
  RxList<String> generalSettingsList = <String>[].obs;
  RxList<String> moreSettingsList = <String>[].obs;
  RxnInt points = RxnInt();

  logoutFunctionLocalDB() async {
    await PreferenceManger().clearLoginData();
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  logoutFunction() {
    customLoader.show(Get.overlayContext);
    auth.signOut().then((value) {
      customLoader.hide();
      Get.offAllNamed(AppRoutes.signupScreen);
    }).onError((error, stackTrace) {
      customLoader.hide();
      showToast(error.toString());
    });
  }

  @override
  void onInit() {
    initializeLists();
    getSavedLoginData();
    localDbGetPoints();
    super.onInit();
  }

  getSavedLoginData() async {
    userDbModel.value=await PreferenceManger().getSavedLoginData();
    if(userDbModel.value?.imageUrl  != null &&  userDbModel.value?.imageUrl  != "" )imageFile.value = File(userDbModel.value?.imageUrl ?? "");
  }


  initializeLists() {
    generalSettingsList.value = <String>[
      TextFile.deliveryAddress.tr,
      TextFile.changePassword.tr,
      TextFile.paymentMethod.tr,
      TextFile.orderHistory.tr,
      TextFile.wallet.tr,
      TextFile.changeLanguage.tr,
      TextFile.points.tr,
      TextFile.notification.tr,
    ];
    moreSettingsList.value = <String>[
      TextFile.feedback.tr,
      TextFile.contactUs.tr,
      TextFile.aboutUs.tr,
      TextFile.faq.tr,
    ];
  }

  localDbGetPoints() async {
    await PaymentNetwork.getPointsByUserId(
      onSuccess: (value) async {
       points.value= value.points ?? 0;

      },
    );
  }
}
