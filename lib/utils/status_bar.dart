
import 'package:flutter/services.dart';

class StatusBar {
  void setStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
  }

  dynamic setSystemUiOverlay() {
    return const SystemUiOverlayStyle(
      // statusBarColor: ColorsFile.colorYellow,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    );
  }
}
