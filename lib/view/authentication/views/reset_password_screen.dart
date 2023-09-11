import 'package:foodguru/app_values/export.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(
          title: controller.fromProfileView == true
              ? TextFile.changePassword.tr
              : TextFile.resetPassword.tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _enterYourOtpText(),
          _form(),
          _submitButton(),
          Spacer(),
          _privacyPoilcyAndTermsAndCondition(),
        ],
      ).marginAll(margin_15),
    );
  }

  _enterYourOtpText() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(TextFile.enterYourNewPassword.tr,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: AppStyle.txtInterRegular14Gray600)
          .marginOnly(right: margin_15),
    );
  }

  _submitButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.submit.tr,
        margin: getMargin(top: margin_30),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          if (controller.formKey.currentState!.validate()) {
            controller.resetChangePasswordFunction();
          }
        });
  }

  _passwordTextField() {
    return Obx(
      () => CommonTextFieldWidget(
        hintText: TextFile.password.tr,
        iconPath: ImageConstant.imalockGreen,
        focusNode: controller.passwordNode,
        onFieldSubmitted: (value) {
          controller.confirmPasswordNode.requestFocus();
        },
        textInputAction: TextInputAction.next,
        inputController: controller.passwordController,
        validator: (value) {
          return Validation().validatePassword(value!);
        },
        width: widthSizetextField,
        suffix: GetInkwell(
          onTap: () {
            controller.isVisiblePassword.value =
                !controller.isVisiblePassword.value;
          },
          child: Icon(
            controller.isVisiblePassword.value
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.grey.shade400,
            size: getSize(20),
          ).marginOnly(right: getSize(10)),
        ),
        obsecure: !controller.isVisiblePassword.value,
      ).marginOnly(top: margin_15),
    );
  }

  _confirmPasswordTextField() {
    return Obx(
      () => CommonTextFieldWidget(
        hintText: TextFile.confirmPassword.tr,
        iconPath: ImageConstant.imalockGreen,
        focusNode: controller.confirmPasswordNode,
        inputController: controller.confirmPasswordController,
        textInputAction: TextInputAction.done,
        width: widthSizetextField,
        validator: (value) {
          return Validation().validateConfirmPassword(
              value: value,
              password: controller.passwordController.text.trim());
        },
        suffix: GetInkwell(
          onTap: () {
            controller.isVisibleConfirmPassword.value =
                !controller.isVisibleConfirmPassword.value;
            debugPrint(controller.isVisibleConfirmPassword.value.toString());
          },
          child: Icon(
            controller.isVisibleConfirmPassword.value
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.grey.shade400,
            size: getSize(20),
          ).marginOnly(right: getSize(10)),
        ),
        obsecure: !controller.isVisibleConfirmPassword.value,
      ).marginOnly(top: margin_8),
    );
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

  _form() {
    return Form(
        key: controller.formKey,
        child: Column(
          children: [
            _passwordTextField(),
            _confirmPasswordTextField(),
          ],
        ));
  }
}
