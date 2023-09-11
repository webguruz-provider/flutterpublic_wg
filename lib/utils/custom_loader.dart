import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodguru/app_values/export.dart';
import 'package:lottie/lottie.dart';

class CustomLoader {
  OverlayEntry? _overlayEntry;

  CustomLoader();

  void show(context) {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: [
          Container(
            color: Colors.black.withOpacity(0.2),
            child: Center(
              child: Lottie.asset(ImageConstant.loadingJson,
                  width: width_80, height: width_80),
            ),
          ),
        ],
      ),
    );
  }
}
