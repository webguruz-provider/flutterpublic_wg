import 'dart:io';

import 'package:foodguru/app_values/export.dart';
import 'package:foodguru/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class CommonUtils {
  //function to check network connectivity
  static Future<bool> isNetworAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      printLog("isNetworkAvailable", _);
      return false;
    }
  }

  Future<void> launchUrlInAppView(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }


}
