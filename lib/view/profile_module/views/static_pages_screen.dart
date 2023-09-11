import 'package:foodguru/app_values/export.dart';

class StaticPagesScreen extends GetView<StaticPagesController> {
  const StaticPagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: TextFile.aboutUs.tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms of Service',
              style: AppStyle.txtDMSansBold16Black90001,
            ),
        Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '*10,
        style: AppStyle.txtDMSansRegular14Black900,
      ).marginOnly(top: margin_5)
          ],
        ).marginAll(margin_15),
      ),
    );
  }
}
