import 'dart:io';

import 'package:foodguru/app_values/export.dart';

class FileImageWidget extends StatelessWidget {
  String? image;
  double? height;
  double? width;
  double? radiusAll;
  double? radiusTopLeft;
  double? radiusTopRight;
  double? radiusBottomLeft;
  double? radiusBottomRight;
  BoxFit? boxFit;
  Color? color;

  FileImageWidget(this.image,
      {this.height,
        this.width,
        this.boxFit,
        this.color,
        this.radiusAll,
        this.radiusBottomRight,
        this.radiusTopRight,
        this.radiusTopLeft,
        this.radiusBottomLeft});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radiusAll != null
          ? BorderRadius.circular(radiusAll ?? 0)
          : BorderRadius.only(
        topLeft: Radius.circular(radiusTopLeft ?? 0),
        topRight: Radius.circular(radiusTopRight ?? 0),
        bottomRight: Radius.circular(radiusBottomRight ?? 0),
        bottomLeft: Radius.circular(radiusBottomLeft ?? 0),
      ),
      child: Image.file(
        File(image ?? ''),
        height: height,
        width: width,
        color: color,
        fit: boxFit,
      ),
    );
  }
}
