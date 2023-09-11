import 'dart:ui';

import 'package:foodguru/app_values/export.dart';

class ItemDetailsScreen extends GetView<ItemDetailsController> {
  const ItemDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => willPopScopeBackWidget(
        child: Scaffold(
          appBar: CustomAppBar(
            result: true,
            title: controller.itemModel.value?.restaurantName ?? '',
            actions: [
              Transform.scale(
                  scale: 0.4,
                  child: Obx(
                    () => GetInkwell(
                      onTap: () async {
                        await FavouriteNetwork.addRemoveToFavourites(
                            itemId: controller.itemModel.value?.itemId,
                            onSuccess: (value) {
                              controller.itemModel.value?.isFavourite?.value =
                                  value;
                            });
                      },
                      child: AssetImageWidget(
                        controller.itemModel.value?.isFavourite?.value == typeTrue
                            ? ImageConstant.imagesIcLiked
                            : ImageConstant.imagesIcUnliked,
                      ),
                    ),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _carouselSlider(),
                  (controller.itemModel.value?.images?.length ?? 0) <= 1
                      ? Container()
                      : Center(
                          child: AnimatedSmoothIndicator(
                                  activeIndex: controller.carouselIndex.value,
                                  effect: ExpandingDotsEffect(
                                      spacing: width_4,
                                      dotHeight: height_5,
                                      expansionFactor: 2,
                                      dotColor: ColorConstant.gray500,
                                      activeDotColor: ColorConstant.greenA700),
                                  count: controller
                                          .itemModel.value?.images?.length ??
                                      0)
                              .marginOnly(top: margin_10),
                        ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dishNameAndVegNonVeg(),
                      _dishPriceAndQuantity(),
                      _descriptionText(),
                      _descriptionData(),
                      if (controller.itemModel.value?.nutritionList?.length !=
                          0) ...[
                        _nutriousValuesPerServing(),
                        _nutritionList(),
                      ],
                      _addToCartButton(),
                      _frequentlyBoughtTogetherText(),
                      _frequentlyBoughtTogetherList(),
                      SizedBox(
                        height: height_20,
                      ),
                    ],
                  ).marginSymmetric(horizontal: margin_15)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _carouselSlider() {
    return Container(
      height: height_150,
      width: Get.width,
      child: CarouselSlider.builder(
        itemCount: controller.itemModel.value?.images?.length ?? 0,
        options: CarouselOptions(
            scrollPhysics:
                (controller.itemModel.value?.images?.length ?? 0) <= 1
                    ? const NeverScrollableScrollPhysics()
                    : const ScrollPhysics(),
            autoPlay: (controller.itemModel.value?.images?.length ?? 0) <= 1
                ? false
                : true,
            onPageChanged: (index, reason) {
              controller.carouselIndex.value = index;
            },
            aspectRatio: 16 / 9,
            viewportFraction: 1.0),
        itemBuilder: (context, index, realIndex) {
          return AssetImageWidget(
            controller.itemModel.value?.images?[index].imageUrl,
            width: Get.width - margin_30,
            height: height_150,
            boxFit: BoxFit.cover,
            radiusAll: radius_10,
          );
        },
      ),
    ).marginOnly(top: margin_10);
  }

  _dishNameAndVegNonVeg() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(controller.itemModel.value?.itemName ?? 'Red Sauce Pasta',
            style: AppStyle.txtDMSansMedium22.copyWith(color: Colors.black)),
        AssetImageWidget(
          controller.itemModel.value?.isVeg == true ||
                  controller.itemModel.value?.isVeg == typeTrue
              ? ImageConstant.imagesIcVeg
              : ImageConstant.imagesIcNonVeg,
          width: width_15,
        ).marginOnly(left: margin_10),
      ],
    ).marginOnly(top: margin_15);
  }

  _descriptionText() {
    return Text(
      '${TextFile.description.tr}-',
      style: AppStyle.txtDMSansMedium14
          .copyWith(decoration: TextDecoration.underline),
    ).marginOnly(top: margin_12);
  }

  _descriptionData() {
    return Text(
      controller.itemModel.value?.description ?? '',
      style: AppStyle.txtDMSansRegular14Black900,
    ).marginOnly(top: margin_15);
  }

  _nutriousValuesPerServing() {
    return Text(
      '${TextFile.nutiriousValues.tr}-',
      style: AppStyle.txtDMSansMedium14
          .copyWith(decoration: TextDecoration.underline),
    ).marginOnly(top: margin_12);
  }

  Widget _percentIndicator({heading, value, percentage}) {
    return Card(
      elevation: margin_5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius_50)),
      child: CircularPercentIndicator(
          animation: true,
          backgroundColor: Colors.white,
          startAngle: 340,
          circularStrokeCap: CircularStrokeCap.round,
          lineWidth: 7,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                heading ?? '',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppStyle.txtDMSansRegular14Black900
                    .copyWith(fontSize: font_13),
              ).marginSymmetric(horizontal: margin_10),
              Text(
                value ?? '',
                textAlign: TextAlign.center,
                style: AppStyle.txtDMSansBold18GreenA700,
              )
            ],
          ),
          progressColor: ColorConstant.greenA700,
          percent: percentage ?? 0.0,
          radius: Get.height * 0.055),
    );
  }

  _addToCartButton() {
    return CustomButton(
      height: 45,
      shape: ButtonShape.RoundedBorder22,
      fontStyle: ButtonFontStyle.InterSemiBold18,
      onTap: () async {
        await CartNetwork.addRemoveToCart(
          itemId: controller.itemModel.value?.itemId,
          restaurantId: controller.itemModel.value?.restaurantId,
          quantity: 1,
          onSuccess: (value) {
            if (value == true) {
              controller.itemModel.value?.quantity?.value = 1;
            } else {
              controller.itemModel.value?.quantity?.value = 0;
            }
          },
        );
      },
      width: Get.width,
      text: (controller.itemModel.value?.quantity?.value ?? 0) > 0
          ? TextFile.addedToCart.tr
          : TextFile.addToCart.tr,
    ).marginOnly(top: margin_20);
  }

  _frequentlyBoughtItemView({
    String? text,
    required int index,
    String? price,
    String? image,
  }) {
    return GetInkwell(
      onTap: () async {
        Get.offNamed(Get.previousRoute);
        var result = await Get.offNamed(AppRoutes.itemDetailsScreen,
            arguments: {keyId: controller.frequentlyItemsList[index].itemId});
        if (result != null) {
          controller.getItemDetails();
        }
      },
      child: Container(
        // padding: EdgeInsets.all(margin_5),
        height: height_120, width: Get.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_10),
          image: DecorationImage(
              image: AssetImage(image ?? ImageConstant.imagesIcBrownie),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.darken)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius_10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: AssetImageWidget(
                  image,
                  height: width_60,
                  radiusAll: radius_10,
                  width: Get.width,
                  boxFit: BoxFit.cover,
                ).marginAll(margin_7)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            text ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.txtDMSansRegular14Black900
                                .copyWith(color: ColorConstant.whiteA700),
                          ),
                          Text(
                            'Rs ${price ?? '0'}',
                            style: AppStyle.txtDMSansBold14Black900
                                .copyWith(color: ColorConstant.whiteA700),
                          ),
                        ],
                      ),
                    ),
                    (controller.frequentlyItemsList[index].quantity?.value ??
                                0) >
                            0
                        ? _addRemoveItemWidget(index)
                        : CustomButton(
                            onTap: () async {
                              await CartNetwork.addToCart(
                                itemId: controller
                                    .frequentlyItemsList[index].itemId,
                                outletId: controller
                                    .frequentlyItemsList[index].outletId,
                                quantity: 1,
                                onSuccess: (value) {
                                  controller
                                      .fetchFrequentlyBoughtTogetherList();
                                  controller.frequentlyItemsList[index].quantity
                                      ?.value = 1;
                                },
                              );
                            },
                            text: '+ Add',
                            shape: ButtonShape.RoundedBorder22,
                            fontStyle: ButtonFontStyle.DMSansRegular12,
                          )
                  ],
                ).marginOnly(left: margin_8, right: margin_8, bottom: margin_8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _frequentlyBoughtTogetherText() {
    return Text(
      TextFile.frequentlyBoughtTogether.tr,
      style: AppStyle.txtDMSansBold16Black90001,
    ).marginOnly(top: margin_20);
  }

  _dishPriceAndQuantity() {
    return Row(
      children: [
        Expanded(
          child: Text(
              "Rs ${controller.itemModel.value?.discountedPrice ?? 450}",
              style: AppStyle.txtDMSansBold18),
        ),
        (controller.itemModel.value?.quantity?.value ?? 0) > 0
            ? AddRemoveItemWidget(
                onAddTap: () {
                  if ((controller.itemModel.value?.quantity?.value ?? 0) < 99) {
                    controller.itemModel.value?.quantity?.value++;
                    CartNetwork.updateQuantityOfCart(
                        itemId: controller.itemModel.value?.itemId,
                        restaurantId: controller.itemModel.value?.restaurantId,
                        quantity: controller.itemModel.value?.quantity?.value);
                  }
                },
                onRemoveTap: () async {
                  if ((controller.itemModel.value?.quantity?.value ?? 0) > 1) {
                    controller.itemModel.value?.quantity?.value--;
                    CartNetwork.updateQuantityOfCart(
                        itemId: controller.itemModel.value?.itemId,
                        restaurantId: controller.itemModel.value?.restaurantId,
                        quantity: controller.itemModel.value?.quantity?.value);
                  } else if (controller.itemModel.value?.quantity?.value == 1) {
                    await CartNetwork.removeFromCart(
                        itemId: controller.itemModel.value?.itemId);
                    controller.itemModel.value?.quantity?.value = 0;
                  }
                },
                quantity: controller.itemModel.value?.quantity?.value)
            : Container(),
      ],
    ).marginOnly(top: margin_15);
  }

  _nutritionList() {
    return Container(
      height: Get.height * 0.147,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: margin_10),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _percentIndicator(
              heading: controller
                  .itemModel.value?.nutritionList?[index].nutritionText,
              value: controller.itemModel.value?.nutritionList?[index].value
                  .toString(),
              percentage: controller
                      .itemModel.value?.nutritionList?[index].value /
                  controller.itemModel.value?.nutritionList?[index].maxValue);
        },
        itemCount: controller.itemModel.value?.nutritionList?.length ?? 0,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: width_5,
          );
        },
      ),
    );
  }


  _addRemoveItemWidget(index) {
    return AddRemoveItemWidget(
      onRemoveTap: () async {
        if ((controller.frequentlyItemsList[index].quantity?.value ?? 0) > 1) {
          controller.frequentlyItemsList[index].quantity?.value--;
          await CartNetwork.updateQuantityOfCart(
              itemId: controller.frequentlyItemsList[index].itemId,
              restaurantId: controller.frequentlyItemsList[index].restaurantId,
              quantity: controller.frequentlyItemsList[index].quantity?.value);
        } else if (controller.frequentlyItemsList[index].quantity?.value == 1) {
          await CartNetwork.removeFromCart(
                  itemId: controller.frequentlyItemsList[index].itemId)
              .then((value) {
            controller.frequentlyItemsList[index].quantity?.value = 0;
          });
        }
        debugPrint(
            controller.frequentlyItemsList[index].quantity?.value.toString());
        controller.frequentlyItemsList.refresh();
      },
      onAddTap: () async {
        if ((controller.frequentlyItemsList[index].quantity?.value ?? 0) < 99) {
          controller.frequentlyItemsList[index].quantity?.value++;
          await CartNetwork.updateQuantityOfCart(
              itemId: controller.frequentlyItemsList[index].itemId,
              restaurantId: controller.frequentlyItemsList[index].restaurantId,
              quantity: controller.frequentlyItemsList[index].quantity?.value);
        }
        controller.frequentlyItemsList.refresh();
      },
      quantity: controller.frequentlyItemsList[index].quantity?.value,
    ).marginOnly(bottom: margin_10, top: margin_5);
  }

  _frequentlyBoughtTogetherList() {
    return SizedBox(
      height: height_120,
      child: ListView.separated(
        shrinkWrap: true,
        // padding: EdgeInsets.symmetric(horizontal: margin_15),
        itemCount: controller.frequentlyItemsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _frequentlyBoughtItemView(
            image: controller.frequentlyItemsList[index].images?.first.imageUrl,
            index: index,
            text: controller.frequentlyItemsList[index].itemName,
            price: controller.frequentlyItemsList[index].discountedPrice,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: width_18,
          );
        },
      ),
    ).marginOnly(top: margin_10, bottom: margin_15);
  }
}
