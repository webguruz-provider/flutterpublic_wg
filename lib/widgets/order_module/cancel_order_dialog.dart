import 'package:foodguru/app_values/export.dart';

class CancelOrderDialog extends GetView<CancelOrderController> {
  const CancelOrderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width,
        margin: EdgeInsets.all(margin_60),
        padding: EdgeInsets.all(margin_15),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ColorConstant.greenA700, width: width_1),
            borderRadius: BorderRadius.circular(radius_10)),
        child: Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _sadImage(),
              _weAreSoSadText(),
              _weWillContinueText(),
              _okButton(),
            ],
          ).marginSymmetric(horizontal: margin_20),
        ),
      ),
    );
  }

  _sadImage() {
    return AssetImageWidget(
      ImageConstant.imagesIcCancelDialog,
      width: width_100,
      height: width_100,
    );
  }

  _weAreSoSadText() {
    return Text(
      TextFile.weAreSoSadAboutYourConsultation.tr,
      textAlign: TextAlign.center,
      style: AppStyle.txtDMSansBold14.copyWith(color: ColorConstant.greenA700),
    ).marginOnly(top: margin_10);
  }

  _weWillContinueText() {
    return Text(
      TextFile.weWillContinueToImproveOurService.tr,
      textAlign: TextAlign.center,
      style: AppStyle.txtDMSansRegular12Gray60001,
    ).marginOnly(top: margin_10);
  }

  _okButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.ok.tr,
        margin: getMargin(top: margin_20, left: margin_10, right: margin_10),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          Get.offAllNamed(AppRoutes.mainScreen);
        });
  }
}
