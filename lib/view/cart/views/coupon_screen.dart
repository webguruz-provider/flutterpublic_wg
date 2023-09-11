import 'package:foodguru/app_values/export.dart';

class CouponScreen extends GetView<CouponController> {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorConstant.gray50,
        appBar: CustomAppBar(
          title: '${TextFile.coupons.tr} %',
        ),
        body: _couponsList(),
      ),
    );
  }

  _couponsList() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: controller.couponList.length,
      padding: EdgeInsets.all(margin_15),
      itemBuilder: (context, index) {
        var data = controller.couponList[index];
        return _listItems(data);
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: height_10,
        );
      },
    );
  }

  _listItems(CouponModel data) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_5),
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius_5),
            border:
                Border.all(color: ColorConstant.greenA700, width: width_0pt5),
          ),
          child: Row(
            children: [
              _couponImage(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _couponTitle(data),
                    _couponDescription(data),
                  ],
                ),
              ),
              _applyButton(data),
            ],
          ),
        ),
        _leftRoundedContainer(),
        _rightRoundedContainer(),
      ],
    );
  }

  _couponImage() {
    return AssetImageWidget(
      ImageConstant.imagesIcCoupon1,
      width: width_60,
      height: width_60,
      radiusAll: radius_50,
    );
  }

  _couponTitle(CouponModel data) {
    return Text(
      data.couponName ?? '',
      maxLines: 1,
      style: AppStyle.txtDMSansBold14Black900,
    );
  }

  _couponDescription(CouponModel data) {
    return Text(
      data.description ?? '',
      maxLines: 2,
      style: AppStyle.txtDMSansRegular12Gray600,
    ).marginOnly(top: margin_5);
  }

  _applyButton(CouponModel data) {
    return GetInkwell(
      onTap: () {
        if (controller.itemTotal.value! >=
            int.parse(data.minimumOrder.toString())) {
          Get.back(result: data);
        }
      },
      child: Text(
        TextFile.apply.tr,
        style: AppStyle.txtDMSansBold12.copyWith(
            color: controller.itemTotal.value! <
                    int.parse(data.minimumOrder.toString())
                ? ColorConstant.gray600
                : ColorConstant.greenA700,
            decoration: TextDecoration.underline),
      ).marginOnly(right: margin_5),
    );
  }

  _leftRoundedContainer() {
    return Positioned(
      left: -10,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_50),
            color: ColorConstant.gray50,
            border: Border.all(color: ColorConstant.greenA700)),
      ),
    );
  }

  _rightRoundedContainer() {
    return Positioned(
      right: -10,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius_50),
            color: ColorConstant.gray50,
            border: Border.all(color: ColorConstant.greenA700)),
      ),
    );
  }
}
