import 'package:foodguru/app_values/export.dart';

class NetworkImageWidget extends StatelessWidget {
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

  NetworkImageWidget(this.image,
      {this.height, this.width, this.boxFit, this.color, this.radiusAll});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: radiusAll != null
            ? BorderRadius.circular(radiusAll ?? 0)
            : BorderRadius.only(
          topLeft: Radius.circular(radiusTopLeft??0),
          topRight: Radius.circular(radiusTopRight??0),
          bottomRight:  Radius.circular(radiusBottomRight??0),
          bottomLeft: Radius.circular(radiusBottomLeft??0),),
        child: Image.network(
          image ?? '',
          height: height,
          width: width,
          color: color,
          fit: boxFit,
        ));
  }
}
