import 'package:foodguru/app_values/export.dart';

class CancelOrderScreen extends GetView<CancelOrderController> {
  const CancelOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: TextFile.cancelOrder.tr),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _pleaseSelectTheReasonOfCancellation(),
            _cancelReasonList(),
            if (controller.cancelReasonList.isNotEmpty && controller.selectedReasonId.value ==
                controller.cancelReasonList.last.cancelReasonId) ...[
              _otherResonView(),
            ],
            _submitButton(),
          ]).marginAll(margin_15),
        ),
      ),
    );
  }

  _pleaseSelectTheReasonOfCancellation() {
    return Text(
      TextFile.pleaseSelectCancellationReason.tr,
      style: AppStyle.txtDMSansRegular14,
    );
  }

  _cancelReasonList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.cancelReasonList.length,
      itemBuilder: (context, index) {
        return Obx(
          () => GetInkwell(
            onTap: () {
              controller.selectedReasonId.value = controller.cancelReasonList[index].cancelReasonId!;
            },
            child: Row(
              children: [
                AssetImageWidget(
                  controller.selectedReasonId.value == controller.cancelReasonList[index].cancelReasonId
                      ? ImageConstant.imagesIcCancelSelected
                      : ImageConstant.imagesIcCancelUnselected,
                  height: height_20,
                  width: height_20,
                ),
                Text(
                  controller.cancelReasonList[index].title??'',
                  style: AppStyle.txtDMSansRegular14Black900,
                ).marginOnly(left: margin_10)
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_15,
        );
      },
    ).marginOnly(top: margin_10);
  }

  _otherReasonText() {
    return Text('Other Reason-', style: AppStyle.txtDMSansRegular14);
  }

  _otherResonView() {
    return CustomTextFormField(
      maxLines: 4,
      fillColor: ColorConstant.gray100,
      contentPadding: EdgeInsets.all(margin_10),
      hintText: TextFile.writeYourFeedback.tr,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius_5),
          borderSide: BorderSide(color: ColorConstant.gray300)),
    ).marginOnly(top: margin_10);
  }

  _submitButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.submit.tr,
        margin: getMargin(top: margin_40),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () {
          controller.cancelOrder();
        });
  }
}
