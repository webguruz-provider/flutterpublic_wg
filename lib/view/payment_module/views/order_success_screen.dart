
import 'package:flutter_animate/flutter_animate.dart';
import 'package:foodguru/app_values/export.dart';

class OrderSuccessScreen extends GetView<OrderSuccessController> {
  const OrderSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstant.iconsIcSplashBg),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AssetImageWidget(
                      ImageConstant.imagesIcOrderSuccessful,
                      width: width_120,
                    )
                        .animate()
                        .scale(duration: const Duration(milliseconds: 500)),
                    Text(
                      '${TextFile.congrats.tr} ${controller.userDbModel.value?.firstName}',
                      textAlign: TextAlign.center,
                      style: AppStyle.txtDMSansBold24GreenA700,
                    )
                        .marginOnly(top: margin_35)
                        .animate()
                        .slideX(duration: const Duration(milliseconds: 500)),
                    Text(
                      controller.fromDineInView == true
                          ? TextFile.yourBookingIsConfirmed.tr
                          : TextFile.yourOrderIsConfirmed.tr,
                      textAlign: TextAlign.center,
                      style: AppStyle.txtDMSansRegular18Black90003,
                    ).marginOnly(top: margin_25)
                  ],
                ),
              ),
              controller.fromDineInView == true
                  ? Container()
                  : GetInkwell(
                      onTap: () {
                        Get.offAllNamed(AppRoutes.trackOrderScreen,
                            arguments: {fromOrderFlowKey: true});
                      },
                      child: Text(
                        TextFile.trackYourOrder.tr,
                        textAlign: TextAlign.center,
                        style: AppStyle.txtDMSansRegular18GreenA700,
                      ),
                    ),
              CustomButton(
                  height: 45,
                  width: getSize(width),
                  shape: ButtonShape.RoundedBorder22,
                  text: controller.fromDineInView == true
                      ? TextFile.continueBooking.tr
                      : TextFile.continueOrdering.tr,
                  margin: getMargin(top: margin_20),
                  variant: ButtonVariant.OutlineBlack9003f,
                  fontStyle: ButtonFontStyle.InterSemiBold18,
                  onTap: () {
                    Get.offAllNamed(AppRoutes.mainScreen);
                  }).marginOnly(bottom: margin_100),
            ],
          ).marginAll(margin_15),
        ),
      ),
    );
  }
}
