import 'package:foodguru/app_values/export.dart';

class SpecialOffersController extends GetxController {
  RxBool isBirthday = false.obs;
  RxList<SpecialOffersModel> dummyList = <SpecialOffersModel>[].obs;
  RxList<CouponModel> specialOfferList = <CouponModel>[].obs;

  @override
  void onInit() {
    getArguments();
    getSpecialOffersList();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      isBirthday.value = Get.arguments[isBirthdaySpecial];
      if (isBirthday.value != true) {
        // specialOffersList.value = <SpecialOffersModel>[
        //   SpecialOffersModel(imgUrl: ImageConstant.imgImage27),
        //   SpecialOffersModel(imgUrl: ImageConstant.imagesIcHomeBanner),
        //   SpecialOffersModel(imgUrl: ImageConstant.imgImage27),
        //   SpecialOffersModel(imgUrl: ImageConstant.imagesIcHomeBanner),
        //   SpecialOffersModel(imgUrl: ImageConstant.imgImage27),
        //   SpecialOffersModel(imgUrl: ImageConstant.imagesIcHomeBanner),
        //   SpecialOffersModel(imgUrl: ImageConstant.imgImage27),
        //   SpecialOffersModel(imgUrl: ImageConstant.imagesIcHomeBanner),
        // ];
      } else {
        dummyList.value = <SpecialOffersModel>[
          SpecialOffersModel(imgUrl: ImageConstant.imagesIcBirthdayBanner),
          SpecialOffersModel(imgUrl: ImageConstant.imagesIcBirthdayBanner),
          SpecialOffersModel(imgUrl: ImageConstant.imagesIcBirthdayBanner),
          SpecialOffersModel(imgUrl: ImageConstant.imagesIcBirthdayBanner),
          SpecialOffersModel(imgUrl: ImageConstant.imagesIcBirthdayBanner),
          SpecialOffersModel(imgUrl: ImageConstant.imagesIcBirthdayBanner),
          SpecialOffersModel(imgUrl: ImageConstant.imagesIcBirthdayBanner),
          SpecialOffersModel(imgUrl: ImageConstant.imagesIcBirthdayBanner),
        ];
      }
    }
  }

  getSpecialOffersList() async {
    await CouponNetwork.getAllCoupons().then((value) {
      specialOfferList.value = value;
      specialOfferList.refresh();
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }
}
