import 'package:foodguru/app_values/export.dart';

class FeedbackScreen extends GetView<FeedbackController> {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBackPress: () {
          Get.back();
        },
        title: TextFile.feedback.tr,
      ),
      body: SingleChildScrollView(
          child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tabBar(),
            if (controller.selectedOrder.value == null) ...[
              _selectAnOrderForFeedback(),
              _orderList(),
            ],
            if (controller.selectedOrder.value != null) ...[
              _selectRatingText(),
              _menuItemList(),
              _selectAFeedbackText(),
              _feedbackList(),
              _feedBackTextField(),
              _submitFeedbackButton(),
            ],
          ],
        ).marginAll(margin_15),
      )),
    );
  }

  _tabBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AssetImageWidget(
              ImageConstant.imagesIcCancelSelected,
              width: width_20,
            ),
            SizedBox(
                width: Get.width * 0.4,
                child: LinearProgressIndicator(
                    color: ColorConstant.greenA700,
                    backgroundColor: ColorConstant.gray300,
                    value: controller.selectedOrder.value != null ? 1.0 : 0.0)),
            AssetImageWidget(
              controller.selectedOrder.value != null
                  ? ImageConstant.imagesIcCancelSelected
                  : ImageConstant.imagesIcCancelUnselected,
              width: width_20,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TextFile.selectOrder.tr,
              style: AppStyle.txtDMSansRegular14.copyWith(color: Colors.black),
            ),
            SizedBox(
              width: width_50,
            ),
            Text(
              TextFile.submitFeedback.tr,
              style: AppStyle.txtDMSansRegular14.copyWith(color: Colors.black),
            ),
          ],
        ).marginOnly(top: margin_15),
      ],
    );
  }

  _selectAnOrderForFeedback() {
    return Text(
      TextFile.selectAnOrderForFeedback.tr,
      style: AppStyle.txtDMSansRegular14Black900,
    ).marginOnly(top: margin_30);
  }

  Widget _orderHistoryItemWidget(int index) {
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
            Expanded(
              child: Text(
                '${controller.ordersList[index].orderItemList?.length ?? 0} items',
                style: AppStyle.txtDMSansMedium14Black900,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: margin_12, vertical: margin_5),
              decoration: BoxDecoration(
                color: ColorConstant.gray60026,
                border: Border.all(width: 0.25, color: ColorConstant.gray600),
                borderRadius: BorderRadius.circular(radius_20),
              ),
              child:
                  Text('${TextFile.orderNo}${controller.ordersList[index].id}'),
            )
          ],
        ),
        Text(
          formatItemList(controller.ordersList[index].orderItemList ?? []),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: AppStyle.txtDMSansRegular12Gray60001,
        ).marginOnly(top: margin_8),
        Divider(
          color: ColorConstant.gray600,
          height: height_15,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${TextFile.orderPlacedOn.tr} ${formatDateWithSuffix(formattedDateString: controller.ordersList[index].createdOn)}',
                    style: AppStyle.txtDMSansRegular12Gray60001,
                  ),
                  Text(
                    '${TextFile.forAmount.tr} Rs. ${controller.ordersList[index].grandTotal?.toStringAsFixed(1)}',
                    style: AppStyle.txtDMSansRegular12Black900,
                  ).marginOnly(top: margin_1),
                ],
              ),
            ),
            GetInkwell(
              onTap: () {
                controller.selectedOrder.value = controller.ordersList[index];
              },
              child: Container(
                alignment: Alignment.center,
                width: width_80,
                padding: EdgeInsets.symmetric(vertical: margin_5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorConstant.greenA700),
                  borderRadius: BorderRadius.circular(radius_25),
                ),
                child: Text(TextFile.select.tr,
                    style: AppStyle.txtDMSansRegular12GreenA700),
              ),
            )
          ],
        )
      ]),
    );
  }

  _orderList() {
    return ListView.separated(
      itemCount: controller.ordersList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _orderHistoryItemWidget(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: height_10);
      },
    ).marginOnly(top: margin_20);
  }

  _menuItemList() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: controller.selectedOrder.value?.orderItemList?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: Text(
                controller
                        .selectedOrder.value?.orderItemList![index].itemName ??
                    '',
                style: AppStyle.txtDMSansRegular14Black900,
              ),
            ),
            RatingBar.builder(
              itemCount: 5,
              allowHalfRating: false,
              glow: false,
              minRating: 1,
              initialRating: 0,
              unratedColor: ColorConstant.gray300,
              itemSize: height_15,
              itemBuilder: (context, index) {
                return AssetImageWidget(ImageConstant.imagesIcStarSelected);
              },
              onRatingUpdate: (value) {
                controller.selectedOrder.value?.orderItemList![index]
                    .ratingGiven = value;
                debugPrint(controller
                    .selectedOrder.value?.orderItemList![index].ratingGiven
                    .toString());
              },
            )
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_10,
        );
      },
    ).marginOnly(top: margin_15);
  }

  _selectRatingText() {
    return Text(
      TextFile.selectRatings.tr,
      style: AppStyle.txtDMSansBold16,
    ).marginOnly(top: margin_30);
  }

  _selectAFeedbackText() {
    return Text(
      TextFile.selectFeedback.tr,
      style: AppStyle.txtDMSansRegular14Black900,
    ).marginOnly(top: margin_15);
  }

  _feedbackList() {
    return Container(
      height: height_50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.feedBackItemList.length,
        itemBuilder: (context, index) {
          return GetInkwell(
            onTap: () {
              // controller.selectedFeedback.value = controller.feedBackItemList[index];
              debugPrint(controller.selectedFeedback.value);
              controller.feedBackController?.text =
                  '${controller.feedBackController?.text} ${controller.feedBackItemList[index]}';
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  vertical: margin_5, horizontal: margin_15),
              decoration: BoxDecoration(
                  color: controller.selectedFeedback.value ==
                          controller.feedBackItemList[index]
                      ? ColorConstant.greenA700
                      : Colors.white,
                  borderRadius: BorderRadius.circular(radius_25),
                  border: Border.all(
                      color: controller.selectedFeedback.value ==
                              controller.feedBackItemList[index]
                          ? Colors.transparent
                          : ColorConstant.gray500)),
              child: Text(controller.feedBackItemList[index],
                  style: AppStyle.txtDMSansRegular12.copyWith(
                      color: controller.selectedFeedback.value ==
                              controller.feedBackItemList[index]
                          ? Colors.white
                          : Colors.black)),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: width_10,
          );
        },
      ).marginOnly(top: margin_20),
    );
  }

  _feedBackTextField() {
    return CustomTextFormField(
      maxLines: 4,
      controller: controller.feedBackController,
      fillColor: ColorConstant.gray100,
      contentPadding: EdgeInsets.all(margin_10),
      hintText: TextFile.writeYourFeedback.tr,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius_5),
          borderSide: BorderSide(color: ColorConstant.gray300)),
    ).marginOnly(top: margin_20);
  }

  _submitFeedbackButton() {
    return CustomButton(
        height: 45,
        width: getSize(width),
        shape: ButtonShape.RoundedBorder22,
        text: TextFile.enterFeedback.tr,
        margin: getMargin(top: margin_25),
        variant: ButtonVariant.OutlineBlack9003f,
        fontStyle: ButtonFontStyle.InterSemiBold18,
        onTap: () async {
          for (final element in controller.selectedOrder.value?.orderItemList ?? []) {
            if (element.ratingGiven! > 0.0) {
              await FeedbackNetwork.addFeedback(
                itemId: element.itemId,
                ratingGiven: element.ratingGiven!,
                orderId: controller.selectedOrder.value?.id,
                feedback: controller.feedBackController?.text ?? '',
                outletId: controller.selectedOrder.value?.outletId,
                onSuccess: () {
                  controller.addedCount.value++;
                },
              );
            }
          }

          if(controller.addedCount.value>0){
            debugPrint(controller.addedCount.value.toString());
            controller.addedCount.value=0;
            controller.selectedOrder.value = null;
            controller.selectedFeedback.value = null;
            controller.feedBackController?.clear();
          }
        });
  }
}
