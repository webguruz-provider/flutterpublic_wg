import 'package:foodguru/app_values/export.dart';

class SpecialOffersScreen extends GetView<SpecialOffersController> {
  const SpecialOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorConstant.gray50,
        appBar: CustomAppBar(
            title: controller.isBirthday.value == true
                ? TextFile.birthdaySpecial.tr
                : TextFile.specialOffers.tr),
        body: ListView.separated(
                padding: EdgeInsets.all(margin_15),
                itemBuilder: (context, index) {
                  return GetInkwell(
                    onTap: () {
                      Get.toNamed(AppRoutes.searchedRestaurantListScreen,arguments: {keyId:controller.specialOfferList[index].id});
                    },
                    child: AssetImageWidget(
                      controller.specialOfferList[index].imageUrl,
                      height: height_150,
                      boxFit: BoxFit.cover,
                      radiusAll: radius_10,
                      width: Get.width,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: height_10,
                  );
                },
                itemCount: controller.specialOfferList.length)
            .marginOnly(bottom: margin_10),
      ),
    );
  }
}
