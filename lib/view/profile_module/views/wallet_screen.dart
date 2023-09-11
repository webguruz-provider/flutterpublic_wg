import 'package:foodguru/app_values/export.dart';

class WalletScreen extends GetView<WalletController> {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(title: TextFile.wallet.tr),
      body: Obx(() =>  SingleChildScrollView(
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
                    TextFile.myWallet.tr,
                    style: AppStyle.txtDMSansRegular14,
                  ),
                  Text(
                    'Rs. ${controller.walletValue.value ??0}',
                    style: AppStyle.txtDMSansBold22,
                  ),
                ],
              ),
            ),
            CustomButton(
                height: 45,
                width: getSize(width),
                shape: ButtonShape.RoundedBorder22,
                text: TextFile.addMoney.tr,
                margin: getMargin(top: margin_20),
                variant: ButtonVariant.OutlineGreenA700,
                fontStyle: ButtonFontStyle.InterSemiBold18GreenA700,
                onTap: () async {
                  var result = await Get.toNamed(AppRoutes.addMoneyScreen,arguments: {keyFromWallet:true});
                  if(result!=null){
                    controller.localDbGetWallet();
                  }
                })
          ],
        ).marginAll(margin_15)),
      ),
    );
  }
}
