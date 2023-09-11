import 'dart:ui';

import 'package:foodguru/app_values/export.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return AnnotatedRegion(
          value:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: ColorConstant.gray50,
              // appBar: PreferredSize(preferredSize: Size.fromHeight(0),child: Container(),),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    _appBar(),
                    _searchTextField(),
                    _takeawayDeliverySelection(),
                    _titleAndSeeAllButton(
                      title: TextFile.categories.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.categoriesScreen);
                      },
                    ),
                    _categoriesList(),
                    _titleAndSeeAllButton(
                      title: TextFile.specialOffers.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.specialOffersScreen,
                            arguments: {isBirthdaySpecial: false});
                      },
                    ),
                    _specialOffersCarousel(),
                    if(controller.recentlyOrderedList.isNotEmpty)...[
                      _titleAndSeeAllButton(
                        title: TextFile.recentlyOrdered.tr,
                        onTap: () async {
                          var result = await Get.toNamed(AppRoutes.itemListScreen,
                              arguments: {
                                keyCategory: TextFile.recentlyOrdered.tr,keyItemListType:keyItemRecentlyOrdered
                              });
                          if (result != null) {
                            controller.refreshAllLists();
                            controller.update();
                          }
                        },
                      ),
                      _recentlyOrderedList(),
                    ],
                    _titleAndSeeAllButton(
                      title: TextFile.restaurants.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.searchedRestaurantListScreen);
                      },
                    ),
                    _restaurantsList(),
                    _titleAndSeeAllButton(
                      title: TextFile.recommendedForYou.tr,
                      onTap: () async {
                        var result = await Get.toNamed(AppRoutes.itemListScreen,
                            arguments: {
                              keyCategory: TextFile.recommendedForYou.tr,
                              keyItemListType:keyItemRecommended
                            });
                        if (result != null) {
                          controller.refreshAllLists();
                          controller.update();
                        }
                      },
                    ),
                    _recommendedOrderList(),
                    _titleAndSeeAllButton(
                      title: TextFile.seasonalSpecial.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.itemListScreen, arguments: {
                          keyCategory: TextFile.seasonalSpecial.tr,
                          keyItemListType:keyItemSeasonalSpecial
                        });
                      },
                    ),
                    _itemDetailDescription(),
                    _titleAndSeeAllButton(
                      title: TextFile.birthdaySpecial.tr,
                      onTap: () {
                        Get.toNamed(AppRoutes.specialOffersScreen,
                            arguments: {isBirthdaySpecial: true});
                      },
                    ),
                    _birthdaySpecialList(),
                    SizedBox(
                      height: margin_15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _searchTextField() {
    return Hero(
      tag: 'A',
      child: CustomTextFormField(
        readOnly: true,
        onTap: () {
          Get.toNamed(AppRoutes.searchScreen);
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
        hintText: TextFile.searchFoodRestaurant.tr,
        border: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorConstant.gray400, width: width_1),
            borderRadius: BorderRadius.circular(radius_25)),
      ).marginSymmetric(horizontal: margin_15),
    );
  }

  _appBar() {
    return Obx(
      () => PreferredSize(
        preferredSize: Size.fromHeight(height_100),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness:
                  GetPlatform.isAndroid ? Brightness.light : Brightness.light),
          leadingWidth: width_60,
          leading: GetInkwell(
            onTap: () async {
              var result = await Get.toNamed(AppRoutes.profileScreen);
              if (result != null) {
                controller.refreshAllLists();
              }
            },
            child: Transform.scale(
              scale: 0.8,

              child: controller.imageFile.value != null
                  ? FileImageWidget(
                      controller.imageFile.value?.path,
                      width: width_60,
                      height: width_60,
                      radiusAll: radius_50,
                      boxFit: BoxFit.cover,
                    ).marginOnly(left: margin_10)
                  : AssetImageWidget(
                      ImageConstant.iconsIcLoginImg,
                      width: width_60,
                      height: width_60,
                      radiusAll: radius_50,
                      boxFit: BoxFit.cover,
                    ).marginOnly(left: margin_10),

              // AssetImageWidget(ImageConstant.iconsIcLoginImg,
              //         width: width_60,
              //         height: width_60,
              //         boxFit: BoxFit.cover,
              //         radiusAll: radius_50)
              //     .marginOnly(left: margin_10),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${TextFile.hello.tr} ${controller.userDbModel.value?.firstName ?? ''},',
                style: AppStyle.txtInterRegular16
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                  onTap: () async {
                    if(DataSettings.isPublic!=true){
                      var result = await Get.toNamed(AppRoutes.addressListScreen,
                          arguments: {fromHomeKey: true});
                      if (result != null) {
                        controller.refreshAllLists();
                      }
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        controller.currentAddress ?? "Location fetching",
                        style: AppStyle.txtInterRegular12Gray600,
                      ).marginOnly(top: margin_2),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: height_15,
                        color: ColorConstant.greenA700,
                      )
                    ],
                  )),
            ],
          ),
          titleSpacing: height_5,
          actions: [
            GetInkwell(
              onTap: () {
                Get.toNamed(AppRoutes.notificationsScreen);
              },
              child: AssetImageWidget(
                ImageConstant.imagesIcNotification,
                width: width_20,
              ).marginOnly(right: margin_15),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabItem({title, index}) {
    return GetInkwell(
      onTap: () {
        controller.selectedTab = index;
        debugPrint(controller.selectedTab.toString());
        controller.update();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AssetImageWidget(
              controller.selectedTab == index
                  ? ImageConstant.imagesIcSelected
                  : ImageConstant.imagesIcUnselected,
              width: width_15,
              height: width_15),
          Text(
            title ?? '',
            style: controller.selectedTab == index
                ? AppStyle.txtDMSansMedium12Black90001.copyWith(
                    color: Colors.black,
                    fontSize: font_12,
                    fontWeight: FontWeight.w600)
                : AppStyle.txtDMSansRegular12Gray600
                    .copyWith(fontSize: font_12),
          ).marginOnly(left: margin_10)
        ],
      ),
    );
  }

  _takeawayDeliverySelection() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_25),
            border:
                Border.all(color: ColorConstant.greenA700, width: width_1pt5)),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _tabItem(title: TextFile.takeaway.tr, index: keyOrderTypeTakeaway)
                  .marginOnly(top: margin_8, bottom: margin_8, left: margin_20),
              Transform.rotate(
                      angle: 500,
                      child: VerticalDivider(
                          color: Colors.black,
                          thickness: width_1pt5,
                          indent: width_5,
                          endIndent: width_5))
                  .marginSymmetric(horizontal: margin_5),
              _tabItem(title: TextFile.delivery.tr, index: keyOrderTypeDelivery).marginOnly(
                  top: margin_8, bottom: margin_8, right: margin_20),
            ],
          ),
        ),
      ),
    ).marginOnly(top: margin_15, left: margin_15, right: margin_15);
  }

  _titleAndSeeAllButton(
      {String? title, Function()? onTap, bool showSeeAll = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? '',
          style: AppStyle.txtDMSansBold16,
        ),
        showSeeAll == true
            ? GetInkwell(
                onTap: onTap ?? () {},
                child: Text(
                  TextFile.seeAll.tr,
                  style: AppStyle.txtDMSansRegular14GreenA700,
                ),
              )
            : Container(),
      ],
    ).marginOnly(top: margin_15, right: margin_15, left: margin_15);
  }

  _categoriesList() {
    return Container(
      width: Get.width,
      height: height_80,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: margin_15),
        itemCount: controller.categoriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GetInkwell(
            onTap: () {
              Get.toNamed(AppRoutes.itemListScreen, arguments: {
                keyCategory: controller.categoriesList[index].categoryName,
                keyId: controller.categoriesList[index].categoryId
              });
            },
            child: SizedBox(
              width: width_50,
              child: Column(
                children: [
                  AssetImageWidget(
                    controller.categoriesList[index].imageUrl,
                    width: width_50,
                    height: width_50,
                    boxFit: BoxFit.cover,
                    radiusAll: radius_50,
                  ),
                  Expanded(
                      child: Text(
                    controller.categoriesList[index].categoryName ?? '',
                    style: AppStyle.txtInterRegular12Black900,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ).marginOnly(top: margin_5))
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: width_10,
          );
        },
      ),
    ).marginOnly(top: margin_10);
  }

  _recentlyOrderedList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount:
          controller.recentlyOrderedList.length > 2 ? 2 : controller.recentlyOrderedList.length,
      padding: EdgeInsets.symmetric(horizontal: margin_15),
      itemBuilder: (context, index) {
        var data = controller.recentlyOrderedList[index];
        return GetInkwell(
          onTap: () async {
            var result = await Get.toNamed(AppRoutes.itemDetailsScreen,
                arguments: {keyId: data.itemId});
            if (result != null) {
              controller.refreshAllLists();
              controller.update();
            }
          },
          child: Obx(
            () => MenuItemView(
              imageUrl: data.images?.first.imageUrl,
              dishName: data.itemName ?? '',
              description: data.description,
              itemModel: data,
              discountedPrice: data.discountedPrice,
              distance: 40,
              itemPrice: data.itemPrice,
              isVeg: data.isVeg,
              onAddTap: () {
                controller.update();
              },
              onRemoveTap: () {
                controller.update();
              },
              onItemRemovedFromCart: () {
                data.quantity?.value = 0;
                controller.update();
              },
              isAddedToCart: data.isAddedToCart?.value,
              onAddToCartPress: (value) {
                controller.getAllItemDetails();
                data.isAddedToCart?.value = value;
                controller.update();
              },
              onFavouritePress: (int value) async {
                data.isFavourite?.value = value;
                controller.update();
              },
              pointsPerQuantity: data.pointsPerQuantity,
              restaurantName: data.restaurantName,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_10,
        );
      },
    ).marginOnly(top: margin_15);
  }

  _specialOffersCarousel() {
    return controller.specialOfferList.isEmpty
        ? Container()
        : Gallery3D(
            autoLoop: false,
            itemCount: controller.specialOfferList.length,
            width: Get.width * 0.7,
            height: 120,
            isClip: false,
            // ellipseHeight: 80,
            itemConfig: const GalleryItemConfig(
              width: 230,
              height: 200,
              radius: 10,
              isShowTransformMask: false,
            ),
            currentIndex: controller.currentIndex,
            scrollTime: 4,
            onItemChanged: (index) {
              controller.currentIndex = index;
              controller.update();
            },
            onClickItem: (index) => debugPrint("currentIndex:$index"),
            itemBuilder: (context, index) {
              return Image.asset(
                controller.specialOfferList[index].imageUrl ?? '',
                fit: BoxFit.fill,
              );
            }).marginOnly(top: margin_15);
  }

  _restaurantsList() {
    return Container(
      width: Get.width,
      height: height_80,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: margin_15),
        itemCount: controller.restaurantList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GetInkwell(
            onTap: () async {
              var result = await Get.toNamed(AppRoutes.restaurantDetailsScreen,
                  arguments: {
                    keyId: controller.restaurantList[index].outletId,
                    keyIndex: index
                  });
              if (result != null) {
                controller.refreshAllLists();
                controller.update();
              }
            },
            child: SizedBox(
              width: width_55,
              child: Column(
                children: [
                  Hero(
                    tag: '$heroRestaurantLogo$index',
                    child: AssetImageWidget(
                      controller.restaurantList[index].logo,
                      width: width_50,
                      height: width_50,
                      radiusAll: radius_50,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    controller.restaurantList[index].restaurantName ?? '',
                    style: AppStyle.txtInterRegular12Black900,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ).marginOnly(top: margin_5))
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: width_10,
          );
        },
      ),
    ).marginOnly(top: margin_10);
  }

  _recommendedOrderList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount:
          controller.recommendedList.length > 2 ? 2 : controller.recommendedList.length,
      padding: EdgeInsets.symmetric(horizontal: margin_15),
      itemBuilder: (context, index) {
        var data = controller.recommendedList[index];
        return GetInkwell(
          onTap: () async {
            var result = await Get.toNamed(AppRoutes.itemDetailsScreen,
                arguments: {keyId: data.itemId});
            if (result != null) {
              controller.refreshAllLists();
              controller.update();
            }
          },
          child: Obx(
            () => MenuItemView(
              imageUrl: data.images?.first.imageUrl,
              dishName: data.itemName ?? '',
              description: data.description,
              itemModel: data,
              onAddToCartPress: (value) {
                controller.getAllItemDetails();
                data.isAddedToCart?.value = value;
                controller.update();
              },
              discountedPrice: data.discountedPrice,
              distance: 40,
              itemPrice: data.itemPrice,
              isVeg: data.isVeg,
              onAddTap: () {
                controller.update();
              },
              onRemoveTap: () {
                controller.update();
              },
              onItemRemovedFromCart: () {
                data.quantity?.value = 0;
                controller.update();
              },
              isAddedToCart: data.isAddedToCart?.value,
              onFavouritePress: (int value) async {
                data.isFavourite?.value = value;
                controller.update();
              },
              pointsPerQuantity: data.pointsPerQuantity,
              restaurantName: data.restaurantName,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_10,
        );
      },
    ).marginOnly(top: margin_15);
  }

  _itemDetailDescription() {
    return GetInkwell(
      onTap: () {
        Get.toNamed(AppRoutes.itemDetailsScreen,
            arguments: {keyId: controller.seasonalSpecial.itemId});
      },
      child: Stack(
        children: [
          Container(
            // height: Get.height * 0.2,
            margin: EdgeInsets.symmetric(horizontal: margin_15),
            // padding: EdgeInsets.all(margin_12),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      (controller.seasonalSpecial.images?.length ?? 0) > 1
                          ? controller.seasonalSpecial.images![1].imageUrl
                          : controller.seasonalSpecial.images?.first.imageUrl ??
                              ImageConstant.imagesIcDosa,
                    ),
                    opacity: 0.22,
                    // colorFilter: ColorFilter.mode(ColorConstant.whiteA700.withOpacity(0.6), BlendMode.darken),

                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(radius_8)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius_8),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AssetImageWidget(
                            controller.seasonalSpecial.images?.first.imageUrl,
                            radiusAll: radius_15,
                            height: height_70,
                            boxFit: BoxFit.cover,
                            width: Get.width * 0.4,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.seasonalSpecial.restaurantName ??
                                      '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.txtDMSansRegular12Gray600,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        controller.seasonalSpecial.itemName ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style:
                                            AppStyle.txtDMSansBold14Black90001,
                                      ),
                                    ),
                                    AssetImageWidget(
                                      controller.seasonalSpecial.isVeg ==
                                              typeTrue
                                          ? ImageConstant.imagesIcVeg
                                          : ImageConstant.imagesIcNonVeg,
                                      width: width_15,
                                    ).marginOnly(left: margin_10)
                                  ],
                                ).marginSymmetric(vertical: margin_5),
                                IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '300m',
                                        style: AppStyle.txtInterMedium12
                                            .copyWith(
                                                color: ColorConstant.gray600),
                                      ),
                                      const VerticalDivider(
                                        color: Colors.black,
                                      ),
                                      Text(
                                        controller.seasonalSpecial.averageRating
                                                ?.toStringAsFixed(1) ??
                                            '',
                                        style: AppStyle.txtInterMedium12
                                            .copyWith(
                                                color: ColorConstant.black900),
                                      ),
                                      Icon(Icons.star_rounded,
                                          color: ColorConstant.yellowFF9B26,
                                          size: height_15),
                                    ],
                                  ),
                                ),
                                Text.rich(TextSpan(
                                    text:
                                        'Rs. ${controller.seasonalSpecial.itemPrice ?? 0}',
                                    style: AppStyle.txtDMSansRegular12Gray600
                                        .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough),
                                    children: [
                                      TextSpan(
                                          text:
                                              '  Rs.${controller.seasonalSpecial.discountedPrice ?? 0}',
                                          style: AppStyle
                                              .txtDMSansBold14Black90001
                                              .copyWith(
                                                  decoration:
                                                      TextDecoration.none))
                                    ]))
                              ],
                            ).marginOnly(left: margin_10),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  TextFile.description.tr,
                                  style: AppStyle.txtDMSansMedium16
                                      .copyWith(color: Colors.black),
                                ).marginOnly(top: margin_10),
                                Text(
                                  controller.seasonalSpecial.description ?? '0',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: AppStyle.txtDMSansRegular12Gray60001,
                                ).marginOnly(top: margin_5),
                              ],
                            ).marginOnly(right: margin_15),
                          ),
                          (controller.seasonalSpecial.quantity?.value ?? 0) > 0
                              ? AddRemoveItemWidget(
                                  onRemoveTap: () async {
                                    if ((controller.seasonalSpecial.quantity
                                                ?.value ??
                                            0) >
                                        1) {
                                      controller
                                          .seasonalSpecial.quantity?.value--;
                                      await CartNetwork.updateQuantityOfCart(
                                          itemId:
                                              controller.seasonalSpecial.itemId,
                                          restaurantId: controller
                                              .seasonalSpecial.restaurantId,
                                          quantity: controller
                                              .seasonalSpecial.quantity?.value);
                                    } else if (controller
                                            .seasonalSpecial.quantity?.value ==
                                        1) {
                                      await CartNetwork.removeFromCart(
                                              itemId: controller
                                                  .seasonalSpecial.itemId)
                                          .then((value) {
                                        controller.seasonalSpecial.quantity
                                            ?.value = 0;
                                        controller.update();
                                      });
                                    }
                                    debugPrint(controller
                                        .seasonalSpecial.quantity?.value
                                        .toString());
                                    controller.update();
                                  },
                                  onAddTap: () async {
                                    if ((controller.seasonalSpecial.quantity
                                                ?.value ??
                                            0) <
                                        99) {
                                      controller
                                          .seasonalSpecial.quantity?.value++;
                                      await CartNetwork.updateQuantityOfCart(
                                          itemId:
                                              controller.seasonalSpecial.itemId,
                                          restaurantId: controller
                                              .seasonalSpecial.restaurantId,
                                          quantity: controller
                                              .seasonalSpecial.quantity?.value);
                                    }
                                    controller.update();
                                  },
                                  quantity: controller
                                      .seasonalSpecial.quantity?.value,
                                )
                              : GetInkwell(
                                  onTap: () async {
                                    await CartNetwork.addToCart(
                                      itemId: controller.seasonalSpecial.itemId,
                                      outletId: controller
                                          .seasonalSpecial.restaurantId,
                                      quantity: 1,
                                      onSuccess: (value) {
                                        controller.seasonalSpecial.quantity
                                            ?.value = 1;
                                        controller.update();
                                      },
                                    );
                                    controller.update();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(margin_8),
                                    decoration: BoxDecoration(
                                        color: ColorConstant.greenA700,
                                        borderRadius:
                                            BorderRadius.circular(radius_25)),
                                    child: Text('+ ${TextFile.addToCart.tr}',
                                        style: AppStyle.txtDMSansRegular12
                                            .copyWith(color: Colors.white)),
                                  ).marginOnly(top: margin_15),
                                )
                        ],
                      )
                    ],
                  ).marginAll(margin_15)),
            ),
          ).marginOnly(top: margin_15),
        ],
      ),
    );
  }

  _birthdaySpecialList() {
    return Container(
      width: Get.width,
      height: height_90,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: margin_15),
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return AssetImageWidget(
            ImageConstant.imagesIcBirthdayBanner,
            width: Get.width * 0.7,
            boxFit: BoxFit.cover,
            radiusAll: radius_10,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: width_10,
          );
        },
      ),
    ).marginOnly(top: margin_10);
  }
}
