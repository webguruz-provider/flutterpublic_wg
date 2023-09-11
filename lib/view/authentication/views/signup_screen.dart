import 'package:foodguru/app_values/export.dart';

class SignUpScreen extends GetView<SignUpControllerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.gray50,
        body: Obx(
          () => SingleChildScrollView(
            child: Form(
                key: controller.formKey,
                child: Container(
                    width: size.width,
                    padding: getPadding(
                        left: 15, top: margin_25, right: 15, bottom: 28),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _signUpText(),
                          _fillTheDetailsText(),
                          _profileViewWidget(context),
                          _firstAndLastNameTextFields(),
                          _emailTextField(),
                          _phoneNumberTextField(),
                          _passwordTextField(),
                          _confirmPasswordTextField(),
                          _tncCheckBox(),
                          _signUpButton(),
                          _orContinueWith(),
                          _socialMediaButtons(),
                          _alreadyHaveAnAccount(),
                          _continueAsGuest(),
                        ]))),
          ),
        ));
  }

  _signUpText() {
    return Padding(
        padding: getPadding(top: margin_25),
        child: Text(TextFile.signUpTitle.tr,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtDMSansBold24Black900));
  }

  _fillTheDetailsText() {
    return Padding(
        padding: getPadding(top: 1, bottom: 10),
        child: Text(TextFile.fillTheDetails.tr,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtInterRegular12Gray600));
  }

  _profileViewWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleImageWidget(
        image: controller.imageFile.value,
        cameraClick: () => showImageSourceActionSheet(
          context,
        ),
      ),
    );
  }

  _firstAndLastNameTextFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First name
        Expanded(
          child: CommonTextFieldWidget(
            hintText: TextFile.firstName.tr,
            iconPath: ImageConstant.imgFile,
            focusNode: controller.firstNameNode,
            onFieldSubmitted: (value) {
              controller.lastNameNode.requestFocus();
            },
            validator: (value) {
              return Validation()
                  .fieldChecker(value: value, field: TextFile.firstName.tr);
            },
            textInputAction: TextInputAction.next,
            inputController: controller.firstNameContoller,
            width: widthSizetextField / 2.1,
            keyBoardInputType: TextInputType.text,
          ),
        ),
        SizedBox(
          width: width_10,
        ),
        // Last Name
        Expanded(
          child: CommonTextFieldWidget(
            hintText: TextFile.lastName.tr,
            iconPath: ImageConstant.imgFile,
            focusNode: controller.lastNameNode,
            onFieldSubmitted: (value) {
              controller.emailNode.requestFocus();
            },
            validator: (value) {
              return Validation()
                  .fieldChecker(value: value, field: TextFile.lastName.tr);
            },
            textInputAction: TextInputAction.next,
            inputController: controller.lastNameContoller,
            width: widthSizetextField / 2.1,
            keyBoardInputType: TextInputType.text,
          ),
        )
      ],
    ).marginOnly(top: margin_5);
  }

  _emailTextField() {
    return CommonTextFieldWidget(
      hintText: TextFile.emailText.tr,
      focusNode: controller.emailNode,
      onFieldSubmitted: (value) {
        controller.phoneNumberNode.requestFocus();
      },
      validator: (value) {
        return Validation().validateEmail(value);
      },
      textInputAction: TextInputAction.next,
      iconPath: ImageConstant.imgVectorGreenA700,
      inputController: controller.emailController,
      width: widthSizetextField,
      keyBoardInputType: TextInputType.emailAddress,
    ).marginOnly(top: margin_8);
  }

  _phoneNumberTextField() {
    return CommonTextFieldWidget(
      hintText: TextFile.phoneNumber.tr,
      iconPath: ImageConstant.imgCall,
      focusNode: controller.phoneNumberNode,
      onFieldSubmitted: (value) {
        controller.passwordNode.requestFocus();
      },
      validator: (value) {
        return Validation().validatePhoneNumber(value);
      },
      textInputAction: TextInputAction.next,
      inputController: controller.phoneNumberController,
      width: widthSizetextField,
      keyBoardInputType: TextInputType.phone,
    ).marginOnly(top: margin_8);
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
      ).marginOnly(top: margin_8),
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

  _tncCheckBox() {
    return Padding(
      padding: EdgeInsets.only(top: getSize(10)),
      child: Row(
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
          PrivacyAndTermAndConditions(
            actionPrivacyPolicy: () {
              CommonUtils().launchUrlInAppView(controller.toLaunch);
            },
            actionTermAndConditions: () {
              CommonUtils().launchUrlInAppView(controller.toLaunch);
            },
          ),
        ],
      ),
    );
  }

  _signUpButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.signUpTitle.tr,
        margin: getMargin(top: 27),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          if (controller.formKey.currentState!.validate()) {
            if (controller.checkBox == true) {
              // controller.firebseSignUp();
              controller.localDbSignup();
            } else {
              showToast(TextFile.pleaseAcceptTermsAndPrivacyPolicy.tr);
            }
          }
        });
  }

  _orContinueWith() {
    return Padding(
        padding: getPadding(left: 6, top: 30, right: 4),
        child: Row(
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
            ]));
  }

  _socialMediaButtons() {
    return Padding(
        padding: getPadding(left: 1, top: 29),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                controller.googleSignUp();
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
        ]));
  }

  _alreadyHaveAnAccount() {
    return Padding(
        padding: getPadding(top: 17),
        child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: TextFile.alreadyHaveAccount.tr,
                  style: AppStyle.txtInterRegular14Gray50001),
              TextSpan(
                  text: TextFile.loginTitle.tr,
                  style: AppStyle.txtDMSansRegular14GreenA700.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.offAllNamed(AppRoutes.loginScreen);
                    })
            ]),
            textAlign: TextAlign.left));
  }

  _continueAsGuest() {
    return GestureDetector(
        onTap: () {},
        child: Padding(
            padding: getPadding(top: 10),
            child: Text(TextFile.continueasGuest.tr,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtDMSansRegular14GreenA700.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline))));
  }
}
