import 'package:foodguru/app_values/export.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(title: TextFile.forgotPassword.tr),
      body: Column(
        children: [
          _enterYourEmailPhoneText(),
          _emailPhoneNumberTextField(),
          _forgotPasswordButton(),
          Spacer(),
          _privacyPoilcyAndTermsAndCondition(),
        ],
      ).marginAll(margin_15),
    );
  }

  _enterYourEmailPhoneText() {
    return Text(TextFile.enterEmailPhoneNoToGetOtp.tr,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.left,
            style: AppStyle.txtInterRegular14Gray600)
        .marginOnly(right: margin_15);
  }

  _emailPhoneNumberTextField() {
    return CommonTextFieldWidget(
      hintText: TextFile.emailMobileText.tr,
      inputController: controller.emailPhoneController,
      width: widthSizetextField,
      validator: (value) {
        if (value!.isEmail || value.isPhoneNumber) {
        } else {
          return TextFile.emailPhoneValidation.tr;
        }
      },
      keyBoardInputType: TextInputType.emailAddress,
    ).marginOnly(top: margin_10);
  }

  _forgotPasswordButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.getOtp.tr,
        margin: getMargin(top: margin_20),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          controller.forgotPassword();
          // Get.toNamed(AppRoutes.otpVerificationScreen);
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
