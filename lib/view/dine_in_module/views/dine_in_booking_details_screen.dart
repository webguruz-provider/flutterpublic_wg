import 'package:flutter_animate/flutter_animate.dart';
import 'package:foodguru/app_values/export.dart';

class DineInBookingDetailScreen
    extends GetView<DineInBookingDetailsController> {
  const DineInBookingDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.black900,
      appBar: CustomAppBar(
        iosStatusBarBrightness: Brightness.dark,
        title: 'Domino\'s',
        titleColor: ColorConstant.whiteA700,
        iconColor: ColorConstant.whiteA700,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bookingTextDetailsText(),
                _bookingDetailsView(),
              ],
            ).marginAll(margin_15)),
          ),
          _bookTableButton(),
        ],
      ),
    );
  }

  _bookingTextDetailsText() {
    return Text(TextFile.bookingDetails.tr,
        style: AppStyle.txtDMSansBold18WhiteA700);
  }

  _restaurantNameAndAddress() {
    return Text(
      '${controller.itemsList.first.restaurantName ?? ''}, ${controller.itemsList.first.outlet}',
      style: AppStyle.txtDMSansRegular16WhiteA700,
    );
  }

  _tableNumber() {
    return Text(
      '${TextFile.tableNumber.tr} - ${controller.orderDataSendModel.value?.tableId}',
      style: AppStyle.txtDMSansRegular16WhiteA700,
    ).marginOnly(top: margin_4);
  }

  _numberOfPersons() {
    return Text(
      '${TextFile.numberOfPerson.tr} - ${controller.orderDataSendModel.value?.numberOfPersons ?? ''}',
      style: AppStyle.txtDMSansRegular16WhiteA700,
    ).marginOnly(top: margin_4);
  }

  _orderDetailsText() {
    return Text(
      TextFile.orderDetails.tr,
      style: AppStyle.txtDMSansBold18WhiteA700,
    ).marginOnly(top: margin_12);
  }

  _orderList() {
    return ListView.separated(
      itemCount: controller.itemsList.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
                child: Text(
              controller.itemsList[index].itemName,
              style: AppStyle.txtDMSansRegular16WhiteA700,
            )),
            Text(
              'Rs. ${controller.itemsList[index].discountedPrice}',
              style: AppStyle.txtDMSansRegular16WhiteA700,
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_5,
        );
      },
    ).marginOnly(top: margin_12);
  }

  _totalAmount() {
    return Row(
      children: [
        Expanded(
            child: Text(
          TextFile.total.tr,
          style: AppStyle.txtDMSansRegular16GreenA700,
        )),
        Text(
          'Rs. ${controller.orderDataSendModel.value?.grandTotal}',
          style: AppStyle.txtDMSansRegular16GreenA700,
        ),
      ],
    );
  }

  _divider() {
    return Divider(
      color: ColorConstant.gray300,
      height: height_15,
    );
  }

  _bookingDetailsView() {
    return Container(
      padding: EdgeInsets.all(margin_15),
      decoration: BoxDecoration(
        color: ColorConstant.blueGray90001,
        borderRadius: BorderRadius.circular(radius_20),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _restaurantNameAndAddress(),
        _tableNumber(),
        _numberOfPersons(),
        _orderDetailsText(),
        _orderList(),
        _divider(),
        _totalAmount(),
      ]),
    ).marginOnly(top: margin_20);
  }

  _bookTableButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.bookTable.tr,
        margin: getMargin(bottom: margin_45, left: margin_15, right: margin_15),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () async {
          controller.addDineinBooking();
        }).animate().fadeIn(curve: Curves.easeIn);
  }
}
