import 'package:foodguru/app_values/export.dart';
import 'package:foodguru/app_values/export.dart';

class MenuItemView extends StatelessWidget {
  ItemModel? itemModel;
  String? restaurantName;
  String? dishName;
  String? description;
  String? imageUrl;
  String? itemPrice;
  String? discountedPrice;
  String? pointsPerQuantity;
  int? distance;
  ValueChanged<int>? onFavouritePress;
  ValueChanged<bool>? onAddToCartPress;
  var isVeg;
  bool? showQuantity;
  bool? isAddedToCart;
  bool isDarkMode;
  bool fromRestaurantView;
  Function()? onRemoveTap;
  Function()? onItemRemovedFromCart;
  Function()? onAddTap;
  int? quantity;
  String? addTextMenuScreen;

  MenuItemView({
    this.itemModel,
    this.restaurantName,
    this.onFavouritePress,
    this.pointsPerQuantity,
    this.itemPrice,
    this.addTextMenuScreen,
    this.imageUrl,
    this.distance,
    this.quantity,
    this.onAddTap,
    this.onRemoveTap,
    this.dishName,
    this.isDarkMode = false,
    this.discountedPrice,
    this.description,
    this.fromRestaurantView = false,
    this.onAddToCartPress,
    this.onItemRemovedFromCart,
    this.isVeg,
    this.showQuantity,
    this.isAddedToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin_8),
      decoration: BoxDecoration(
        color: isDarkMode == true ? ColorConstant.blueGray90001 : Colors.white,
        boxShadow: [
          BoxShadow(
            color:
                isDarkMode == true ? Colors.transparent : ColorConstant.gray300,
            blurRadius: 10,
            spreadRadius: 0,
          )
        ],
        borderRadius: BorderRadius.circular(radius_5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _imageView(),
              _itemDetails(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _distanceRatingAndFavourites(),
               fromRestaurantView==false && isDarkMode==true?
               _menuAddButton() :
                  fromRestaurantView == true
                      ? Container(
                          height: height_45,
                        )
                      : (itemModel?.quantity?.value ?? 0) > 0
                          ? _addRemoveItemWidget()
                          : _addToCart(),
                ],
              )
            ],
          ),
          if (fromRestaurantView != true) ...[
            Divider(
              color: ColorConstant.gray800,
            ),
            RichText(
                text: TextSpan(
                    text: '${pointsPerQuantity ?? '4'} ${TextFile.points.tr}',
                    style: AppStyle.txtDMSansRegular12
                        .copyWith(color: ColorConstant.yellowFF9B26),
                    children: [
                  TextSpan(
                      text: ' / ${TextFile.perQuantity.tr}',
                      style: AppStyle.txtDMSansRegular12Gray600)
                ]))
          ],
        ],
      ),
    );
  }

  _imageView() {
    return AssetImageWidget(
      imageUrl,
      width: width_60,
      height: width_60,
      boxFit: BoxFit.cover,
      radiusAll: radius_50,
    );
  }

  _itemDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _restaurantName(),
          Row(
            children: [
              _itemName(),
              _vegNonVegIcon(),
            ],
          ).marginSymmetric(vertical: margin_5),
          _descriptionText(),
          _price(),
        ],
      ).marginOnly(left: margin_10),
    );
  }

  _restaurantName() {
    return Text(
      restaurantName ?? '',
      style: isDarkMode == true
          ? AppStyle.txtDMSansRegular12WhiteA700
          : AppStyle.txtDMSansRegular12Gray600,
    );
  }

  _itemName() {
    return Flexible(
      child: Text(
        '$dishName',
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: isDarkMode == true
            ? AppStyle.txtDMSansBold14WhiteA700
            : AppStyle.txtDMSansBold14Black90001,
      ),
    );
  }

  _vegNonVegIcon() {
    return AssetImageWidget(
      isVeg == typeTrue || isVeg == true
          ? ImageConstant.imagesIcVeg
          : ImageConstant.imagesIcNonVeg,
      width: width_15,
    ).marginOnly(left: margin_10, right: margin_10);
  }

  _descriptionText() {
    return Text(
      description ?? '',
      style: isDarkMode == true
          ? AppStyle.txtDMSansRegular12WhiteA700
          : AppStyle.txtDMSansRegular12Gray600,
    ).marginOnly(bottom: margin_5);
  }

  _price() {
    return Text.rich(TextSpan(
        text: 'Rs. ${itemPrice ?? ''}',
        style: AppStyle.txtDMSansRegular12Gray600.copyWith(
            decoration: TextDecoration.lineThrough,
            color: isDarkMode == true
                ? ColorConstant.whiteA700
                : ColorConstant.gray600),
        children: [
          TextSpan(
              text: '  Rs. ${discountedPrice ?? ''}',
              style: AppStyle.txtDMSansBold14Black90001.copyWith(
                  decoration: TextDecoration.none,
                  color: isDarkMode == true
                      ? ColorConstant.whiteA700
                      : ColorConstant.black900))
        ]));
  }

  _distanceRatingAndFavourites() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _distanceText(),
          _verticalDivider(),
          _rating(),
          _ratingIcon(),
          _verticalDivider(),
          _favouriteButton(),
        ],
      ),
    );
  }

  _distanceText() {
    return Text(
      convertDistance(distance ?? 800),
      style: AppStyle.txtInterMedium12.copyWith(
          color: isDarkMode == true
              ? ColorConstant.whiteA700
              : ColorConstant.gray600),
    );
  }

  _verticalDivider() {
    return VerticalDivider(
      color: isDarkMode == true ? ColorConstant.gray200 : Colors.black,
    );
  }

  _rating() {
    return Text(
      itemModel?.averageRating?.toStringAsFixed(1) ?? '0.0',
      style: AppStyle.txtInterMedium12.copyWith(
          color: isDarkMode == true
              ? ColorConstant.whiteA700
              : ColorConstant.black900),
    );
  }

  _ratingIcon() {
    return Icon(Icons.star_rounded,
        color: ColorConstant.yellowFF9B26, size: height_15);
  }

  _favouriteButton() {
    return GetInkwell(
      onTap: () async {
        if (itemModel?.itemId != null) {
          await FavouriteNetwork.addRemoveToFavourites(
              itemId: itemModel?.itemId,
              onSuccess: (value) {
                itemModel?.isFavourite?.value = value;
                debugPrint(value.toString());
                debugPrint(itemModel?.isFavourite?.value.toString());
                onFavouritePress!(value);
              });
        }
      },
      child: AssetImageWidget(
          itemModel?.isFavourite?.value == typeTrue
              ? ImageConstant.imagesIcLiked
              : ImageConstant.imagesIcUnliked,
          //if it is liked then it will show in red color else will show color According to Theme
          color: itemModel?.isFavourite?.value == typeTrue
              ? ColorConstant.red500
              : isDarkMode == true
                  ? ColorConstant.whiteA700
                  : ColorConstant.black900,
          width: width_15),
    );
  }

  _addRemoveItemWidget() {
    return AddRemoveItemWidget(
      onRemoveTap: () async {
        if ((itemModel?.quantity?.value ?? 0) > 1) {
          itemModel?.quantity?.value--;
          await CartNetwork.updateQuantityOfCart(
              itemId: itemModel?.itemId,
              restaurantId: itemModel?.restaurantId,
              quantity: itemModel?.quantity?.value);
        } else if (itemModel?.quantity?.value == 1) {
          await CartNetwork.removeFromCart(itemId: itemModel?.itemId)
              .then((value) {
            onItemRemovedFromCart!();
          });
        }
        debugPrint(itemModel?.quantity?.value.toString());
        onRemoveTap!();
      },
      onAddTap: () async {
        if ((itemModel?.quantity?.value ?? 0) < 99) {
          itemModel?.quantity?.value++;
          await CartNetwork.updateQuantityOfCart(
              itemId: itemModel?.itemId,
              restaurantId: itemModel?.restaurantId,
              quantity: itemModel?.quantity?.value);
        }
        onAddTap!();
      },
      quantity: itemModel?.quantity?.value,
    ).marginOnly(top: margin_20);
  }

  _addToCart() {
    return GetInkwell(
      onTap: () async {
        if (itemModel != null) {
          await CartNetwork.addToCart(
            itemId: itemModel?.itemId,
            outletId: itemModel?.outletId,
            quantity: 1,
            onSuccess: (value) {
              onAddToCartPress!(value);
              itemModel?.quantity?.value = 1;
            },
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(margin_8),
        decoration: BoxDecoration(
            color: ColorConstant.greenA700,
            borderRadius: BorderRadius.circular(radius_25)),
        child: Text('+ ${TextFile.addToCart.tr}',
            style: AppStyle.txtDMSansRegular12.copyWith(color: Colors.white)),
      ).marginOnly(top: margin_15),
    );
  }

  _menuAddButton() {
    return GetInkwell(
      onTap: onAddTap??() async {

      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: margin_8,horizontal: margin_15),
        decoration: BoxDecoration(
            color: ColorConstant.greenA700,
            borderRadius: BorderRadius.circular(radius_25)),
        child: Text(addTextMenuScreen??'+ ${TextFile.add.tr}',
            style: AppStyle.txtDMSansRegular12.copyWith(color: Colors.white)),
      ).marginOnly(top: margin_15),
    );
  }
}
