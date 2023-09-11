import 'package:foodguru/app_values/export.dart';

class AddCardScreen extends GetView<AddCardController> {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(title: TextFile.payment.tr),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _addCardText(),
            _form(),
            _saveCardCheckBox(),
            _addCardButton(),
          ]).marginAll(margin_15),
        ),
      ),
    );
  }

  _addCardText() {
    return Text(TextFile.addCard.tr,
        style: AppStyle.txtDMSansRegular14Black900);
  }

  _form() {
    return Form(
        child: Column(
      children: [
        _cardNumberTextField(),
        _cardHolderNameTextField(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _expiryTextField()),
            SizedBox(
              width: width_10,
            ),
            Expanded(child: _cvvTextField()),
          ],
        ).marginOnly(top: margin_10)
      ],
    ).marginOnly(top: margin_15));
  }

  Widget _cardNumberTextField() {
    return Obx(
      () => CustomTextFormField(
        hintText: TextFile.cardNumber.tr,
        controller: controller.cardNumberController,
        focusNode: controller.cardNumberNode,
        onFieldSubmitted: (value) {
          controller.cardHolderNameNode?.requestFocus();
        },
        contentPadding: EdgeInsets.all(margin_15),
        maxLength: 19,
        validator: (value) {
          return CardUtils.validateCardNum(value);
        },
        suffix: AssetImageWidget(
          CardUtils.getCardIcon(controller.cardType.value),
          width: width_20,
          height: height_10,
          boxFit: BoxFit.contain,
        ).marginOnly(right: margin_10),
        keyBoardInputType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CardNumberInputFormatter(),
        ],
      ),
    );
  }

  Widget _cardHolderNameTextField() {
    return CustomTextFormField(
      hintText: TextFile.enterName.tr,
      controller: controller.cardHolderNameController,
      focusNode: controller.cardHolderNameNode,
      onFieldSubmitted: (value) {
        controller.expiryNode?.requestFocus();
      },
      contentPadding: EdgeInsets.all(margin_15),
      validator: (value) {
        if (value == null || value == '') {
          return TextFile.nameEmptyValidation.tr;
        }
      },
      keyBoardInputType: TextInputType.name,
    ).marginOnly(top: margin_10);
  }

  Widget _expiryTextField() {
    return CustomTextFormField(
      hintText: TextFile.validThru.tr,
      controller: controller.expiryController,
      focusNode: controller.expiryNode,
      onFieldSubmitted: (value) {
        controller.cvvNode?.requestFocus();
      },
      contentPadding: EdgeInsets.all(margin_15),
      keyBoardInputType: TextInputType.number,
      validator: (value) {
        return CardUtils.validateDate(value);
      },
      maxLength: 5,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CardMonthInputFormatter(),
      ],
    );
  }

  Widget _cvvTextField() {
    return CustomTextFormField(
      hintText: TextFile.cvv.tr,
      controller: controller.cvvController,
      focusNode: controller.cvvNode,
      maxLength: 4,
      validator: (value) {
        return CardUtils.validateCVV(value);
      },
      onFieldSubmitted: (value) {},
      contentPadding: EdgeInsets.all(margin_15),
      keyBoardInputType: TextInputType.number,
    );
  }

  _saveCardCheckBox() {
    return Row(
      children: [
        Transform.scale(
          scale: 1.4,
          child: Checkbox(
            value: controller.isCardSave.value,
            onChanged: (value) {
              controller.isCardSave.value = value!;
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius_2)),
            side: BorderSide(color: ColorConstant.gray600, width: width_0pt5),
            activeColor: ColorConstant.greenA700,
          ),
        ),
        Expanded(
          child: Text(
            TextFile.cardSavedMessage.tr,
            maxLines: 2,
            style: AppStyle.txtInterRegular12,
          ).marginOnly(left: margin_10),
        )
      ],
    ).marginOnly(top: margin_10);
  }

  _addCardButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.addCard.tr,
        margin: getMargin(top: margin_25),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          controller.onAddCard();
        });
  }
}
