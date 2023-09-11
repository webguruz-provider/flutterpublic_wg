import 'package:flutter/material.dart';

import '../../utils/size_constant.dart';
import '../../utils/theme/app_style.dart';

class OnboardingView extends StatelessWidget {
  String onboardingsvgImageurl;
  String onboardingtitle;
  String onboardingSubtitle;
  OnboardingView({
    super.key,
    required this.onboardingsvgImageurl,
    required this.onboardingtitle,
    required this.onboardingSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Image.network(
            onboardingsvgImageurl,
            height: size.height / 2.5,
            width: double.infinity,
          ),
          Padding(
              padding: getPadding(top: 21),
              child: Text(onboardingtitle,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtInterSemiBold24GreenA700)),
          Container(
              width: getHorizontalSize(356.00),
              margin: getMargin(top: 20),
              child: Text(onboardingSubtitle,
                  maxLines: null,
                  textAlign: TextAlign.center,
                  style: AppStyle.txtInterRegular12Gray800)),
        ],
      ),
    );
  }
}
