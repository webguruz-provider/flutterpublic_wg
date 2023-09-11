import 'package:foodguru/app_values/export.dart';

class SplashController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  UserDbModel? userDbModel;
  @override
  void onInit() {
    _navigateScreenLocalDB();
    super.onInit();
  }

  _navigateScreen() {
    Future.delayed(Duration(seconds: 3), () {
      if (auth.currentUser != null) {
        Get.offAllNamed(AppRoutes.mainScreen);
      } else {
        Get.offAllNamed(AppRoutes.onBoardingScreen);
      }
    });
  }
  _navigateScreenLocalDB() {
    Future.delayed(const Duration(seconds: 3), () {
      if(PreferenceManger().getStatusFirstLaunch()==true){
        PreferenceManger().getSavedLoginData().then((value) {
          if(value!=null){
            userDbModel=value;
            debugPrint(jsonEncode(userDbModel));
            Get.offAllNamed(AppRoutes.mainScreen);
          }else{
            Get.offAllNamed(AppRoutes.loginScreen);
          }
        });
      }else{
        Get.offAllNamed(AppRoutes.onBoardingScreen);
      }

    });
  }

  _getRegisterData() async {
    UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
  }
}
