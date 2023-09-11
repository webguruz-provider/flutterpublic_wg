import 'package:foodguru/app_values/export.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
    Get.lazyPut<SignUpControllerScreen>(() => SignUpControllerScreen());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
    Get.lazyPut<OtpVerificationController>(() => OtpVerificationController());
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
  }
}
