import 'package:foodguru/app_values/export.dart';

class BillScreen extends GetView<BillController> {
  const BillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => willPopScopeBackWidget(
        child: Scaffold(
          appBar: CustomAppBar(
            result: true,
            title: TextFile.bill.tr,
          ),
          body: controller.itemsList.isEmpty
              ? listEmptyWidget(
                  text: TextFile.bagIsEmpty.tr,
                  image: ImageConstant.imagesIcCartSelected)
              : SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          _yourOrdersView(),
                          _couponView(),
                          _addressView(),
                          _pointView(),
                          _securityGuardView(),
                          _subTotalText(),
                          _subTotalView(),
                          _proceedToPayButton(),
                        ],
                      ).marginAll(margin_15),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  _yourOrdersView() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray300,
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _yourOrdersText(),
          _itemsList(),
          _divider(),
          _addCookingInstructionButton(),
        ],
      ),
    );
  }

  _yourOrdersText() {
    return Text(
      TextFile.yourOrder.tr,
      style: AppStyle.txtDMSansBold18Black900,
    );
  }

  _itemsList() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.itemsList.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Obx(
          () => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        controller.itemsList[index].itemName ?? '',
                        style: AppStyle.txtDMSansBold15Black90001,
                      ),
                      AssetImageWidget(
                        controller.itemsList[index].isVeg == typeTrue
                            ? ImageConstant.imagesIcVeg
                            : ImageConstant.imagesIcNonVeg,
                        width: width_15,
                      ).marginOnly(left: margin_5)
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        TextFile.addCustomization.tr,
                        style: AppStyle.txtDMSansRegular12Black900,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: ColorConstant.greenA700,
                      )
                    ],
                  ).marginOnly(top: margin_2)
                ],
              ),
              AddRemoveItemWidget(
                onAddTap: () {
                  if ((controller.itemsList[index].quantity?.value ?? 0) < 99) {
                    controller.itemsList[index].quantity?.value++;
                    CartNetwork.updateQuantityOfCart(
                      itemId: controller.itemsList[index].itemId,
                      restaurantId: controller.itemsList[index].restaurantId,
                      quantity: controller.itemsList[index].quantity?.value,
                      onSuccess: (value) {
                        controller.findingTotal();
                      },
                    );
                  }
                },
                onRemoveTap: () async {
                  if ((controller.itemsList[index].quantity?.value ?? 0) > 1) {
                    controller.itemsList[index].quantity?.value--;
                    CartNetwork.updateQuantityOfCart(
                        itemId: controller.itemsList[index].itemId,
                        restaurantId: controller.itemsList[index].restaurantId,
                        quantity: controller.itemsList[index].quantity?.value);
                  } else if (controller.itemsList[index].quantity?.value == 1) {
                    await CartNetwork.removeFromCart(
                            itemId: controller.itemsList[index].itemId)
                        .then((value) {
                      controller.itemsList[index].quantity?.value = 0;
                      controller.itemsList.removeAt(index);
                    });
                    controller.findingTotal();
                  }
                },
                quantity: controller.itemsList[index].quantity?.value,
              )
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_15,
        );
      },
    ).marginOnly(top: margin_15);
  }

  _addCookingInstructionButton() {
    return GetInkwell(
      onTap: () {
        Get.bottomSheet(AddInstructionsBottomSheet(),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius_10),
                    topRight: Radius.circular(radius_10))));
        controller.cookingInstructionNode?.requestFocus();
      },
      child: controller.cookingInstructions.value == null ||
              controller.cookingInstructions.value == ''
          ? _addCookingInstructionText()
          : _cookingInstructionValue(),
    );
  }

  _divider() {
    return Divider(
      color: ColorConstant.gray800,
    );
  }

  _couponView() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(margin_10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray300,
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.couponModel.value != null) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${TextFile.couponCode.tr} - ${controller.couponModel.value?.couponName} ${TextFile.applied.tr}',
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: AppStyle.txtDMSansRegular12
                        .copyWith(color: ColorConstant.yellowFF9B26),
                  ),
                ),
                _crossIcon(
                  icon: Icons.edit_outlined,
                  onTap: () {
                    controller.couponModel.value = null;
                    controller.findingTotal();
                  },
                ),
              ],
            ),
            _divider(),
          ],
          GetInkwell(
            onTap: () async {
              List<int> couponId = [];
              List<String> idStrings =
                  controller.itemsList.first.couponId.split(',');
              couponId.addAll(idStrings.map((idString) => int.parse(idString)));
              debugPrint(couponId.toString());
              var result = await Get.toNamed(AppRoutes.couponScreen,
                  arguments: {
                    keyItemTotal: controller.itemTotal.value,
                    keyIdList: couponId
                  });
              if (result is CouponModel) {
                controller.couponModel.value = result;
                controller.findingTotal();
                showToast(TextFile.couponAppliedSuccessfully.tr);
              }
            },
            child: _selectView(
                    image: ImageConstant.imagesIcCoupon,
                    text: TextFile.selectCoupon.tr)
                .marginOnly(top: margin_2),
          )
        ],
      ),
    ).marginOnly(top: margin_15);
  }

  Widget _selectView({String? image, String? text}) {
    return Row(
      children: [
        AssetImageWidget(
          image ?? '',
          width: width_20,
        ),
        Expanded(
            child: Text(
          text ?? '',
          style: AppStyle.txtDMSansMedium16,
        ).marginOnly(left: margin_10)),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: height_10,
          color: ColorConstant.greenA700,
        )
      ],
    );
  }

  _addressView() {
    return GetInkwell(
      onTap: () async {
        var result = await Get.toNamed(AppRoutes.addressListScreen);
        if (result is AddressModel) {
          controller.addressModel.value = result;
        }
      },
      child: Container(
        padding: EdgeInsets.all(margin_10),
        width: Get.width,
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
        child: controller.addressModel.value != null
            ? Row(
                children: [
                  AssetImageWidget(
                    controller.addressModel.value?.addressType == typeHome
                        ? ImageConstant.imagesIcAddressHome
                        : ImageConstant.imagesIcAddressOffice,
                    width: width_20,
                    height: width_20,
                  ),
                  Expanded(
                      child: Text(
                    controller.addressModel.value?.address ?? '',
                    style: AppStyle.txtInterRegular16,
                  ).marginOnly(left: margin_10)),
                ],
              )
            : _selectView(
                image: ImageConstant.imagesIcAddressHome,
                text: TextFile.selectAddress.tr),
      ).marginOnly(top: margin_15),
    );
  }

  _pointView() {

    return Container(
      padding: EdgeInsets.all(margin_3),
      width: Get.width,
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
      child: Row(
              children: [
                Checkbox(
                 activeColor: ColorConstant.greenA700,
                    value: controller.isChecked.value ,
                    onChanged: (value) {

                      if (controller.pointValue.value > 0) {
                        controller.isChecked.value = !controller.isChecked.value;
                        controller.update();
                        print(controller.grandTotal);
                        if(value == true) {
                          controller.grandTotal.value = controller.grandTotal.value - controller.pointValue.value;
                        } else {
                          controller.grandTotal.value = controller.grandTotal.value + controller.pointValue.value;
                        }
                      }
                    }),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                   Text(
                     ' ${controller.pointValue.value ?? 0} points ',
                     style: AppStyle.txtDMSansMedium14,
                   ).marginOnly(left: margin_10),
                   Text(
                     'Use Point Balance',
                     style: AppStyle.txtDMSansMedium16,
                   ).marginOnly(left: margin_10),
                 ],)

              ],
            )

    ).marginOnly(top: margin_15);
  }

  _securityGuardView() {
    return Container(
      padding: EdgeInsets.all(margin_10),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray300,
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: _selectView(
          image: ImageConstant.imagesIcSecurity,
          text: TextFile.addSecurityGuard.tr),
    ).marginOnly(top: margin_15);
  }

  _subTotalText() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        TextFile.subTotal.tr,
        style: AppStyle.txtDMSansBold18Black900,
      ).marginOnly(top: margin_5),
    );
  }

  _subTotalView() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(margin_10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.gray300,
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          ListView.separated(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _titleAndValue(
                    title: controller.itemsList[index].itemName ?? '',
                    value:
                        'Rs. ${double.parse(controller.itemsList[index].discountedPrice.toString()) * controller.itemsList[index].quantity!.value}');
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: height_10,
                );
              },
              itemCount: controller.itemsList.length),
          _divider(),
          _titleAndValue(
              title: TextFile.itemTotal.tr,
              value: 'Rs. ${controller.itemTotal.toStringAsFixed(1)}',
              isTitleBold: false),
          _titleAndValue(
                  title: TextFile.gst.tr,
                  value: 'Rs. ${controller.gst.toStringAsFixed(1)}',
                  isTitleBold: false)
              .marginOnly(top: margin_5),
          controller.couponModel.value != null &&
                  controller.couponModel.value?.couponId != 4
              ? _titleAndValue(
                      title: '${TextFile.discount.tr}%',
                      value:
                          '-Rs. ${controller.discount.value.toStringAsFixed(1)}',
                      isGreen: true,
                      isTitleBold: false)
                  .marginOnly(top: margin_5)
              : Container(),
          controller.orderType.value == keyOrderTypeTakeaway
              ? Container()
              : _titleAndValue(
                      title: TextFile.deliveryCharges.tr,
                      value:
                          'Rs. ${controller.deliveryCharges.value.toStringAsFixed(1)}',
                      isTitleBold: false)
                  .marginOnly(top: margin_5),
          _divider(),
          _titleAndValue(
            title: TextFile.grandTotal.tr,
            value: 'Rs. ${controller.grandTotal.toStringAsFixed(1)}',
          ),
        ],
      ),
    ).marginOnly(top: margin_5);
  }

  Widget _titleAndValue(
      {String? title,
      String? value,
      bool? isTitleBold = true,
      bool? isGreen = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title ?? '',
            style: isTitleBold == true
                ? AppStyle.txtDMSansBold15
                : AppStyle.txtDMSansRegular14Black900.copyWith(
                    color: isGreen == true
                        ? ColorConstant.greenA700
                        : Colors.black),
          ),
        ),
        Text(
          value ?? '',
          style: AppStyle.txtDMSansBold15.copyWith(
              color: isGreen == true ? ColorConstant.greenA700 : Colors.black),
        ),
      ],
    );
  }

  _proceedToPayButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.proceedToPay.tr,
        margin: getMargin(top: margin_20, bottom: margin_10),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          controller.navigateToPaymentScreen();
        });
  }

  _cookingInstructionValue() {
    return Row(
      children: [
        Expanded(
          child: Text(
              '${TextFile.cookingInstructions.tr}: ${controller.cookingInstructions.value ?? ''}',
              textAlign: TextAlign.start,
              maxLines: 2,
              style: AppStyle.txtDMSansRegular12GreenA700),
        ),
        _crossIcon(
          onTap: () {
            controller.cookingInstructionController?.clear();
            controller.cookingInstructions.value = null;
          },
        ),
      ],
    );
  }

  _addCookingInstructionText() {
    return Row(
      children: [
        Text(TextFile.addCookingInstructionsIfAny.tr,
            style: AppStyle.txtDMSansRegular12GreenA700),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: height_10,
          color: ColorConstant.greenA700,
        )
      ],
    );
  }

  _crossIcon({IconData? icon, Function()? onTap}) {
    return GetInkwell(
      onTap: onTap ?? () {},
      child: Icon(
        icon ?? Icons.close,
        size: height_10,
        color: Colors.red,
      ),
    );
  }
}
