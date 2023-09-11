import 'package:foodguru/app_values/export.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController? emailPhoneController;
  final Uri toLaunch = Uri(scheme: 'https', host: 'www.Google.com');
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    initializeControllers();
    super.onInit();
  }

  initializeControllers() {
    emailPhoneController = TextEditingController();
  }

  forgotPassword() {
    forgotPasswordMethod(
      emailPhoneValue: emailPhoneController?.text.trim(),
      onSuccess: (userDbModel) {
        Get.toNamed(AppRoutes.otpVerificationScreen,
            arguments: {keyModel: userDbModel});
      },
    );
  }

  forgotPasswordFirebase() async {
    try {
      await auth.sendPasswordResetEmail(
          email: emailPhoneController?.text.trim() ?? '');
      debugPrint('send');
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(TextFile.noUserFoundWithEmail.tr);
      } else {
        showToast(TextFile.notAbleToSendEmail.tr);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
