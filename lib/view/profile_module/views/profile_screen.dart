import 'package:flutter/cupertino.dart';
import 'package:foodguru/app_values/export.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(
        title: TextFile.myProfile.tr,
        result: true,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileView(),
              _generalSettingsText(),
              _generalSettingsList(),
              _moreSettingsText(),
              _moreSettingsList(),
              _logoutButton(),
            ],
          ).marginAll(margin_15),
        ),
      ),
    );
  }

  _profileView() {
    return Container(
      padding: EdgeInsets.all(margin_10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius_10),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9001e,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          _profileImage(),
          _nameNumberAndAddress(),
          _editProfileAndPoints(),
        ],
      ),
    );
  }

  _profileImage() {
    return controller.imageFile.value != null
        ? FileImageWidget(
            controller.imageFile.value?.path,
            width: width_70,
            height: width_70,
            boxFit: BoxFit.cover,
            radiusAll: radius_50,
          )
        : AssetImageWidget(
            ImageConstant.iconsIcLoginImg,
            width: width_70,
            height: width_70,
            boxFit: BoxFit.cover,
            radiusAll: radius_50,
          );

    AssetImageWidget(
      ImageConstant.iconsIcLoginImg,
      width: width_70,
      height: width_70,
    );
  }

  _nameNumberAndAddress() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${controller.userDbModel.value?.firstName}',
            style: AppStyle.txtInterMedium12.copyWith(fontSize: font_16),
          ),
          Text(
            '${controller.userDbModel.value?.phone}',
            style: AppStyle.txtInterRegular12Gray50001,
          ).marginOnly(top: margin_2),
          Text(
            'Church Street, Shimla',
            style: AppStyle.txtInterRegular12Gray50001,
          ).marginOnly(top: margin_2),
        ],
      ).marginOnly(left: margin_10),
    );
  }

  _editProfileAndPoints() {
    return Column(
      children: [
        GetInkwell(
          onTap: () async {
            var result = await Get.toNamed(AppRoutes.editProfileScreen);
            if (result != null) {
              controller.getSavedLoginData();
            }
          },
          child: Row(
            children: [
              AssetImageWidget(ImageConstant.imagesIcEdit, width: width_14),
              Text(
                TextFile.editProfile.tr,
                style: AppStyle.txtDMSansRegular12GreenA700,
              ).marginOnly(left: margin_2)
            ],
          ),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: margin_8, horizontal: margin_15),
          decoration: BoxDecoration(
            color: ColorConstant.yellowFF9B26,
            borderRadius: BorderRadius.circular(radius_20),
          ),
          child: Obx(() => Text(
                '${controller.points.value ?? 0} ${TextFile.points.tr}',
                style: AppStyle.txtDMSansRegular12WhiteA700,
              )),
        ).marginOnly(top: margin_10),
      ],
    );
  }

  _generalSettingsText() {
    return Text(
      TextFile.generalSettings.tr,
      style: AppStyle.txtDMSansRegular14Gray50004,
    ).marginOnly(top: margin_30);
  }

  _moreSettingsText() {
    return Text(
      TextFile.more.tr,
      style: AppStyle.txtDMSansRegular14Gray50004,
    ).marginOnly(top: margin_20);
  }

  _notificationSwitch() {
    return Obx(
      () => SizedBox(
        width: width_30,
        height: width_20,
        child: Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            dragStartBehavior: DragStartBehavior.down,
            value: controller.notificationToggle.value,
            onChanged: (value) {
              controller.notificationToggle.value = value;
            },
            activeColor: ColorConstant.greenA700,
          ),
        ),
      ),
    );
  }

  _generalSettingsList() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.generalSettingsList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GetInkwell(
          onTap: () async {
            if (DataSettings.isPublic != true) {
              switch (index) {
                case 0:
                  Get.toNamed(AppRoutes.addressListScreen,
                      arguments: {fromProfileKey: true});
                  break;
                case 1:
                  Get.toNamed(AppRoutes.resetPasswordScreen,
                      arguments: {fromProfileKey: true});
                  break;
                case 2:
                  Get.toNamed(AppRoutes.paymentScreen);
                  break;
                case 3:
                  Get.toNamed(AppRoutes.orderHistoryScreen);
                  break;
                case 4:
                  Get.toNamed(AppRoutes.walletScreen);
                  break;
                case 5:
                  Get.toNamed(AppRoutes.changeLanguageScreen);
                  break;
                case 6:
                  Get.toNamed(AppRoutes.pointsScreen);
                  break;
              }
            }else{
              showToast('Coming Soon');
            }
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.generalSettingsList[index],
                  style:
                      AppStyle.txtDMSansRegular16.copyWith(color: Colors.black),
                ),
              ),
              index == controller.generalSettingsList.length - 1
                  ? _notificationSwitch()
                  : Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: height_15,
                    ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: ColorConstant.gray400,
          height: height_15,
        );
      },
    ).marginOnly(top: margin_20);
  }

  _moreSettingsList() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: controller.moreSettingsList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GetInkwell(
          onTap: () {
            switch (index) {
              case 0:
                Get.toNamed(AppRoutes.feedbackScreen);
                break;
              case 1:
                Get.toNamed(AppRoutes.contactUsScreen);
                break;
              case 2:
                Get.toNamed(AppRoutes.aboutUsScreen);
                break;
              case 3:
                Get.toNamed(AppRoutes.faqScreen);
                break;
            }
          },
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.moreSettingsList[index],
                  style:
                      AppStyle.txtDMSansRegular16.copyWith(color: Colors.black),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: height_15,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: ColorConstant.gray400,
          height: height_15,
        );
      },
    ).marginOnly(top: margin_20);
  }

  _logoutButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.logout.tr,
        margin: getMargin(top: margin_30, bottom: margin_20),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          Get.dialog(Center(
            child: Container(
                padding: EdgeInsets.all(margin_15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius_12)),
                child: Material(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            TextFile.logoutWarning.tr,
                            textAlign: TextAlign.center,
                            style: AppStyle.txtDMSansBold16
                                .copyWith(color: Colors.black),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                    height: 45,
                                    width: getSize(width),
                                    shape: ButtonShape.RoundedBorder22,
                                    text: TextFile.no.tr,
                                    margin: getMargin(top: margin_20),
                                    variant: ButtonVariant.OutlineBlack9003f_1,
                                    fontStyle: ButtonFontStyle.InterSemiBold18,
                                    onTap: () {
                                      Get.back();
                                    }),
                              ),
                              SizedBox(
                                width: width_15,
                              ),
                              Expanded(
                                child: CustomButton(
                                    height: 45,
                                    width: getSize(width),
                                    shape: ButtonShape.RoundedBorder22,
                                    text: TextFile.yes.tr,
                                    margin: getMargin(top: margin_20),
                                    variant: ButtonVariant.OutlineBlack9003f,
                                    fontStyle: ButtonFontStyle.InterSemiBold18,
                                    onTap: () {
                                      Get.back();
                                      controller.logoutFunctionLocalDB();
                                    }),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ).marginAll(margin_15));
        });
  }
}
