import 'package:foodguru/app_values/export.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(ImageConstant.iconsIcSplashBg),fit: BoxFit.cover),
          ),
          child: Center(child: AssetImageWidget(ImageConstant.iconsIcSplashLogo,height: height_120,)),
        ),
      );
    },);
  }
}
