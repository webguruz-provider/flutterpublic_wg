import 'package:foodguru/app_values/export.dart';

class OtpVerificationController extends GetxController {
  final Uri toLaunch = Uri(scheme: 'https', host: 'www.Google.com');
  RxInt timeInSec = 30.obs;
  Timer? time;

  UserDbModel? userDbModel;

  @override
  void onInit() {
    getArguments();
    timerFunction();
    super.onInit();
  }

  timerFunction() {
    time = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeInSec > 0) {
        timeInSec.value = timeInSec.value - 1;
        debugPrint('${timeInSec.value}');
      }
    });
  }

  getArguments() {
    if (Get.arguments != null) {
      userDbModel = Get.arguments[keyModel];
    }
  }

  @override
  void onClose() {
    time?.cancel();
    super.onClose();
  }

  @override
  void dispose() {
    time?.cancel();
    super.dispose();
  }
}
