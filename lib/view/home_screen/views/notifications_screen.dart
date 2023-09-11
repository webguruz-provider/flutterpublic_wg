import 'package:foodguru/app_values/export.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(title: TextFile.notifications.tr),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextFile.today.tr,
                  style: AppStyle.txtDMSansRegular14Gray50004),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.notificationList.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => GetInkwell(
                      onTap: () {
                        controller.notificationList[index].isReadMore?.value =
                            !controller
                                .notificationList[index].isReadMore!.value;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: margin_5, vertical: margin_5),
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
                        child: Row(children: [
                          AssetImageWidget(
                            ImageConstant.imagesIcCoupon1,
                            width: width_60,
                            height: width_60,
                            radiusAll: radius_50,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _notificationTitle(index),
                                _notificationDescription(index),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return controller.count > 0 && index == controller.count - 1
                      ? Text(TextFile.earlier.tr,
                              style: AppStyle.txtDMSansRegular14Gray50004)
                          .marginSymmetric(vertical: margin_10)
                      : SizedBox(
                          height: height_10,
                        );
                },
              ).marginOnly(top: margin_10)
            ],
          ).marginAll(margin_15),
        ),
      ),
    );
  }

  _notificationTitle(int index) {
    return Row(
      children: [
        Expanded(
          child: Text(
            controller.notificationList[index].title ?? '',
            maxLines: 1,
            style: AppStyle.txtDMSansBold14Black900,
          ),
        ),
        Text(
          dateFormatDateTime(
              format: 'hh:mm a',
              value: DateTime.parse(
                  controller.notificationList[index].createdOn!).toLocal()),
          style: AppStyle.txtDMSansRegular12,
        )
      ],
    );
  }

  _notificationDescription(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            controller.notificationList[index].isReadMore!.value == true
                ? controller.notificationList[index].description ?? ''
                : truncateText(
                    controller.notificationList[index].description ?? '',
                    100),
            overflow: TextOverflow.ellipsis,
            maxLines:
                controller.notificationList[index].isReadMore?.value == true
                    ? 100
                    : 2,
            style: AppStyle.txtDMSansRegular12Gray600,
          ),
        ),
        (controller.notificationList[index].description!).length<100?Container():Text(
          controller.notificationList[index].isReadMore!.value
              ? TextFile.readLess.tr
              : TextFile.readMore.tr,
          style: AppStyle.txtDMSansBold12.copyWith(
              color: ColorConstant.greenA700,
              decoration: TextDecoration.underline),
        )
      ],
    ).marginOnly(top: margin_5);
  }
}
