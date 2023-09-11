import 'package:foodguru/app_values/export.dart';

class OnBoardingViewScreen extends GetView<OnBoardingController> {
  const OnBoardingViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
      init: OnBoardingController(),
      builder: (controller) {
        return Scaffold(
          body: CupertinoOnboarding(
            onPressedSkipButton: () {
              PreferenceManger().firstLaunch(true);
              Get.offAllNamed(AppRoutes.loginScreen);
            },
            onPressedOnLastPage: () {
              PreferenceManger().firstLaunch(true);
              Get.offAllNamed(AppRoutes.loginScreen);
            },
            pages: List.generate(controller.onBoardingList.length, (index) {
              return OnboardingView(
                onboardingSubtitle: controller.isLocal
                    ? controller.onBoardingList[index]["subtitle"].toString()
                    : controller.onBoardingLists.data!.items![index].subtitle
                        .toString(),
                onboardingsvgImageurl: controller.isLocal
                    ? controller.onBoardingList[index]["images"].toString()
                    : controller.onBoardingLists.data!.items![index].images
                        .toString(),
                onboardingtitle: controller.isLocal
                    ? controller.onBoardingList[index]["title"].toString()
                    : controller.onBoardingLists.data!.items![index].toString(),
              );
            }),
          ),
        );
      },
    );
  }
}
