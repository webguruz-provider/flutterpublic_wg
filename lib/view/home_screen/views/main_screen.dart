import 'package:foodguru/app_values/export.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor:
              controller.selectedIndex == 1 ? Colors.black : Colors.white,
          body: controller.screens[controller.selectedIndex],
          bottomNavigationBar: LayoutBuilder(builder: (context, constraints) {
            return SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.greenA700.withOpacity(0.5),
                      spreadRadius: 0.3,
                      blurRadius: 2.0,
                      offset: Offset(0, -2),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius_10),
                    topRight: Radius.circular(radius_10),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius_10),
                    topRight: Radius.circular(radius_10),
                  ),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: controller.selectedIndex == 1
                        ? Colors.black
                        : Colors.white,
                    currentIndex: controller.selectedIndex,
                    selectedLabelStyle: AppStyle.txtDMSansRegular12GreenA700,
                    unselectedLabelStyle: AppStyle.txtDMSansRegular12Gray700,
                    unselectedItemColor: ColorConstant.gray700,
                    selectedItemColor: ColorConstant.greenA700,
                    selectedFontSize: font_12,
                    unselectedFontSize: font_12,
                    onTap: (value) {
                      controller.selectedIndex = value;
                      if (controller.selectedIndex == 0) {
                        var homeController = Get.find<HomeController>();
                        homeController.refreshAllLists();
                        homeController.update();
                      }
                      controller.update();
                    },
                    items: controller.bottomNavList,
                  ),
                ),
              ),
            );
          },)
        );
      },
    );
  }
}
