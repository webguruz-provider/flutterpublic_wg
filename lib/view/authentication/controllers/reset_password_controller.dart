import 'package:foodguru/app_values/export.dart';

class ResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final Uri toLaunch = Uri(scheme: 'https', host: 'www.Google.com');
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  RxBool isVisiblePassword = false.obs;
  RxBool isVisibleConfirmPassword = false.obs;
  bool fromProfileView = false;
  UserDbModel? userDbModel;

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments[fromProfileKey] != null) {
      fromProfileView = Get.arguments[fromProfileKey];
      _getRegisterData();
    }
    if (Get.arguments[keyModel] != null) {
      userDbModel = Get.arguments[keyModel];
    }
  }

  _getRegisterData() async {
    userDbModel = await PreferenceManger().getSavedLoginData();
  }

  resetChangePasswordFunction() {
    resetChangePassword(
      userDbModel: UserDbModel(
        id: userDbModel?.id,
        email: userDbModel?.email,
        imageUrl: userDbModel?.imageUrl,
        createdOn: userDbModel?.createdOn,
        deviceType: userDbModel?.deviceType,
        firstName: userDbModel?.firstName,
        lastName: userDbModel?.lastName,
        loginType: userDbModel?.loginType,
        phone: userDbModel?.phone,
        password: passwordController.text.trim(),
      ),
      onSuccess: () {
        Get.offAllNamed(AppRoutes.loginScreen);
        if (fromProfileView == true) {
          PreferenceManger().clearLoginData();
          showToast(TextFile.passwordChangedSuccessfully.tr);
        } else {
          showToast(TextFile.passwordResetSuccessfully.tr);
        }
      },
    );
  }
}
