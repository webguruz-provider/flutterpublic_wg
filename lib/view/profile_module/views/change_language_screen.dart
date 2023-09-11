import 'package:foodguru/app_values/export.dart';

class ChangeLanguageScreen extends GetView<ChangeLanguageController> {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(title: TextFile.changeLanguage.tr, result: true),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomButton(
          height: 45,
          width: getSize(width),
          shape: ButtonShape.RoundedBorder22,
          text: TextFile.saveChanges.tr,
          margin: getMargin(top: margin_20),
          variant: ButtonVariant.OutlineBlack9003f,
          fontStyle: ButtonFontStyle.InterSemiBold18,
          onTap: () {
            Get.offAllNamed(AppRoutes.mainScreen);
            Get.lazyPut(() => HomeController(),);
            PreferenceManger().setLanguage(controller
                .languageList[controller.selectedLanguage.value].locale);
            PreferenceManger().setLanguageId(controller
                .languageList[controller.selectedLanguage.value].id);
            Get.updateLocale(Locale(controller
                .languageList[controller.selectedLanguage.value].locale!));
          }).marginSymmetric(horizontal: margin_15, vertical: margin_10),
      body: Obx(
        () => Column(
          children: [
            _searchTextField(),
            _languageList(),
          ],
        ).marginAll(margin_15),
      ),
    );
  }

  _searchTextField() {
    return CustomTextFormField(
      controller: controller.searchController,
      focusNode: controller.searchNode,
      hintText: TextFile.searchLanguage.tr,
      onChanged: (value) {
        controller.searchFunction(value);
      },
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius_25),
          borderSide: BorderSide(color: ColorConstant.gray400)),
      prefixConstraints:
          BoxConstraints(minHeight: width_15, minWidth: width_15),
      prefix: AssetImageWidget(ImageConstant.imagesIcSearch, width: width_15)
          .marginSymmetric(horizontal: margin_10),
    );
  }

  _languageList() {
    return Expanded(
      child: controller.languageList.isEmpty
          ? listEmptyWidget(text: TextFile.noResultFound.tr)
          : ListView.separated(
              shrinkWrap: true,
              itemCount: controller.languageList.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => GetInkwell(
                    onTap: () async {
                      if (index < 2) {
                        controller.selectedLanguage.value = index;
                        controller.selectedLangCode.value =
                            controller.languageList[index].locale!;
                        // Get.updateLocale(
                        //     controller.languageList[index].locale!);

                        print(controller
                            .languageList[index].locale);
                        debugPrint(PreferenceManger().getLanguage().toString());
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          controller.languageList[index].title ?? '',
                          style: AppStyle.txtDMSansRegular16
                              .copyWith(color: Colors.black),
                        )),
                        AssetImageWidget(
                          controller.languageList[index].locale != null
                              ? controller.selectedLangCode.value ==
                                      controller.languageList[index].locale!
                                  ? ImageConstant.imagesIcLanguageSelected
                                  : ImageConstant.imagesIcLanguageUnselected
                              : ImageConstant.imagesIcLanguageUnselected,
                          width: width_15,
                          height: width_15,
                        )
                      ],
                    ).marginSymmetric(horizontal: margin_15),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: ColorConstant.gray600, height: height_15);
              },
            ).marginSymmetric(vertical: margin_20),
    );
  }
}
