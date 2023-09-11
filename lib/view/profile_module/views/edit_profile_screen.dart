import 'package:foodguru/app_values/export.dart';

class EditProfileScreen extends GetView<EditProfileController> {



  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: TextFile.myProfile.tr,result: true  ),
      body: SingleChildScrollView(
          child: Obx(
        () => Column(
          children: [
            _imageView(),
            _form(),
            _saveChangesButton(),
          ],
        ).marginAll(margin_15),
      )),
    );
  }

  _form() {
    return Form(
        key: controller.formKey,
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First name
            _firstNameTextFormField(),
            SizedBox(
              width: width_10,
            ),
            // Last Name
            _lastNameTextFormField(),
          ],
        ).marginOnly(top: margin_20),
        _emailTextField(),
        _phoneNumberTextField(),
        _dateOfBirthTextField(),
      ],
    ));
  }

  _firstNameTextFormField() {
    return Expanded(
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
        inputController: controller.firstNameController,
        width: widthSizetextField / 2.1,
        keyBoardInputType: TextInputType.text,
      ),
    );
  }

  _lastNameTextFormField() {
    return Expanded(
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
        inputController: controller.lastNameController,
        width: widthSizetextField / 2.1,
        keyBoardInputType: TextInputType.text,
      ),
    );
  }

  _emailTextField() {
    return CommonTextFieldWidget(
      hintText: TextFile.emailText.tr,
      focusNode: controller.emailNode,
      onFieldSubmitted: (value) {
        controller.phoneNumberNode.requestFocus();
      },
      readOnly: true,

      validator: (value) {
        return Validation().validateEmail(value);
      },
      textInputAction: TextInputAction.next,
      iconPath: ImageConstant.imgVectorGreenA700,
      inputController: controller.emailController,
      width: widthSizetextField,
      keyBoardInputType: TextInputType.emailAddress,
    ).marginOnly(top: margin_10);
  }

  _phoneNumberTextField() {
    return CommonTextFieldWidget(
      hintText: TextFile.phoneNumber.tr,
      iconPath: ImageConstant.imgCall,
      focusNode: controller.phoneNumberNode,
      onFieldSubmitted: (value) {
        controller.dobNode.requestFocus();
      },
      validator: (value) {
        return Validation().validatePhoneNumber(value);
      },
      textInputAction: TextInputAction.next,
      inputController: controller.phoneNumberController,
      width: widthSizetextField,
      keyBoardInputType: TextInputType.phone,
    ).marginOnly(top: margin_10);
  }

  _dateOfBirthTextField() {
    return CommonTextFieldWidget(
      readOnly: true,
      onTap: () async {
        controller.dateOfBirth.value = await showDatePicker(
            builder: (context, child) {
              return Theme(
                  data: ThemeData.light().copyWith(
                      colorScheme:
                          ColorScheme.light(primary: ColorConstant.greenA700),
                      buttonTheme:
                          ButtonThemeData(textTheme: ButtonTextTheme.primary)),
                  child: child!);
            },
            context: Get.context!,
            initialDate: subtractYearFromCurrentDate(year: minAgeToUseApp),
            firstDate: DateTime(1900),
            lastDate: subtractYearFromCurrentDate(year: minAgeToUseApp));
        if (controller.dateOfBirth.value != null) {
          controller.dobController.text = dateFormatDateTime(
              format: 'dd-MMMM-yyyy', value: controller.dateOfBirth.value);
          debugPrint(controller.dateOfBirth.value.toString());
        }
      },
      hintText: TextFile.dateOfBirth.tr,
      iconPath: ImageConstant.imagesImgCalendar,
      focusNode: controller.dobNode,
      textInputAction: TextInputAction.next,
      inputController: controller.dobController,
      width: widthSizetextField,
      keyBoardInputType: TextInputType.phone,
    ).marginOnly(top: margin_10);
  }

  _imageView() {
    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      children: [
        controller.imageFile.value != null
            ? FileImageWidget(
                controller.imageFile.value?.path,
                width: width_80,
                height: width_80,
                radiusAll: radius_50,
                boxFit: BoxFit.cover,
              )
            : AssetImageWidget(
                ImageConstant.iconsIcLoginImg,
                width: width_80,
                height: width_80,
                radiusAll: radius_50,
                boxFit: BoxFit.cover,
              ),
        Positioned(
          right: -30,
          bottom: -10,
          child: RawMaterialButton(
              onPressed: () {
                controller.showImageSourceActionSheet(
                  Get.context!,
                );
              },
              elevation: 2.0,
              fillColor: ColorConstant.greenA700,
              shape: const CircleBorder(),
              child: SvgPicture.asset(
                ImageConstant.imgCamera,
              )),
        )
      ],
    );
  }

  _saveChangesButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.saveChanges.tr,
        margin: getMargin(top: margin_30),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          if(controller.formKey.currentState!.validate()){


              controller.localDbEditProfile();
            }else{
              showToast(TextFile.pleaseAcceptTermsAndPrivacyPolicy.tr);
            }

        });
  }
}
