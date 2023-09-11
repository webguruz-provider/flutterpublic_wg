import 'package:foodguru/app_values/export.dart';

class CategoriesScreen extends GetView<CategoriesController> {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: TextFile.categories.tr),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height_10),
              _searchTextField(),
              _popUpMenuButton(),
              _categoryGridView(),
            ],
          ),
        ),
      ),
    );
  }

  _searchTextField() {
    return CustomTextFormField(
      onChanged: (value) {
        controller.searchFunction(value);
      },
      prefix: CustomImageView(
        svgPath: ImageConstant.imgSearch,
      ).marginAll(margin_10),
      suffix: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            VerticalDivider(
                color: ColorConstant.gray500,
                thickness: width_1,
                indent: height_8,
                endIndent: height_8),
            CustomImageView(
              svgPath: ImageConstant.imgMenu13x18,
              height: height_12,
            ).marginOnly(right: margin_15, left: margin_4)
          ],
        ),
      ),
      hintText: TextFile.searchCategories.tr,
      border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.gray400, width: width_1),
          borderRadius: BorderRadius.circular(radius_25)),
    ).marginSymmetric(horizontal: margin_15);
  }

  _popUpMenuButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        alignment: Alignment.topLeft,
        width: width_70,
        padding: EdgeInsets.symmetric(horizontal: margin_5, vertical: margin_5),
        margin:
            EdgeInsets.symmetric(vertical: margin_15, horizontal: margin_15),
        decoration: BoxDecoration(
            color: ColorConstant.whiteA700,
            borderRadius: BorderRadius.circular(radius_8),
            border: Border.all(color: ColorConstant.greenA700)),
        child: PopupMenuButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: ColorConstant.greenA700),
                borderRadius: BorderRadiusDirectional.circular(radius_8)),
            offset: const Offset(0, 25),
            onSelected: (value) {
              controller.selectedValue.value = value;
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    '${controller.selectedValue.value ?? TextFile.view.tr}',
                    textAlign: TextAlign.center,
                    style: AppStyle.txtDMSansRegular14
                        .copyWith(color: Colors.black),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  size: height_20,
                  color: ColorConstant.greenA700,
                )
              ],
            ),
            itemBuilder: (BuildContext context) =>
                controller.valueInItems.value.map((value) {
                  return PopupMenuItem(
                      value: value,
                      height: height_15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(value.toString(),
                              textAlign: TextAlign.center,
                              style: AppStyle.txtDMSansRegular14Black900),
                          PopupMenuDivider(
                            height: height_0,
                          )
                        ],
                      ));
                }).toList()),
      ),
    );
  }

  _categoryGridView() {
    return controller.categoriesList.isEmpty
        ? listEmptyWidget(
                text: 'No Categories Found', icon: Icons.category_outlined)
            .marginOnly(top: Get.height * 0.23)
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.categoriesList.length,
            padding: EdgeInsets.symmetric(
                horizontal: margin_15, vertical: margin_10),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: height_15,
                childAspectRatio: controller.selectedValue.value == 2
                    ? 0.84
                    : controller.selectedValue.value == 3
                        ? 0.8
                        : 0.73,
                mainAxisSpacing: height_15,
                crossAxisCount: controller.selectedValue.value ?? 4),
            itemBuilder: (context, index) {
              return GetInkwell(
                onTap: () {
                  Get.toNamed(AppRoutes.itemListScreen, arguments: {
                    keyCategory: controller.categoriesList[index].categoryName,keyId:controller.categoriesList[index].categoryId
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: AssetImageWidget(
                        height: height_200,
                        width: width_200,
                        controller.categoriesList[index].imageUrl,
                        boxFit: BoxFit.cover,
                        radiusAll: radius_100,
                      ),
                    ),
                    Text(
                      controller.categoriesList[index].categoryName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppStyle.txtInterRegular12Black900.copyWith(
                          fontSize: controller.selectedValue.value == 2
                              ? font_15
                              : controller.selectedValue.value == 3
                                  ? font_12
                                  : font_12),
                    ).marginOnly(
                        top: controller.selectedValue.value == 2
                            ? margin_10
                            : controller.selectedValue.value == 3
                                ? margin_10
                                : margin_10)
                  ],
                ),
              );
            },
          );
  }
}
