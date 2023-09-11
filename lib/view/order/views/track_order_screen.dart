import 'package:foodguru/app_values/export.dart';

class TrackOrderScreen extends GetView<TrackOrderController> {
  const TrackOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: TextFile.trackYourOrder.tr,
        onBackPress: () {
          controller.fromOrderFlow == true
              ? Get.offAllNamed(AppRoutes.mainScreen)
              : Get.back();
        },
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _mapView(),
          _orderView(),
        ],
      ),
    );
  }

  _mapView() {
    return Obx(
      () => GoogleMap(
        myLocationEnabled: false,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
        buildingsEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: controller.cameraPosition ??
            CameraPosition(
                target: LatLng(
                  30.365867854785712,
                  76.78859832786124,
                ),
                zoom: 15.5),
        // markers: controller.marker,
        onMapCreated: (cntrller) async {
          controller.googleMapsController.complete(cntrller);
          GoogleMapController mapController =
              await controller.googleMapsController.future;
        },
        polylines: controller.polyline,
        markers: controller.markers,
      ).marginOnly(bottom: Get.height * 0.38),
    );
  }

  _orderView() {
    return Container(
      height: Get.height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: margin_15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius_20),
              topRight: Radius.circular(radius_20))),
      child: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _trackingView(),
                controller.cancellationProgress.value == 1.0
                    ? Container()
                    : _cancellationTime(),
                _deliveryInAndOtp(),
                _ridersProfile(),
                _orderDetailsText(),
                _orderDetailList(),
                _divider(),
                _totalPrice(),
                _addTipTextField(),
                _suggestedAmounts(),
                controller.cancellationProgress.value == 1.0
                    ? Container()
                    : _cancelOrderButton(),
                SizedBox(
                  height: height_10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _trackingView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius_20),
                    child: LinearProgressIndicator(
                      minHeight: height_6,
                      color: ColorConstant.greenA70056,
                      value: 0.5,
                      backgroundColor: ColorConstant.gray300,
                    ).marginSymmetric(horizontal: margin_10))),
            Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius_20),
                    child: LinearProgressIndicator(
                      minHeight: height_6,
                      color: ColorConstant.greenA70056,
                      value: 0.0,
                      backgroundColor: ColorConstant.gray300,
                    ).marginSymmetric(horizontal: margin_10))),
          ],
        ),
        Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AssetImageWidget(
                    ImageConstant.imagesIcTrackCooking,
                    width: width_20,
                    height: width_20,
                  ),
                  AssetImageWidget(
                    ImageConstant.imagesIcOrderReady,
                    width: width_20,
                    height: width_20,
                    color: ColorConstant.gray600,
                  ),
                  AssetImageWidget(
                    ImageConstant.imagesIcTrackDelivered,
                    width: width_20,
                    height: width_20,
                    color: ColorConstant.gray600,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(TextFile.cooking.tr,
                      style: AppStyle.txtInterRegular12Black900),
                  Text(TextFile.orderReady.tr,
                      style: AppStyle.txtInterRegular12Black900),
                  Text(TextFile.delivery.tr,
                      style: AppStyle.txtInterRegular12Black900),
                ],
              ).marginOnly(top: margin_5),
            ],
          ).marginOnly(top: margin_18),
        )
      ],
    );
  }

  _cancellationTime() {
    return Row(children: [
      Expanded(
        child: Text(
          TextFile.cancellationTime.tr,
          style: AppStyle.txtInterRegular12Black900,
        ),
      ),
      Container(
          width: Get.width * 0.3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius_20),
            child: LinearProgressIndicator(
              value: controller.cancellationProgress.value,
              color: ColorConstant.red500,
              backgroundColor: ColorConstant.gray300,
            ),
          ))
    ]).marginOnly(top: margin_15);
  }

  _deliveryInAndOtp() {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: TextFile.deliveryIn.tr,
                  style: AppStyle.txtDMSansRegular14Black900,
                ),
                TextSpan(
                    text: ' 30 ${TextFile.mins.tr}',
                    style: AppStyle.txtDMSansMedium16),
              ],
            ),
          ),
        ),
        Row(
          children: '${controller.otp}'
              .split('')
              .map((e) => Container(
                    alignment: Alignment.center,
                    width: width_20,
                    padding: EdgeInsets.symmetric(vertical: margin_3),
                    margin: EdgeInsets.all(margin_2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius_2),
                      color: ColorConstant.gray80002,
                    ),
                    child: Text(
                      e,
                      style: AppStyle.txtDMSansBold18WhiteA700,
                    ),
                  ))
              .toList(),
        )
      ],
    ).marginOnly(top: margin_10);
  }

  _ridersProfile() {
    return Row(
      children: [
        AssetImageWidget(
          ImageConstant.iconsIcLoginImg,
          width: width_50,
          height: width_50,
          radiusAll: radius_50,
          boxFit: BoxFit.cover,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${controller.driverDetails.value?.firstName ?? ''} ${TextFile.isOnTheWay.tr}',
                style: AppStyle.txtDMSansRegular14Black900,
              ),
              RatingBarIndicator(
                itemSize: height_15,
                rating: 4,
                unratedColor: ColorConstant.gray300,
                itemBuilder: (context, index) {
                  return AssetImageWidget(ImageConstant.imagesIcStarSelected);
                },
              ).marginOnly(top: margin_3)
            ],
          ).marginOnly(left: margin_10),
        ),
        GetInkwell(
          onTap: () {
            Get.bottomSheet(Container(
              margin: EdgeInsets.all(margin_1),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: ColorConstant.greenA700, width: width_1pt5),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius_20),
                      topRight: Radius.circular(radius_20))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetInkwell(
                    onTap: () {},
                    child: Row(
                      children: [
                        AssetImageWidget(
                          ImageConstant.imagesIcCall,
                          width: width_18,
                          height: width_18,
                        ),
                        Text('Call or Message Restauraunt')
                            .marginOnly(left: margin_15)
                      ],
                    ).marginAll(margin_15),
                  ),
                  Divider(color: Colors.black, height: 0),
                  GetInkwell(
                    onTap: () {
                      launchUrl(Uri(
                          scheme: 'tel',
                          path: controller.driverDetails.value?.phone));
                    },
                    child: Row(
                      children: [
                        AssetImageWidget(
                          ImageConstant.imagesIcCall,
                          width: width_18,
                          height: width_18,
                        ),
                        Text('Call or Message ${controller.driverDetails.value?.firstName ?? ''}')
                            .marginOnly(left: margin_15)
                      ],
                    ).marginAll(margin_15),
                  ),
                  SizedBox(
                    height: height_10,
                  )
                ],
              ),
            ));
          },
          child: AssetImageWidget(
            ImageConstant.imagesIcCall,
            width: width_18,
            height: width_18,
          ).marginOnly(right: margin_20),
        ),
      ],
    ).marginOnly(top: margin_5);
  }

  _orderDetailsText() {
    return Text(
      TextFile.orderDetails.tr,
      style: AppStyle.txtDMSansBold18Black900,
    ).marginOnly(top: margin_10);
  }

  _orderDetailList() {
    return ListView.separated(
      itemCount: controller.orderModel.value?.orderItemList?.length ?? 0,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: Text(
                '${controller.orderModel.value?.orderItemList?[index].itemName ?? ''} X ${controller.orderModel.value?.orderItemList?[index].quantity ?? ''}',
                style: AppStyle.txtDMSansRegular14Black900,
              ),
            ),
            Text(
              'Rs. ${double.parse(((controller.orderModel.value?.orderItemList?[index].orderPrice ?? 0.0) * (controller.orderModel.value?.orderItemList?[index].quantity ?? 1)).toString()).toStringAsFixed(1)}',
              style: AppStyle.txtDMSansBold14Black900,
            )
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_2,
        );
      },
    ).marginOnly(top: margin_5);
  }

  _divider() {
    return Divider(
      color: ColorConstant.gray600,
      height: height_10,
    );
  }

  _totalPrice() {
    return Row(
      children: [
        Expanded(
            child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: TextFile.total.tr,
                style: AppStyle.txtDMSansBold18Black900,
              ),
              TextSpan(
                  text: ' (${TextFile.afterDiscount.tr} %)',
                  style: AppStyle.txtDMSansRegular14Black900),
            ],
          ),
        )),
        Text(
          'Rs. ${controller.orderModel.value?.grandTotal?.toStringAsFixed(1)}',
          style: AppStyle.txtDMSansBold14Black900,
        )
      ],
    );
  }

  _addTipTextField() {
    return Container(
      width: Get.width * 0.30,
      child: CustomTextFormField(
        controller: controller.amountController,
        onChanged: (value) {
          controller.amount.value = value;
        },
        hintText: '+ ${TextFile.addTip.tr}',
        contentPadding:
            EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_5),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstant.greenA700),
            borderRadius: BorderRadius.circular(radius_50)),
      ),
    ).marginOnly(top: margin_8);
  }

  _suggestedAmounts() {
    return Row(
      children: [
        _suggestedAmountChip(price: '200'),
        SizedBox(
          width: width_10,
        ),
        _suggestedAmountChip(price: '500'),
        SizedBox(
          width: width_10,
        ),
        _suggestedAmountChip(price: '1000'),
      ],
    ).marginOnly(top: margin_5);
  }

  _suggestedAmountChip({price}) {
    return GetInkwell(
      onTap: () {
        controller.amountController?.text = price;
        controller.amount.value = price;
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_5),
        decoration: BoxDecoration(
          color: controller.amount.value == price
              ? ColorConstant.greenA700.withOpacity(0.2)
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: controller.amount.value == price
                  ? Colors.transparent
                  : ColorConstant.black9001e,
              blurRadius: 10,
            )
          ],
          border: Border.all(
              width: width_0pt5,
              color: controller.amount.value == price
                  ? ColorConstant.greenA700
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(radius_50),
        ),
        child: Text('Rs. ${price ?? ''}',
            style: AppStyle.txtDMSansRegular16.copyWith(
                color: controller.amount.value == price
                    ? ColorConstant.greenA700
                    : ColorConstant.gray500)),
      ),
    );
  }

  _cancelOrderButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.cancelOrder.tr,
        margin: getMargin(top: margin_12),
        variant: ButtonVariant.OutlineBlack9003f_1,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          Get.toNamed(AppRoutes.cancelOrderScreen,
              arguments: {keyId: controller.orderModel.value?.id});
        });
  }
}
