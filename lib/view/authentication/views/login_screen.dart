import 'package:foodguru/app_values/export.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _loginText(),
          _fillTheDetailsText(),
          // _image(),
          _form(),
          _forgetPassword(),
          _tncCheckBox(),
          _loginButton(),
          _orContinueWith(),
          _socialLoginButtons(),
          _dontHaveAnAccount(),
          _continueAsGuestButton(),
        ],
      ).marginAll(margin_15)),
    );
  }

  _loginText() {
    return Text(TextFile.loginTitle.tr,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtDMSansBold24Black900)
        .marginOnly(top: margin_40);
  }

  _fillTheDetailsText() {
    return Text(TextFile.fillTheDetails.tr,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: AppStyle.txtInterRegular12Gray600);
  }

  _image() {
    return AssetImageWidget(
      ImageConstant.iconsIcLoginImg,
      width: width_90,
    ).marginOnly(top: margin_10, bottom: margin_10);
  }

  _emailPhoneNumberTextField() {
    return CommonTextFieldWidget(
      hintText: TextFile.emailMobileText.tr,
      iconPath: ImageConstant.imgFile,
      textInputAction: TextInputAction.next,
      inputController: controller.emailController,
      validator: (value) {
        return Validation().validateEmail(value);
      },
      focusNode: controller.emailNode,
      onFieldSubmitted: (val) {
        controller.passwordNode.requestFocus();
      },
      width: widthSizetextField,
      keyBoardInputType: TextInputType.emailAddress,
    );
  }

  _passwordTextField() {
    return Obx(
      () => CommonTextFieldWidget(
        hintText: TextFile.password.tr,
        iconPath: ImageConstant.imalockGreen,
        inputController: controller.passwordController,
        focusNode: controller.passwordNode,
        textInputAction: TextInputAction.done,
        width: widthSizetextField,
        validator: (value) {
          return Validation().validatePassword(value!);
        },
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
      ).marginOnly(top: margin_8),
    );
  }

  _forgetPassword() {
    return Align(
      alignment: Alignment.topRight,
      child: GetInkwell(
        onTap: () {
          Get.toNamed(AppRoutes.forgotPasswordScreen);
        },
        child: Text('${TextFile.forgotPassword.tr}?',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtDMSansRegular12GreenA700
                    .copyWith(decoration: TextDecoration.underline))
            .marginOnly(top: margin_10),
      ),
    );
  }

  _tncCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StreamBuilder(
            stream: controller.checkBoxStream,
            builder: (context, snapshot) {
              return Checkbox(
                side: MaterialStateBorderSide.resolveWith((states) =>
                    BorderSide(width: 1.0, color: ColorConstant.gray700)),
                checkColor: ColorConstant.greenA700,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                activeColor: ColorConstant.whiteA700,
                value: snapshot.hasData ? snapshot.data : false,
                onChanged: (changedValue) {
                  controller.checkBoxController.sink.add(changedValue!);
                  controller.checkBox = changedValue;
                },
              );
            }),
        Expanded(
          child: PrivacyAndTermAndConditions(
            actionPrivacyPolicy: () {
              CommonUtils().launchUrlInAppView(controller.toLaunch);
            },
            actionTermAndConditions: () {
              CommonUtils().launchUrlInAppView(controller.toLaunch);
            },
          ),
        ),
      ],
    );
  }

  _loginButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.loginTitle.tr,
        margin: getMargin(top: margin_20),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          if (controller.formKey.currentState!.validate()) {
            if (controller.checkBox != true) {
              showToast(TextFile.pleaseAcceptTermsAndPrivacyPolicy.tr);
            } else {
              controller.localDbLogin();
            }
          }
        });
  }

  _orContinueWith() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
                height: getVerticalSize(1.00),

                margin: getMargin(top: 8, bottom: 5),
                decoration: BoxDecoration(color: ColorConstant.gray400)),
          ),
          Text(TextFile.continueWith.tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtInterRegular12Gray50001).marginSymmetric(horizontal: margin_15),
          Expanded(
            child: Container(
                height: getVerticalSize(1.00),

                margin: getMargin(top: 8, bottom: 5),
                decoration: BoxDecoration(color: ColorConstant.gray400)),
          )
        ]).marginOnly(top: margin_25, left: margin_8, right: margin_8);
  }

  _socialLoginButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: SocialMediaWidget(
          text: TextFile.facebookTitle.tr,
          image: ImageConstant.imgFacebook,
          actionSocialMedia: () {},
        ),
      ),
      SizedBox(width: getSize(15)),
      Expanded(
        child: SocialMediaWidget(
          text: TextFile.googleTitle.tr,
          image: ImageConstant.imgGoogle,
          actionSocialMedia: () {
            controller.googleLogin();
          },
        ),
      ),
      SizedBox(width: getSize(15)),
      Expanded(
        child: SocialMediaWidget(
          text: TextFile.appleTitle.tr,
          image: ImageConstant.imgFire,
          actionSocialMedia: () {},
        ),
      ),
    ]).marginOnly(top: margin_25);
  }

  _dontHaveAnAccount() {
    return RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: TextFile.dontHaveAccount.tr,
                  style: AppStyle.txtInterRegular14Gray50001),
              TextSpan(
                  text: TextFile.signUpTitle.tr,
                  style: AppStyle.txtDMSansRegular14GreenA700.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.offAllNamed(AppRoutes.signupScreen);
                    })
            ]),
            textAlign: TextAlign.left)
        .marginOnly(top: margin_15);
  }

  _continueAsGuestButton() {
    return GetInkwell(
            onTap: () {},
            child: Text(TextFile.continueasGuest.tr,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtDMSansRegular14GreenA700.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline)))
        .marginOnly(top: margin_15);
  }

  _form() {
    return Form(
        key: controller.formKey,
        child: Column(
          children: [
            _emailPhoneNumberTextField(),
            _passwordTextField(),
          ],
        )).marginOnly(top: margin_80);
  }
}
