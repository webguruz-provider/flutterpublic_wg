import 'package:flutter/material.dart';
import 'package:foodguru/app_values/export.dart';

import '../../utils/size_constant.dart';
import '../button_widget.dart';
import '../custom_image_widget.dart';

class SocialMediaWidget extends StatelessWidget {
  SocialMediaWidget({super.key, this.actionSocialMedia, this.image, this.text});
  String? image;
  String? text;
  VoidCallback? actionSocialMedia;

  @override
  Widget build(BuildContext context) {
    return CustomButton(

        text: text,
        elevation: 10.0,
        shape: ButtonShape.RoundedBorder22,
        variant: ButtonVariant.OutlineBlack90019,
        padding: EdgeInsets.symmetric(vertical: getSize(5)),
        fontStyle: ButtonFontStyle.InterRegular13,
        prefixWidget: CustomImageView(svgPath: image,height: getSize(20),width: getSize(20),).marginOnly(right: getSize(6)),
        onTap: actionSocialMedia);
  }
}
