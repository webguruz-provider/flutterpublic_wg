import 'package:foodguru/app_values/export.dart';


class ContactUsScreen extends GetView<ContactUsController> {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: TextFile.contactUs.tr,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleAndValue(title: TextFile.emailId.tr,value: 'info@webGuruz.in'),
            _titleAndValue(title: TextFile.contactNo.tr,value: '0172 466 6711').marginOnly(top: margin_15),


          ],
        ).marginAll(margin_15),
      ),
    );
  }

  Widget _titleAndValue({String? title,String? value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            title??'',
            style: AppStyle.txtDMSansRegular14Gray50004
        ),
        GetInkwell(
          onTap: () async {
            if(GetUtils.isEmail(value!)){
              await launchUrl(Uri(scheme: 'mailto', path: value));
            }else if(GetUtils.isPhoneNumber(value)){
              launchUrl(Uri(scheme: 'tel', path: value));
            }
          },
          child: Text(
            value??'',
            style: AppStyle.txtDMSansBold16Black90001,
          ).marginOnly(top: margin_2),
        )
      ],
    );
  }
}
