import 'package:foodguru/app_values/export.dart';

class MenuScreen extends GetView<MenuViewController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Scaffold(
        backgroundColor: ColorConstant.black900,
        floatingActionButton: controller.selectedItems.isNotEmpty?_confirmMenuButton():Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: CustomAppBar(
          iosStatusBarBrightness: Brightness.dark,
          title: TextFile.menu.tr,
          iconColor: ColorConstant.whiteA700,
          titleColor: ColorConstant.whiteA700,
        ),
        body: Column(
            children: [
              searchTextFieldWidget(
                      controller: controller.searchController,
                      rightPadding: 0,
                      onTap: () {
                        controller.tempSearchItemsList.value =
                            controller.itemsList.value;
                      },
                      onChanged: (value) {
                        controller.itemsList.value = [];
                        if (value.isNotEmpty) {
                          for (int i = 0;
                              i < controller.tempSearchItemsList.length;
                              i++) {
                            if (controller.tempSearchItemsList[i].itemName!
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                              controller.itemsList.add(
                                controller.tempSearchItemsList[i],
                              );
                            }
                          }
                        } else {
                          controller.itemsList.value =
                              controller.tempSearchItemsList;
                        }
                        controller.update();
                      },
                      borderColor: ColorConstant.greenA700,
                      hint: TextFile.searchFood.tr)
                  .marginOnly(top: margin_15, left: margin_15, right: margin_15),
              _menuTextAndVegNonVegSelection(),
              _itemsList(),
            ],
          ),
      ),
    );
  }

  _menuTextAndVegNonVegSelection() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints.tightFor(),
        padding:
            EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_3),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: ColorConstant.greenA700, width: width_1),
            borderRadius: BorderRadius.circular(radius_25)),
        child: PopupMenuButton(
            shape: RoundedRectangleBorder(
                side:
                    BorderSide(width: width_1, color: ColorConstant.greenA700),
                borderRadius: BorderRadius.circular(radius_10)),
            color: ColorConstant.black900,
            offset: Offset(0, 25),
            onSelected: (value) {
              controller.onCategorySelected(value);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AssetImageWidget(controller.selectedValue.value.image,
                    width: width_30, height: height_10),
                Text(
                  '${controller.selectedValue.value.title}',
                  textAlign: TextAlign.center,
                  style:
                      AppStyle.txtDMSansRegular14.copyWith(color: Colors.white),
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  size: height_20,
                  color: ColorConstant.greenA700,
                )
              ],
            ),
            itemBuilder: (BuildContext context) =>
                controller.popupList.value.map((PopupMenuModel value) {
                  return PopupMenuItem(
                      value: value,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AssetImageWidget(value.image,
                              width: width_30, height: height_10),
                          Text(value.title.toString(),
                                  textAlign: TextAlign.center,
                                  style: AppStyle.txtDMSansRegular14WhiteA700)
                              .marginOnly(left: margin_5),
                        ],
                      ));
                }).toList()),
      ).marginOnly(left: margin_15, right: margin_15, top: margin_10),
    );
  }

  _itemsList() {
    return Expanded(
      child: controller.itemsList.isEmpty
          ? Center(
              child: Text(
                'No Data Found',
                textAlign: TextAlign.center,
                style: AppStyle.txtDMSansBold18WhiteA700,
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: 0),
              shrinkWrap: true,
              itemCount: controller.itemsList.length,
              itemBuilder: (context, index) {
                var data = controller.itemsList[index];
                return Obx(
                  () => MenuItemView(
                    isDarkMode: true,
                    imageUrl: data.images?.first.imageUrl,
                    dishName: data.itemName,
                    itemModel: data,
                    onFavouritePress: (int value) async {
                      controller.itemsList.refresh();
                    },
                    description: data.description,
                    discountedPrice: data.discountedPrice,
                    distance: 40,
                    itemPrice: data.itemPrice,
                    addTextMenuScreen: controller.selectedItems.contains(controller.itemsList[index])
                        ? '- ${TextFile.remove.tr}'
                        : '+ ${TextFile.add.tr}',
                    onAddTap: () {
                      if (controller.selectedItems
                          .contains(controller.itemsList[index])) {
                        controller.selectedItems.remove(controller.itemsList[index]) ;
                      } else {
                        controller.selectedItems
                            .add(controller.itemsList[index]);
                      }
                      debugPrint(controller.selectedItems.toJson().toString());
                    },
                    isVeg: data.isVeg,
                    isAddedToCart: data.isAddedToCart?.value,
                    pointsPerQuantity: data.pointsPerQuantity,
                    restaurantName: data.restaurantName,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: height_10,
                );
              },
            ).marginOnly(top: margin_15),
    );
  }

  _confirmMenuButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.confirmMenu.tr,
        margin: getMargin(
            top: margin_20,
            left: margin_15,
            right: margin_15,
            bottom: margin_20),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          controller.navigateToOrderDetails();
        });
  }
}
