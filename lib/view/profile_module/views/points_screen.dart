import 'package:foodguru/app_values/export.dart';


class PointsScreen extends GetView<PointsController> {
  const PointsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(title: TextFile.points.tr),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: margin_20, vertical: margin_15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius_25),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.black9001e,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TextFile.totalPoints.tr,
                      style: AppStyle.txtDMSansRegular14,
                    ),
                    Obx(() =>  Text(
                      '${controller.pointValue.value}',
                      style: AppStyle.txtDMSansBold22,
                    ),)

                  ],
                ),
              ),
              CustomButton(
                  height: 45,
                  width: getSize(width),
                  shape: ButtonShape.RoundedBorder22,
                  text: TextFile.redeemNow.tr,
                  margin: getMargin(top: margin_20),
                  variant: ButtonVariant.OutlineGreenA700,
                  fontStyle: ButtonFontStyle.InterSemiBold18GreenA700,
                  onTap: () {
                  })
            ],
          ).marginAll(margin_15)),
    );
  }
}
