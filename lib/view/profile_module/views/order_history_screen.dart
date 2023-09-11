import 'package:foodguru/app_values/export.dart';

class OrderHistoryScreen extends GetView<OrderHistoryController> {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(title: TextFile.orderHistory.tr),
      body: Obx(
        () => SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headingWidget(title: TextFile.newOrder.tr),
            _newOrdersList(),
            // headingWidget(title: TextFile.pastOrder.tr).marginOnly(top: margin_15),
            // _pastOrdersList(),
          ],
        ).marginAll(margin_15)),
      ),
    );
  }

  Widget headingWidget({title}) {
    return Text(
      title ?? '',
      style: AppStyle.txtDMSansRegular14Gray50004,
    );
  }

  Widget _orderHistoryItemWidget(int index, {bool? isOrderComplete = false}) {
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
            controller.ordersList[index].stateId == keyOrderCancel
                ? Text(TextFile.cancelled.tr,
                    style: AppStyle.txtDMSansRegular12Black900
                        .copyWith(color: ColorConstant.red500))
                : GetInkwell(
                    onTap: () {
                      if (isOrderComplete == false) {
                        Get.toNamed(AppRoutes.cancelOrderScreen, arguments: {
                          keyId: controller.ordersList[index].id
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: width_80,
                      padding: EdgeInsets.symmetric(vertical: margin_5),
                      decoration: BoxDecoration(
                        color: isOrderComplete == true
                            ? ColorConstant.greenA700
                            : ColorConstant.red500,
                        borderRadius: BorderRadius.circular(radius_25),
                      ),
                      child: Text(
                          isOrderComplete == true
                              ? TextFile.reorder.tr
                              : TextFile.cancelOrder.tr,
                          style: AppStyle.txtDMSansRegular12WhiteA700),
                    ),
                  )
          ],
        )
      ]),
    );
  }

  _pastOrdersList() {
    return ListView.separated(
      itemCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GetInkwell(
            onTap: () {
              Get.toNamed(AppRoutes.orderDetailsScreen, arguments: {
                isOrderCompleted: true,
              });
            },
            child: _orderHistoryItemWidget(index, isOrderComplete: true));
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_10,
        );
      },
    ).marginOnly(top: margin_12);
  }

  _newOrdersList() {
    return ListView.separated(
      itemCount: controller.ordersList.length,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GetInkwell(
            onTap: () {
              Get.toNamed(AppRoutes.orderDetailsScreen, arguments: {
                isOrderCompleted: false,
                keyId: controller.ordersList[index].id
              });
            },
            child: _orderHistoryItemWidget(index, isOrderComplete: false));
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_10,
        );
      },
    ).marginOnly(top: margin_12);
  }
}
