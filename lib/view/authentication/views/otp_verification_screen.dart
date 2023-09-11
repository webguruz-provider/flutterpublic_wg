import 'package:foodguru/app_values/export.dart';

class OtpVerificationScreen extends GetView<OtpVerificationController> {
  OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(title: TextFile.enterOtp.tr),
      body: Obx(
        () => Column(
          children: [
            _enterYourOtpText(),
            _otpTextField(),
            RichText(
              text: TextSpan(
                  text: TextFile.resendOtp.tr,
                  style: AppStyle.txtInterRegular14GreenA700.copyWith(
                      fontWeight: FontWeight.w400,
                      color: controller.timeInSec.value != 0
                          ? ColorConstant.gray600
                          : ColorConstant.greenA700),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if (controller.timeInSec.value == 0) {
                        controller.time?.cancel();
                        controller.timeInSec.value = 30;
                        controller.timerFunction();
                      }
                    },
                  children: [
                    TextSpan(
                        text: controller.timeInSec.value == 0
                            ? ''
                            : ' - ${controller.timeInSec.toString().padLeft(2, '0')} ${TextFile.sec.tr}',
                        style: AppStyle.txtInterRegular14Gray600)
                  ]),
            ).marginOnly(top: margin_20),
            _verifyOtpButton(),
            Spacer(),
            _privacyPoilcyAndTermsAndCondition(),
          ],
        ).marginAll(margin_15),
      ),
    );
  }

  _enterYourOtpText() {
    return Text(TextFile.enterYour6DigitOtp.tr,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.left,
            style: AppStyle.txtInterRegular14Gray600)
        .marginOnly(right: margin_15);
  }

  _otpTextField() {
    return Pinput(
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme,
      followingPinTheme: defaultPinTheme,
      disabledPinTheme: defaultPinTheme,
      errorPinTheme: defaultPinTheme,
      submittedPinTheme: defaultPinTheme,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    ).marginOnly(top: margin_20);
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: font_16, color: Colors.black, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: ColorConstant.greenA700),
      borderRadius: BorderRadius.circular(radius_50),
    ),
  );

  _verifyOtpButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.verifyOtp.tr,
        margin: getMargin(top: margin_15),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          controller.time?.cancel();
          Get.toNamed(AppRoutes.resetPasswordScreen,
              arguments: {keyModel: controller.userDbModel});

          debugPrint(controller.userDbModel?.email);
        });
  }

  _privacyPoilcyAndTermsAndCondition() {
    return Text.rich(TextSpan(
        text: '',
        style: AppStyle.txtDMSansRegular12Gray700,
        children: <TextSpan>[
          TextSpan(
              text: TextFile.termsAndConditions.tr,
              style: AppStyle.txtInterMedium12GreenA70087
                  .copyWith(decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () =>
                    CommonUtils().launchUrlInAppView(controller.toLaunch)),
          TextSpan(
              text: ' ${TextFile.and.tr} ',
              style: AppStyle.txtDMSansRegular12Gray700,
              children: <TextSpan>[
                TextSpan(
                    text: TextFile.privacyPolicy.tr,
                    style: AppStyle.txtInterMedium12GreenA70087
                        .copyWith(decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          CommonUtils().launchUrlInAppView(controller.toLaunch)
                    // code to open / launch privacy policy link here

                    )
              ])
        ])).marginOnly(bottom: margin_10);
  }
}
