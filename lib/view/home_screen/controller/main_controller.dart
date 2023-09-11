import 'package:foodguru/app_values/export.dart';
import 'package:foodguru/view/cart/views/cart_screen.dart';

class MainController extends GetxController {
  int selectedIndex = 0;

  bottomNavImage({image}) {
    return AssetImageWidget(image, width: 26,height: 26,)
        .marginSymmetric(vertical: margin_5);
  }

  List<Widget> screens = [
    HomeScreen(),
    DineInListScreen(),
    SavedScreen(),
    CartScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavList = [];

  @override
  void onInit() {
    bottomNavListGenerate();
    Get.put<HomeController>(HomeController());
    super.onInit();
  }

  bottomNavListGenerate() {
    bottomNavList = [
      BottomNavigationBarItem(
        icon: bottomNavImage(image: ImageConstant.imagesIcHomeUnselected),
        activeIcon: bottomNavImage(image: ImageConstant.imagesIcHomeSelected),
        label: TextFile.home.tr,
      ),
      BottomNavigationBarItem(
        icon: bottomNavImage(image: ImageConstant.imagesIcDineInUnselected),
        activeIcon: bottomNavImage(image: ImageConstant.imagesIcDineInSelected),
        label: TextFile.dineIn.tr,
      ),
      BottomNavigationBarItem(
        icon: bottomNavImage(image: ImageConstant.imagesIcSavedUnselected),
        activeIcon: bottomNavImage(image: ImageConstant.imagesIcSavedSelected),
        label: TextFile.saved.tr,
      ),
      BottomNavigationBarItem(
        icon: bottomNavImage(image: ImageConstant.imagesIcCartUnselected),
        activeIcon: bottomNavImage(image: ImageConstant.imagesIcCartSelected),
        label: TextFile.bag.tr,
      ),
    ];
    update();
  }
}
