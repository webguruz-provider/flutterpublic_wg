import 'package:foodguru/app_values/export.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: TextFile.payment.tr),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (controller.amountToAdd.value == null) ...[
              _headingWidget(title: TextFile.myWallet.tr,  onTap: () async {
                var result = await Get.toNamed(AppRoutes.addMoneyScreen);
                if (result is String) {
                  controller.amountToAdd.value = result;
                }
              },suffixText: '+${TextFile.addMoney.tr}'),
              _myWalletView('w1'),
            ],
            _headingWidget(title: TextFile.recommended.tr).marginOnly(
                top: controller.amountToAdd.value == null
                    ? margin_20
                    : margin_0),
            _recommendedList(),
            _headingWidget(
              title: TextFile.creditDebitCards.tr,
              onTap: () async {
                var result = await Get.toNamed(AppRoutes.addCardScreen);
                if (result is CardModel) {
                  controller.creditCardList.add(result);
                  controller.creditCardList.refresh();
                }
              },
            ).marginOnly(top: margin_20),
            _cardsList(),
            _headingWidget(title: TextFile.upi.tr).marginOnly(top: margin_20),
            _upiList(),
            if (controller.amountToAdd.value == null) ...[
              _headingWidget(title: TextFile.other.tr)
                  .marginOnly(top: margin_20),
              _otherList(),
            ],
            _proceedButton(),
          ]).marginAll(margin_15),
        ),
      ),
    );
  }

  Widget _headingWidget({String? title, Function()? onTap,suffixText}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title ?? '',
            style: AppStyle.txtDMSansRegular14Gray50004,
          ),
        ),
        onTap == null
            ? Container(
                height: 0,
                width: 0,
              )
            : GetInkwell(
                onTap: onTap,
                child: Text(suffixText??'+ ${TextFile.addCard.tr}',
                    style: AppStyle.txtDMSansMedium12.copyWith(
                        color: ColorConstant.greenA700,
                        decoration: TextDecoration.underline)),
              )
      ],
    );
  }

  _myWalletView(id) {
    return GetInkwell(
      onTap: () {
        if((controller.orderDataSendModel?.grandTotal??0)<controller.walletValue.value){
          controller.selectedPaymentType.value = id;
          controller.orderDataSendModel?.paymentId = id;
        }else{
          showToast('Please Add Money to choose wallet as Payment Method');
        }

      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: margin_15, horizontal: margin_15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius_50),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1E000000),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _walletAmount(),
            AssetImageWidget(
              controller.selectedPaymentType.value == id
                  ? ImageConstant.imagesIcSelectedAddress
                  : ImageConstant.imagesIcUnselectedAddress,
              width: width_30,
            ),
          ],
        ),
      ).marginOnly(top: margin_10),
    );
  }

  _walletAmount() {
    return Expanded(
      child: Text(
        'Rs. ${controller.walletValue.value.toString()}',
        maxLines: 1,
        style: AppStyle.txtDMSansBold22.copyWith(color: Colors.black),
      ),
    );
  }

  _addMoneyButton() {
    return GetInkwell(

      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_5),
        decoration: BoxDecoration(
          color: ColorConstant.greenA700.withOpacity(0.2),
          border: Border.all(width: 0.25, color: ColorConstant.greenA700),
          borderRadius: BorderRadius.circular(radius_25),
        ),
        child: Text(
          TextFile.addMoney.tr,
          style: AppStyle.txtDMSansRegular12GreenA700,
        ),
      ),
    );
  }

  _recommendedList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: margin_10),
      shrinkWrap: true,
      itemCount: controller.recommendedList.length,
      itemBuilder: (context, index) {
        var data = controller.recommendedList[index];
        return _paymentItemTypeView(
            image: data.icon, title: data.title, id: data.id);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_10,
        );
      },
    );
  }

  _cardsList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: margin_10),
      shrinkWrap: true,
      itemCount: controller.creditCardList.length,
      itemBuilder: (context, index) {
        var data = controller.creditCardList[index];
        return _paymentItemTypeCardView(
            id: '$index',
            image: CardUtils.getCardIcon(data.cardType),
            title: 'XXXX XXXX XXXX ${data.cardNumber?.split(' ').last}',
            cardType: '${CardUtils.getCardName(data.cardType)} Card');
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_10,
        );
      },
    );
  }

  _upiList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: margin_10),
      shrinkWrap: true,
      itemCount: controller.upiList.length,
      itemBuilder: (context, index) {
        var data = controller.upiList[index];
        return _paymentItemTypeView(
            image: data.icon, title: data.title, id: data.id);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_10,
        );
      },
    );
  }

  _otherList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: margin_10),
      shrinkWrap: true,
      itemCount: controller.otherList.length,
      itemBuilder: (context, index) {
        var data = controller.otherList[index];
        return _paymentItemTypeView(
            image: data.icon, title: data.title, id: data.id);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_10,
        );
      },
    );
  }

  Widget _paymentItemTypeView({String? image, String? title, String? id}) {
    return Obx(
      () => GetInkwell(
        onTap: () {
          controller.selectedPaymentType.value = id;
          debugPrint(controller.selectedPaymentType.value.toString());
          controller.orderDataSendModel?.paymentId = id;
        },
        child: Container(
          padding: EdgeInsets.all(margin_5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius_50),
            boxShadow: [
              BoxShadow(
                color: ColorConstant.gray300,
                blurRadius: radius_10,
              )
            ],
          ),
          child: Row(children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius_50),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstant.black9000f,
                        blurRadius: 2,
                      )
                    ]),
                child: AssetImageWidget(
                  image ?? ImageConstant.imagesIcGooglePay,
                  radiusAll: radius_50,
                  width: width_50,
                )),
            Expanded(
              child: Text(title ?? '', style: AppStyle.txtDMSansRegular16)
                  .marginOnly(left: margin_10),
            ),
            AssetImageWidget(
              controller.selectedPaymentType.value == id
                  ? ImageConstant.imagesIcSelectedAddress
                  : ImageConstant.imagesIcUnselectedAddress,
              width: width_30,
            ).marginOnly(right: margin_5)
          ]),
        ),
      ),
    );
  }

  Widget _paymentItemTypeCardView(
      {String? image, String? title, String? cardType, String? id}) {
    return Obx(
      () => GetInkwell(
        onTap: () {
          controller.selectedPaymentType.value = id;
        },
        child: Container(
          padding: EdgeInsets.all(margin_5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius_50),
            boxShadow: [
              BoxShadow(
                color: ColorConstant.gray300,
                blurRadius: radius_10,
              )
            ],
          ),
          child: Row(children: [
            Container(
                width: width_50,
                height: width_50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius_50),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstant.black9000f,
                        blurRadius: 2,
                      )
                    ]),
                child: Container(
                  padding: EdgeInsets.all(margin_10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.black9000f,
                          blurRadius: 2,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radius_50)),
                  child: AssetImageWidget(
                    image ?? '',
                    boxFit: BoxFit.contain,
                    width: width_50,
                  ),
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardType == null
                      ? Container()
                      : Text(
                          cardType,
                          style: AppStyle.txtDMSansRegular12,
                        ),
                  Text(title ?? '', style: AppStyle.txtDMSansRegular16),
                ],
              ).marginOnly(left: margin_10),
            ),
            AssetImageWidget(
              controller.selectedPaymentType.value == id
                  ? ImageConstant.imagesIcSelectedAddress
                  : ImageConstant.imagesIcUnselectedAddress,
              width: width_30,
            ).marginOnly(right: margin_5)
          ]),
        ),
      ),
    );
  }

  _proceedButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: controller.amountToAdd.value == null
            ? TextFile.proceed.tr
            : TextFile.pay.tr,
        margin: getMargin(top: margin_25, bottom: margin_20),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          if (controller.selectedPaymentType.value != null) {
            if(controller.amountToAdd.value!=null){
              controller.walletUpdate();
            }else{
              controller.placeOrder();
            }

          }
        });
  }
}
