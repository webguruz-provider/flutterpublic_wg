import 'dart:ui';

import 'package:foodguru/app_values/export.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(title: TextFile.cart.tr, leading: Container()),
          body: controller.itemsList.isEmpty
              ? listEmptyWidget(
                  text: TextFile.bagIsEmpty.tr,
                  image: ImageConstant.imagesIcCartSelected)
              : Column(
                  children: [
                    _takeawayDeliverySelection(controller),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: controller.scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _cartList(controller),
                            if(controller.frequentlyItemsList.isNotEmpty)...[
                              _frequentlyBoughtTogetherText(),
                              _frequentlyBoughtTogetherList(controller),
                            ]

                          ],
                        ),
                      ),
                    ),
                    _proceedToPayButton(controller),
                  ],
                ),
        );
      },
    );
  }

  _cartList(CartController controller) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: margin_15),
        itemBuilder: (context, index) {
          var data = controller.itemsList[index];
          return MenuItemView(
            itemModel: data,
            imageUrl: data.images?.first.imageUrl,
            dishName: data.itemName,
            description: data.description,
            discountedPrice: data.discountedPrice,
            distance: 40,
            itemPrice: data.itemPrice,
            isVeg: data.isVeg,
            isAddedToCart: data.isAddedToCart?.value,
            onAddToCartPress: (value) {
              data.isAddedToCart?.value = value;
              controller.update();
            },
            onFavouritePress: (int value) async {
              controller.update();
            },
            pointsPerQuantity: data.pointsPerQuantity,

            restaurantName: data.restaurantName,
            showQuantity: true,
            onAddTap: () {
              controller.update();
            },
            onRemoveTap: () {
              controller.update();
            },
            onItemRemovedFromCart: () {
              controller.itemsList.removeAt(index);
              controller.fetchFrequentlyBoughtTogetherList();
              controller.update();
            },
            quantity: data.quantity?.value,
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: height_10,
          );
        },
        itemCount: controller.itemsList.length);
  }

  _frequentlyBoughtTogetherText() {
    return Text(
      TextFile.frequentlyBoughtTogether.tr,
      style: AppStyle.txtDMSansBold16Black90001,
    ).marginOnly(left: margin_15, right: margin_15, top: margin_15);
  }


  _frequentlyBoughtItemView(CartController controller,{
    String? text,
    required int index,
    String? price,
    String? image,
  }) {
    return GetInkwell(
      onTap: () async {
        var result = await Get.toNamed(AppRoutes.itemDetailsScreen,
            arguments: {keyId: controller.frequentlyItemsList[index].itemId});
        if (result != null) {
          controller.getCartList();
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
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken)
          ),
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
                      height: width_60,radiusAll: radius_10,
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
                     CustomButton(
                      onTap: () async {
                        await CartNetwork.addToCart(
                          itemId:
                          controller.frequentlyItemsList[index].itemId,
                          outletId: controller
                              .frequentlyItemsList[index].outletId,
                          quantity: 1,
                          onSuccess: (value) {
                            controller.fetchFrequentlyBoughtTogetherList();
                            controller.frequentlyItemsList[index].quantity
                                ?.value = 1;
                            controller.getCartList();
                            controller.update();
                          },
                        );
                      },
                      text: '+ ${TextFile.add.tr}',
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

  _proceedToPayButton(CartController controller) {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.proceed.tr,
        margin: getMargin(left: margin_15, right: margin_15, bottom: margin_10),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () async {
          var result = await Get.toNamed(AppRoutes.billScreen,
              arguments: {keyModel: controller.itemsList,keyOrderType:Get.find<HomeController>().selectedTab});
          if (result != null) {
            controller.update();
          }
        }).marginOnly(top: margin_5);
  }
  _takeawayDeliverySelection(CartController controller) {
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
              _tabItem(controller,title: TextFile.takeaway.tr, index: keyOrderTypeTakeaway)
                  .marginOnly(top: margin_8, bottom: margin_8, left: margin_20),
              Transform.rotate(
                  angle: 500,
                  child: VerticalDivider(
                      color: Colors.black,
                      thickness: width_1pt5,
                      indent: width_5,
                      endIndent: width_5))
                  .marginSymmetric(horizontal: margin_5),
              _tabItem(controller,title: TextFile.delivery.tr, index: keyOrderTypeDelivery).marginOnly(
                  top: margin_8, bottom: margin_8, right: margin_20),
            ],
          ),
        ),
      ),
    ).marginOnly(bottom: margin_15,top: margin_5, left: margin_15, right: margin_15);
  }
  Widget _tabItem(controller,{title, index}) {
    var homeController=Get.find<HomeController>();
    return GetInkwell(
      onTap: () {

        homeController.selectedTab = index;
        debugPrint(homeController.selectedTab.toString());
        homeController.update();
        controller.update();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AssetImageWidget(
              homeController.selectedTab == index
                  ? ImageConstant.imagesIcSelected
                  : ImageConstant.imagesIcUnselected,
              width: width_15,
              height: width_15),
          Text(
            title ?? '',
            style: homeController.selectedTab == index
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
  _addRemoveItemWidget(index,CartController controller) {
    return AddRemoveItemWidget(
      onRemoveTap: () async {
        if ((controller.frequentlyItemsList[index].quantity?.value ?? 0) > 1) {
          controller.frequentlyItemsList[index].quantity?.value--;
          await CartNetwork.updateQuantityOfCart(
              itemId: controller.frequentlyItemsList[index].itemId,
              restaurantId: controller.frequentlyItemsList[index].restaurantId,
              quantity: controller.frequentlyItemsList[index].quantity?.value);
        } else if (controller.frequentlyItemsList[index].quantity?.value ==
            1) {
          await CartNetwork.removeFromCart(
              itemId: controller.frequentlyItemsList[index].itemId)
              .then((value) {
            controller.frequentlyItemsList[index].quantity?.value = 0;
          });
        }
        debugPrint(
            controller.frequentlyItemsList[index].quantity?.value.toString());
        controller.update();
      },
      onAddTap: () async {
        if ((controller.frequentlyItemsList[index].quantity?.value ?? 0) <
            99) {
          controller.frequentlyItemsList[index].quantity?.value++;
          await CartNetwork.updateQuantityOfCart(
              itemId: controller.frequentlyItemsList[index].itemId,
              restaurantId: controller.frequentlyItemsList[index].restaurantId,
              quantity: controller.frequentlyItemsList[index].quantity?.value);
        }
        controller.update();
      },
      quantity: controller.frequentlyItemsList[index].quantity?.value,
    ).marginOnly(bottom: margin_10,top: margin_5);
  }

  _frequentlyBoughtTogetherList(CartController controller) {
    return SizedBox(
      height: height_120,
      child: ListView.separated(
        shrinkWrap: true,
        padding:
        EdgeInsets.symmetric(horizontal: margin_15),
        itemCount: controller.frequentlyItemsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _frequentlyBoughtItemView(controller,index: index,
            image: controller.frequentlyItemsList[index].images?.first.imageUrl,
            text: controller.frequentlyItemsList[index].itemName??'',
            price: controller.frequentlyItemsList[index].discountedPrice,
          );
        },
        separatorBuilder:
            (BuildContext context, int index) {
          return SizedBox(
            width: width_18,
          );
        },
      ),
    ).marginOnly(top: margin_10, bottom: margin_15);
  }
}
