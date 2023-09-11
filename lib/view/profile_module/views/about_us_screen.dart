import 'package:foodguru/app_values/export.dart';

class AboutUsScreen extends GetView<AboutUsController> {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.gray50,
      appBar: CustomAppBar(title: TextFile.aboutUs.tr),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemCount: controller.aboutList.length,
            itemBuilder: (context, index) {
              return GetInkwell(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Get.toNamed(AppRoutes.staticPagesScreen);
                        break;
                      case 1:
                        break;
                      }
                  },
                  child: index == 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.aboutList[index],
                              style: AppStyle.txtDMSansRegular16
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              '17.3.2.Live',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF646262),
                                fontSize: 12,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.aboutList[index],
                                style: AppStyle.txtDMSansRegular16
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: height_15,
                            ),
                          ],
                        ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: ColorConstant.gray600,
              );
            },
          )
        ],
      ).marginAll(margin_15)),
    );
  }
}
