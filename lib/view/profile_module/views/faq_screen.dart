import 'package:foodguru/app_values/export.dart';


class FaqScreen extends GetView<FaqController> {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: TextFile.faq.tr),
      body: ListView.separated(
        itemCount: controller.faqList.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(margin_15),
        itemBuilder: (context, index) {
          return CustomExpansionTile(
            header:  Expanded(child: Text(controller.faqList[index].title??'',style: AppStyle.txtDMSansRegular14Black900,)),
            animatedWidgetFollowingHeader:
                const Icon(Icons.keyboard_arrow_down_rounded),
            childrenBody: Text(controller.faqList[index].description??'',style: AppStyle.txtDMSansRegular14Gray50004,).marginSymmetric(vertical: margin_5),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: ColorConstant.gray600,
            height: height_10,
          );
        },
      ),
    );
  }
}
