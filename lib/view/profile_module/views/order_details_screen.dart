import 'package:foodguru/app_values/export.dart';

class OrderDetailsScreen extends GetView<OrderDetailsController> {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          Scaffold(
            appBar: CustomAppBar(title: TextFile.orderDetails.tr),
            body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _orderDetailsContainer(),
                    _deliveryAddressText(),
                    _addressView(),
                    if(controller.orderModel.value?.orderType==keyOrderTypeDineIn)...[
                      _dineInDetailsText(),
                      _tableNumber(),
                      _numberOfPersons(),
                    ],
                    _itemsText(),
                    _itemsList(),
                  ],
                ).marginAll(margin_15)),
          ),
    );
  }

  Widget _orderDetailsContainer() {
    return Container(
      padding: EdgeInsets.all(margin_10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius_5),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9001e,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Container(
              padding:
              EdgeInsets.symmetric(horizontal: margin_12, vertical: margin_5),
              decoration: BoxDecoration(
                color: ColorConstant.gray60026,
                border: Border.all(width: 0.25, color: ColorConstant.gray600),
                borderRadius: BorderRadius.circular(radius_20),
              ),
              child: Text(
                  '${TextFile.orderNo.tr} ${controller.orderModel.value?.id}'),
            ),
            Expanded(child: Text(
              '${TextFile.orderType.tr} ${controller.orderModel.value
                  ?.orderType == keyOrderTypeDelivery
                  ? TextFile.delivery.tr
                  : controller.orderModel.value?.orderType ==
                  keyOrderTypeTakeaway ?TextFile.takeaway.tr:TextFile.dineIn.tr}', textAlign: TextAlign.right,))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${TextFile.orderPlacedOn.tr} ${formatDateWithSuffix(
                        formattedDateString: controller.orderModel.value
                            ?.createdOn)}',
                    style: AppStyle.txtDMSansRegular12Gray60001,
                  ),
                  Text(
                    '${TextFile.forAmount.tr} Rs. ${controller.orderModel.value
                        ?.grandTotal?.toStringAsFixed(1)}',
                    style: AppStyle.txtDMSansRegular12Black900,
                  ).marginOnly(top: margin_1),
                ],
              ),
            ),
            controller.orderModel.value?.orderType!=keyOrderTypeDelivery?Container():controller.orderModel.value?.stateId == keyOrderCancel
                ? Text(TextFile.cancelled.tr,
                style: AppStyle.txtDMSansRegular12Black900
                    .copyWith(color: ColorConstant.red500))
                : GetInkwell(
              onTap: () {
                if (controller.isCompleted.value == false) {
                  Get.toNamed(AppRoutes.trackOrderScreen,
                      arguments: {keyId: controller.id.value});
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: width_80,
                padding: EdgeInsets.symmetric(vertical: margin_5),
                decoration: BoxDecoration(
                  color: controller.isCompleted.value == true
                      ? ColorConstant.greenA700
                      : ColorConstant.yellowFF9B26,
                  borderRadius: BorderRadius.circular(radius_25),
                ),
                child: Text(
                    controller.isCompleted.value == true
                        ? TextFile.reorder.tr
                        : TextFile.track.tr,
                    style: AppStyle.txtDMSansRegular12WhiteA700),
              ),
            )
          ],
        ).marginOnly(top: margin_8),
      ]),
    );
  }

  _deliveryAddressText() {
    return Text(
      controller.orderModel.value?.orderType == keyOrderTypeDelivery
          ? '${TextFile.deliveryAddress.tr}:'
          : '${TextFile.restaurantAddress.tr}:',
      style: AppStyle.txtDMSansRegular12Gray60001,
    ).marginOnly(top: margin_25);
  }

  _itemsText() {
    return Text(
      '${TextFile.items.tr}:',
      style: AppStyle.txtDMSansRegular12Gray60001,
    ).marginOnly(top: margin_25);
  }
  _dineInDetailsText() {
    return Text(
      '${TextFile.dineInDetails.tr}:',
      style: AppStyle.txtDMSansRegular12Gray60001,
    ).marginOnly(top: margin_25);
  }

  _addressView() {
    return controller.orderModel.value?.orderType == keyOrderTypeDelivery
        ? Row(
      children: [
        AssetImageWidget(
          ImageConstant.imagesIcAddressHome,
          width: width_25,
        ),
        Expanded(
            child: Text(
              '${controller.orderModel.value?.address ?? ''}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.txtDMSansRegular14Black900,
            ).marginOnly(left: margin_10))
      ],
    ).marginOnly(top: margin_10)
        : Row(
      children: [
        Icon(Icons.restaurant, size: height_20, color: ColorConstant.greenA700),
        Expanded(
            child: Text(
              '${controller.orderModel.value?.orderItemList?.first
                  .restaurantName ?? ''}, ${controller.orderModel.value
                  ?.orderItemList?.first.outlet ?? ''}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.txtDMSansRegular14Black900,
            ).marginOnly(left: margin_10)),
        _roundedButtons(
          title: TextFile.direction.tr,
          imageUrl: ImageConstant.imagesIcDirections,
          onTap: () {
            MapsLauncher.launchCoordinates(
              controller.orderModel.value?.outletLatitude!,
              controller.orderModel.value?.outletLongitude!,);
          },
        ),
      ],
    ).marginOnly(top: margin_10);
  }

  _itemsList() {
    return ListView.separated(
      itemCount: controller.orderModel.value?.orderItemList?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var data = controller.orderModel.value?.orderItemList?[index];
        return GetInkwell(
          onTap: () {
            Get.toNamed(AppRoutes.itemDetailsScreen,
                arguments: {keyId: data?.itemId});
          },
          child: OrderItemWidget(
            itemModel: data,
            discountedPrice: data?.discountedPrice,
            onFavouritePress: () {
              controller.orderModel.refresh();
            },
            isVeg: data?.isVeg,
            // isFavourite: data?.isFavourite.value,
            // onFavouritePress: () {
            //   data?.isFavourite.value = !data.isFavourite.value;
            // },
            description: data?.description,
            distance: 400,

            restaurantName: data?.restaurantName,
            imageUrl: data?.images?.first.imageUrl,
            dishName: data?.itemName,
            quantity: data?.quantity,
            // size: index == 0 ? 'Small' : null,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: height_10,
        );
      },
    ).marginOnly(top: margin_15);
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


  _tableNumber() {
    return Text(
      '${TextFile.tableNumber.tr} - ${controller.orderModel.value?.tableId}',
      style: AppStyle.txtDMSansRegular14Black900,
    ).marginOnly(top: margin_4);
  }

  _numberOfPersons() {
    return Text(
      '${TextFile.numberOfPerson.tr} - ${controller.orderModel.value?.numberOfPersons ?? ''}',
      style: AppStyle.txtDMSansRegular14Black900,
    ).marginOnly(top: margin_4);
  }




}
