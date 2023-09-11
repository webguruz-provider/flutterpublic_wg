import 'package:foodguru/app_values/export.dart';

class AddMoneyScreen extends GetView<AddMoneyController> {
  const AddMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: TextFile.addMoneyToWallet.tr),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _enterAmountText(),
              _amountTextFormField(),
              _suggestedAmounts(),
              _addMoneyButton()
            ],
          ).marginAll(margin_15),
        ),
      ),
    );
  }

  _amountTextFormField() {
    return CustomTextFormField(
      hintText: 'e.g 200',
      controller: controller.amountController,
      focusNode: controller.amountNode,
      contentPadding: EdgeInsets.all(margin_15),
      validator: (value) {
        if (value == null || value == '') {
          return TextFile.amountEmptyValidation.tr;
        } else if (value.startsWith('0')) {
          return TextFile.enterValidAmount.tr;
        }
      },
      keyBoardInputType: TextInputType.name,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    ).marginOnly(top: margin_12);
  }

  _suggestedAmountChip({price}) {
    return Expanded(
      child: GetInkwell(
        onTap: () {
          controller.amountController?.text = price;
        },
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: margin_20, vertical: margin_10),
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
      ),
    );
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
    ).marginOnly(top: margin_15);
  }

  _enterAmountText() {
    return Text(
      TextFile.enterAmountToBeAdded.tr,
      style: AppStyle.txtDMSansRegular14Gray50004,
    );
  }

  _addMoneyButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.addMoney.tr,
        margin: getMargin(top: margin_30),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          if(controller.fromWallet==true){
            Get.offNamed(AppRoutes.paymentScreen,arguments: {keyAmountToAdd:controller.amount.value});
          }else{
            Get.back(result: controller.amount.value);
          }

        });
  }
}
