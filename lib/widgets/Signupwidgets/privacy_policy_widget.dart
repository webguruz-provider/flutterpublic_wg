import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodguru/app_values/export.dart';

import '../../utils/theme/app_style.dart';

class PrivacyAndTermAndConditions extends StatelessWidget {
  VoidCallback? actionTermAndConditions;
  VoidCallback? actionPrivacyPolicy;
  PrivacyAndTermAndConditions(
      {super.key, this.actionTermAndConditions, this.actionPrivacyPolicy});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.topLeft,
      child: Text.rich(TextSpan(
          text: '${TextFile.iAgreeToAll.tr} ',
          style: AppStyle.txtDMSansRegular12Gray700,
          children: <TextSpan>[
        TextSpan(
            text: TextFile.termsAndConditions.tr.toLowerCase(),
            style: AppStyle.txtInterMedium12GreenA70087
                .copyWith(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () => actionPrivacyPolicy!.call()),
        TextSpan(
            text: ' ${TextFile.and.tr} ',
            style: AppStyle.txtDMSansRegular12Gray700,
            children: <TextSpan>[
              TextSpan(
                  text: '${TextFile.privacyPolicy.tr}',
                  style: AppStyle.txtInterMedium12GreenA70087
                      .copyWith(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => actionPrivacyPolicy!.call()
                  // code to open / launch privacy policy link here

                  ),
              TextSpan(
                  text: ' ${TextFile.agreeToAll.tr} ',
                  style: AppStyle.txtDMSansRegular12Gray700,)
            ])
      ]),textAlign: TextAlign.start),
    );
  }
}
