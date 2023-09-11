import 'package:foodguru/app_values/export.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class RestaurantDetailsScreen extends GetView<RestaurantDetailsController> {
  const RestaurantDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        result: true,
        title: TextFile.restaurant.tr,
      ),
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: false,
              floating: false,
              delegate: CustomSliverDelegate(
                expandedHeight: height_130,
                particularResturantWidget: _restaurantDetailView(),
                commonDetails: Stack(
                  children: [
                    _restaurantImage(),
                    _shadowEffect(),
                    _restaurantLogo(),
                  ],
                ),
                extraSpace: false,
              ),
            ),
            SliverFillRemaining(
              child: Column(
                children: [
                  _menuTextAndVegNonVegSelection(),
                  _searchFieldView(),
                  _itemsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _restaurantImage() {
    return controller.restaurantDetail.value?.images?.first.imageUrl != null
        ? AssetImageWidget(
            controller.restaurantDetail.value?.images?.first.imageUrl,
            height: height_150,
            width: Get.width,
            boxFit: BoxFit.cover,
            radiusAll: radius_10,
          )
        : Container();
  }

  _shadowEffect() {
    return Container(
      height: height_150,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_10),
          gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              begin: Alignment.topLeft,
              stops: [0.1, 0.4],
              end: Alignment.bottomRight)),
    );
  }

  _restaurantLogo() {
    return Hero(
      tag: '$heroRestaurantLogo${controller.index}',
      child: controller.restaurantDetail.value?.logo != null
          ? AssetImageWidget(
              controller.restaurantDetail.value?.logo,
              height: height_40,
              width: height_40,
              radiusAll: radius_50,
            ).marginOnly(top: margin_10, left: margin_10, bottom: margin_10)
          : Container(
                  height: height_40,
                  width: height_40,
                  decoration: BoxDecoration(
                      color: ColorConstant.gray50,
                      borderRadius: BorderRadius.circular(radius_50)))
              .marginOnly(top: margin_10, left: margin_10, bottom: margin_10),
    );
  }

  _restaurantDetailView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin_30),
      padding: EdgeInsets.symmetric(vertical: margin_5, horizontal: margin_10),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius_5),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray300,
            blurRadius: 6,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  controller.restaurantDetail.value?.restaurantName ?? '',
                  style: AppStyle.txtDMSansBold16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                controller.restaurantDetail.value?.averageRating?.toStringAsFixed(1) ?? '',
                style: AppStyle.txtInterMedium12
                    .copyWith(color: ColorConstant.black900),
              ),
              Icon(Icons.star_rounded,
                  color: ColorConstant.yellowFF9B26, size: height_15),
            ],
          ),
          Text(
            controller.restaurantDetail.value?.categoryId ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.txtDMSansRegular12Gray600,
          ).marginSymmetric(vertical: margin_2),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Text.rich(TextSpan(
                    text: '${TextFile.outlet.tr} -',
                    style: AppStyle.txtDMSansMedium12
                        .copyWith(color: Colors.black),
                    children: [
                      TextSpan(
                          text:
                              ' ${controller.restaurantDetail.value?.outlet ?? ''}',
                          style: AppStyle.txtDMSansRegular12Gray600)
                    ])),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Text(
                      convertDistance(1000),
                      style: AppStyle.txtInterMedium12,
                    ).marginOnly(left: margin_5),
                    VerticalDivider(
                      color: ColorConstant.gray600,
                    ),
                    Text(
                      '5 ${TextFile.mins.tr}',
                      maxLines: 1,
                      style: AppStyle.txtInterMedium12Bluegray400
                          .copyWith(color: ColorConstant.gray600),
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(
            color: ColorConstant.gray800,
          ),
          freeDeliveryText(
              price:
                  '${controller.restaurantDetail.value?.freeDeliveryAbove ?? ''}'),
        ],
      ),
    );
  }

  _menuTextAndVegNonVegSelection() {
    return Row(
      children: [
        Expanded(
          child: Text(
            TextFile.menu.tr,
            style: AppStyle.txtDMSansBold18Black900,
          ),
        ),
        Container(
          constraints: BoxConstraints.tightFor(),
          padding:
              EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_3),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: ColorConstant.greenA700, width: width_0pt5),
              borderRadius: BorderRadius.circular(radius_25)),
          child: PopupMenuButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius_10),
                  side: BorderSide(color: ColorConstant.greenA700)),
              offset: Offset(0, 25),
              onSelected: (value) {
                controller.selectedValue.value = value;
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AssetImageWidget(
                      controller.selectedValue.value.image ??
                          ImageConstant.imagesIcRestaurant,
                      width: width_30,
                      height: height_10),
                  Text(
                    '${controller.selectedValue.value.title}',
                    textAlign: TextAlign.center,
                    style: AppStyle.txtDMSansRegular14
                        .copyWith(color: Colors.black),
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
                                style: TextStyle(
                                  color: ColorConstant.black900,
                                  fontSize: getFontSize(
                                    14,
                                  ),
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                )).marginOnly(left: margin_5),
                          ],
                        ));
                  }).toList()),
        )
      ],
    ).marginOnly(left: margin_15, right: margin_15, top: margin_10);
  }

  _searchFieldView() {
    return searchTextFieldWidget(
            rightPadding: margin_0,
            focusNode: controller.searchNode,
            controller: controller.searchController,
            onChanged: (value) {
              Debouncer debouncer = Debouncer(
                delay: Duration(seconds: 3),
              );
              debouncer.call(
                () {
                  controller.searchedValue.value = controller.searchController?.text ?? '';
                },
              );
              controller.searchedValue.value = value;
            },
            hint: TextFile.searchFood.tr)
        .marginOnly(top: margin_10, left: margin_15, right: margin_15);
  }

  _itemsList() {
    return Expanded(
      child: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: margin_15,
          ),
          shrinkWrap: true,
          itemCount: controller.itemsList.length,
          itemBuilder: (context, index) {
            var data = controller.itemsList[index];
            return Obx(
              () => GetInkwell(
                onTap: () async {
                  var result = await Get.toNamed(AppRoutes.itemDetailsScreen,
                      arguments: {keyId: data.itemId});
                  if (result != null) {
                    controller.getItemDetails();
                  }
                },
                child: MenuItemView(
                  imageUrl: data.images?.first.imageUrl,
                  dishName: data.itemName,
                  itemModel: data,
                  onAddToCartPress: (value) {
                    data.isAddedToCart?.value = value;
                    controller.itemsList.refresh();
                    controller.update();
                  },
                  onFavouritePress: (int value) async {
                    data.isFavourite?.value = value;
                    controller.itemsList.refresh();
                  },
                  description: data.description,
                  discountedPrice: data.discountedPrice,
                  distance: 400,
                  itemPrice: data.itemPrice,
                  isVeg: data.isVeg,
                  isAddedToCart: data.isAddedToCart?.value,
                  onAddTap: () {
                    controller.itemsList.refresh();
                    controller.update();
                  },
                  onRemoveTap: () {
                    controller.itemsList.refresh();
                    controller.update();
                  },
                  onItemRemovedFromCart: () {
                    data.quantity?.value = 0;
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
        ).marginOnly(top: margin_8),
      ),
    );
  }
}
