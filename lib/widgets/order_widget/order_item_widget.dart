import 'package:foodguru/app_values/export.dart';


class OrderItemWidget extends StatelessWidget {
  String? restaurantName;
  OrderItemDataModel? itemModel;
  String? dishName;
  String? description;
  String? imageUrl;
  String? itemPrice;
  String? discountedPrice;
  int? distance;
  Function()? onFavouritePress;
  int? isVeg;
  bool? isFavourite;
  bool? isAddedToCart;
  var quantity;
  String? size;


  OrderItemWidget(
      {this.restaurantName,
        this.itemPrice,
        this.itemModel,
        this.imageUrl,
        this.distance,
        this.quantity,
        this.dishName,
        this.discountedPrice,
        this.description,
        this.isVeg,
        this.isFavourite,
        this.size,
        this.isAddedToCart,
        this.onFavouritePress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin_8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray300,
            blurRadius: 10,
          )
        ],
        borderRadius: BorderRadius.circular(radius_5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              AssetImageWidget(
                imageUrl ?? ImageConstant.imagesIcDosa,
                width: width_60,height: width_60,radiusAll: radius_100,boxFit: BoxFit.cover,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurantName ?? '',
                      style: AppStyle.txtDMSansRegular12Gray600,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            dishName ?? '',textAlign: TextAlign.start,
                            style: AppStyle.txtDMSansBold14Black90001,
                          ),
                        ),
                        AssetImageWidget(
                          isVeg == typeTrue
                              ? ImageConstant.imagesIcVeg
                              : ImageConstant.imagesIcNonVeg,
                          width: width_15,
                        ).marginOnly(left: margin_10)
                      ],
                    ).marginSymmetric(vertical: margin_5),
                    Text(
                      description ?? '',
                      style: AppStyle.txtDMSansRegular12Gray600,
                    ).marginOnly(bottom: margin_5),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text.rich(TextSpan(
                              text: '${TextFile.qty.tr}: ',
                              style: AppStyle.txtDMSansRegular12Gray600,
                              children: [
                                TextSpan(
                                    text: '$quantity',
                                    style: AppStyle.txtDMSansMedium12Black90001
                                        .copyWith(decoration: TextDecoration.none))
                              ])),
                        if(size!=null)...[
                          VerticalDivider(color: ColorConstant.gray600),
                          Text.rich(TextSpan(
                              text: '${TextFile.size.tr}: ',
                              style: AppStyle.txtDMSansRegular12Gray600,
                              children: [
                                TextSpan(
                                    text:size?? 'Small',
                                    style: AppStyle.txtDMSansMedium12Black90001
                                        .copyWith(decoration: TextDecoration.none))
                              ])),
                        ]

                        ],
                      ),
                    )
                  ],
                ).marginOnly(left: margin_10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          convertDistance(distance ?? 800),
                          style: AppStyle.txtInterMedium12
                              .copyWith(color: ColorConstant.gray600),
                        ),
                        VerticalDivider(
                          color: Colors.black,
                        ),
                        Text(
                          itemModel?.averageRating?.toStringAsFixed(1) ?? '0.0',
                          style: AppStyle.txtInterMedium12
                              .copyWith(color: ColorConstant.black900),
                        ),
                        Icon(Icons.star_rounded,
                            color: ColorConstant.yellowFF9B26, size: height_15),
                        VerticalDivider(color: Colors.black),
                        GetInkwell(
                          onTap: () async {
                            if (itemModel?.itemId != null) {
                              await FavouriteNetwork.addRemoveToFavourites(
                                  itemId: itemModel?.itemId,
                                  onSuccess: (value) {
                                    itemModel?.isFavourite?.value = value;
                                    debugPrint(value.toString());
                                    debugPrint(itemModel?.isFavourite?.value.toString());
                                    onFavouritePress!();
                                  });
                            }
                          },
                          child: AssetImageWidget(
                              itemModel?.isFavourite?.value == typeTrue
                                  ? ImageConstant.imagesIcLiked
                                  : ImageConstant.imagesIcUnliked,
                              width: width_15),
                        )
                      ],
                    ),
                  ),
                  Text('Rs. ${discountedPrice??500}',style: AppStyle.txtDMSansBold14Black900,).marginOnly(top: margin_30)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
