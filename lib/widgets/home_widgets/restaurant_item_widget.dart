import 'package:foodguru/app_values/export.dart';

class RestaurantItemWidget extends StatelessWidget {
  String? imageUrl;
  String? restaurantName;
  String? description;
  String? outlet;
  var freeDeliveryAbove;
  int? pointsPerQuantity;
  double? rating;
  var distance;
  var time;

  var index;

  RestaurantItemWidget(
      {this.restaurantName,
      this.outlet,
      this.imageUrl,
      this.index,
      this.rating,
      this.pointsPerQuantity,
      this.distance,
      this.description,
      this.time,
      this.freeDeliveryAbove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin_5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius_5),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray300,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Hero(
                tag: '$heroRestaurantLogo${index}',
                child: AssetImageWidget(
                  imageUrl ?? ImageConstant.imagesIcDominos,
                  width: width_60,
                  height: width_60,
                  radiusAll: radius_50,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            restaurantName ?? '',
                            style: AppStyle.txtDMSansBold16,
                          ),
                        ),
                        Text(
                          rating?.toStringAsFixed(1) ?? '0.0',
                          style: AppStyle.txtInterMedium12
                              .copyWith(color: ColorConstant.black900),
                        ),
                        Icon(Icons.star_rounded,
                            color: ColorConstant.yellowFF9B26, size: height_15),
                      ],
                    ),
                    Text(
                      description ?? '',
                      maxLines: 1,
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
                                    text: outlet ?? ' Noida',
                                    style: AppStyle.txtDMSansRegular12Gray600)
                              ])),
                        ),
                        Row(
                          children: [
                            AssetImageWidget(
                              ImageConstant.imagesIcDistance,
                              width: width_12,
                            ),
                            Text(
                              convertDistance(4500),
                              style: AppStyle.txtInterMedium12,
                            ).marginOnly(left: margin_5)
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: freeDeliveryText(price: '$freeDeliveryAbove')
                              .marginOnly(top: margin_2),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              AssetImageWidget(
                                ImageConstant.imagesIcTime,
                                width: width_12,
                              ),
                              Flexible(
                                  child: Text(
                                '${time ?? 15} ${TextFile.mins.tr}',
                                maxLines: 1,
                                style: AppStyle.txtInterMedium12,
                              ).marginOnly(left: margin_5))
                            ],
                          ),
                        ),
                      ],
                    ).marginOnly(top: margin_1)
                  ],
                ).marginOnly(left: margin_10),
              )
            ],
          ),
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
      ),
    );
  }
}
