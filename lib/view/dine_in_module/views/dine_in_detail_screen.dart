import 'package:foodguru/app_values/export.dart';

class DineInDetailsScreen extends GetView<DineInDetailsController> {
  const DineInDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorConstant.black900,
        appBar: CustomAppBar(
          iosStatusBarBrightness: Brightness.dark,
          title: controller.restaurantDataModel.value.restaurantName ?? '',
          titleColor: ColorConstant.whiteA700,
          iconColor: ColorConstant.whiteA700,
        ),
        body: Obx(
          () => CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: false,
                floating: false,
                delegate: CustomSliverDelegate(
                  expandedHeight: height_150,
                  particularResturantWidget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSmoothIndicator(
                              activeIndex: controller.pageIndex.value,
                              effect: ExpandingDotsEffect(
                                  spacing: width_4,
                                  dotHeight: height_3,
                                  expansionFactor: 2,
                                  dotColor: ColorConstant.gray500,
                                  activeDotColor: ColorConstant.greenA700),
                              count: 3)
                          .marginOnly(bottom: margin_5),
                      _restaurantDetailView(),
                    ],
                  ),
                  commonDetails: ClipRRect(
                    borderRadius: BorderRadius.circular(radius_10),
                    child: Stack(
                      children: [
                        _restaurantImage(),
                        _shadowEffect(),
                        _restaurantLogo(),
                      ],
                    ),
                  ),
                  extraSpace: false,
                ),
              ),
              SliverFillRemaining(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _descriptionText(),
                    _descriptionView(),
                    _contactAndDirectionsButton(),
                    _menuTextAndVegNonVegSelection(),
                    _itemsList(),
                    _bookATableButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _restaurantImage() {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      itemCount: controller.restaurantDataModel.value.images?.length,
      onPageChanged: (value) {
        controller.pageIndex.value = value;
      },
      itemBuilder: (context, index) {
        return AssetImageWidget(
          controller.restaurantDataModel.value.images?[index].imageUrl ??
              ImageConstant.imagesIcRestaurant,
          height: height_150,
          width: Get.width,
          boxFit: BoxFit.cover,
          radiusAll: radius_10,
        );
      },
    );
  }

  _shadowEffect() {
    return IgnorePointer(
      child: Container(
        // height: height_150,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_10),
            gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                begin: Alignment.topLeft,
                stops: const [0.1, 0.4],
                end: Alignment.bottomRight)),
      ),
    );
  }

  _restaurantLogo() {
    return Hero(
      tag: '$heroRestaurantLogo${controller.index}',
      child: controller.restaurantDataModel.value.logo != null
          ? AssetImageWidget(
              controller.restaurantDataModel.value.logo,
              height: height_40,
              width: height_40,
              radiusAll: radius_50,
            ).marginOnly(top: margin_10, left: margin_10, bottom: margin_10)
          : Container(
              height: height_40,
              width: height_40,
              decoration: BoxDecoration(
                  color: ColorConstant.gray50,
                  borderRadius: BorderRadius.circular(radius_50))),
    );
  }

  Widget _restaurantDetailView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin_30),
      padding: EdgeInsets.symmetric(vertical: margin_5, horizontal: margin_10),
      width: Get.width,
      decoration: BoxDecoration(
        color: ColorConstant.blueGray90001,
        borderRadius: BorderRadius.circular(radius_5),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black90019,
            blurRadius: 6,
            offset: const Offset(0, 2),
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
                  controller.restaurantDataModel.value.restaurantName ?? '',
                  style: AppStyle.txtDMSansBold16WhiteA700,
                ),
              ),
              Text(
                controller.restaurantDataModel.value.averageRating?.toStringAsFixed(1) ?? '',
                style: AppStyle.txtInterMedium12
                    .copyWith(color: ColorConstant.whiteA700),
              ),
              Icon(Icons.star_rounded,
                  color: ColorConstant.yellowFF9B26, size: height_15),
            ],
          ),
          Text(
            controller.restaurantDataModel.value.categoryId ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.txtDMSansRegular12WhiteA700,
          ).marginSymmetric(vertical: margin_2),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Text.rich(TextSpan(
                    text: '${TextFile.outlet.tr} - ',
                    style: AppStyle.txtDMSansMedium12WhiteA700,
                    children: [
                      TextSpan(
                          text:
                              controller.restaurantDataModel.value.outlet ?? '',
                          style: AppStyle.txtDMSansRegular12WhiteA700)
                    ])),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Text(
                      convertDistance(4),
                      style: AppStyle.txtInterMedium12WhiteA700,
                    ).marginOnly(left: margin_5),
                    VerticalDivider(
                      color: ColorConstant.gray200,
                    ),
                    Text(
                      '5 ${TextFile.mins.tr}',
                      maxLines: 1,
                      style: AppStyle.txtInterMedium12WhiteA700,
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(
            color: ColorConstant.gray800,
          ),
          Align(
            alignment: Alignment.center,
            child: Text('Buy 1 get 1 offer on order above 499',
                style: AppStyle.txtDMSansMedium12WhiteA700),
          ),
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
            style: AppStyle.txtDMSansBold18WhiteA700,
          ),
        ),
        Container(
          constraints: const BoxConstraints.tightFor(),
          padding:
              EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_3),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border:
                  Border.all(color: ColorConstant.greenA700, width: width_1),
              borderRadius: BorderRadius.circular(radius_25)),
          child: PopupMenuButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: width_1, color: ColorConstant.greenA700),
                  borderRadius: BorderRadius.circular(radius_10)),
              color: ColorConstant.black900,
              offset: const Offset(0, 25),
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
                    style: AppStyle.txtDMSansRegular14
                        .copyWith(color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    size: height_20,
                    color: ColorConstant.greenA700,
                  )
                ],
              ),
              itemBuilder: (BuildContext context) =>
                  controller.popupList.map((PopupMenuModel value) {
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
        )
      ],
    ).marginOnly(left: margin_15, right: margin_15, top: margin_10);
  }

  _itemsList() {
    return Expanded(
      child: ListView.separated(
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
              fromRestaurantView: true,
              discountedPrice: data.discountedPrice,
              distance: 40,
              itemPrice: data.itemPrice,
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

  _descriptionText() {
    return Text(TextFile.description.tr,
            style: AppStyle.txtDMSansBold18WhiteA700)
        .marginOnly(top: margin_5, right: margin_15, left: margin_15);
  }

  _descriptionView() {
    return Text(
      controller.restaurantDataModel.value.description ?? '',
      maxLines: 5,
      style: AppStyle.txtDMSansRegular12WhiteA700,
    ).marginOnly(left: margin_15, right: margin_15, top: margin_5);
  }

  Widget _roundedButtons({Function()? onTap, String? title, String? imageUrl}) {
    return GetInkwell(
      onTap: onTap ?? () {},
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: margin_5, horizontal: margin_10),
        decoration: BoxDecoration(
          border: Border.all(width: width_1, color: ColorConstant.greenA700),
          borderRadius: BorderRadius.circular(radius_20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AssetImageWidget(
              imageUrl ?? ImageConstant.imagesIcCall,
              width: width_10,
            ),
            Text(
              title ?? "",
              style: AppStyle.txtDMSansRegular12GreenA700,
            ).marginOnly(left: margin_5)
          ],
        ),
      ),
    );
  }

  _contactAndDirectionsButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _roundedButtons(
          title: TextFile.contact.tr,
          imageUrl: ImageConstant.imagesIcCall,
          onTap: () {
            launchUrl(Uri(
                scheme: 'tel',
                path: controller.restaurantDataModel.value.phone));
          },
        ),
        _roundedButtons(
          title: TextFile.direction.tr,
          imageUrl: ImageConstant.imagesIcDirections,
          onTap: () {
            MapsLauncher.launchCoordinates(
                controller.restaurantDataModel.value.latitude!,
                controller.restaurantDataModel.value.longitude!);
          },
        ),
      ],
    ).marginOnly(left: margin_15, right: margin_15, top: margin_15);
  }

  _bookATableButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.bookATable.tr,
        margin: getMargin(bottom: margin_10),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          Get.toNamed(AppRoutes.dineInBookTableScreen, arguments: {
            keyId: controller.restaurantDataModel.value.outletId
          });
        }).marginAll(margin_15);
  }
}
