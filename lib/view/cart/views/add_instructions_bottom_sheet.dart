import 'package:foodguru/app_values/export.dart';

class AddInstructionsBottomSheet extends GetView<BillController> {
  const AddInstructionsBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          TextFile.addCookingInstructions.tr,
          style: AppStyle.txtDMSansBold16Black90001,
        ),
        CustomTextFormField(
          maxLines: 3,
          maxLength: 100,
          controller: controller.cookingInstructionController,
          focusNode: controller.cookingInstructionNode,
          shape: TextFormFieldShape.RoundedBorder5,
          hintText: TextFile.enterInstructions.tr,
          contentPadding: EdgeInsets.all(margin_10),
        ).marginOnly(top: margin_15),
        Text(TextFile.theRestaurantWillTry.tr,
                style: AppStyle.txtDMSansRegular12.copyWith(color: Colors.red))
            .marginOnly(top: margin_10),
        CustomButton(
            height: 45,
            width: Get.width,
            shape: ButtonShape.RoundedBorder22,
            text: TextFile.submit.tr,
            margin: getMargin(top: margin_15),
            variant: ButtonVariant.OutlineBlack9003f,
            fontStyle: ButtonFontStyle.InterSemiBold18,
            onTap: () {
              controller.cookingInstructions.value =
                  controller.cookingInstructionController?.text.trim();
              Get.back();
            }),
        SizedBox(
          height: height_20,
        )
      ],
    ).marginAll(margin_15);
  }
}
