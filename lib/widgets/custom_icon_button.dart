

import 'package:foodguru/app_values/export.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {this.shape,
      this.padding,
      this.variant,
      this.alignment,
      this.margin,
      this.width,
      this.height,
      this.child,
      this.onTap});

  IconButtonShape? shape;

  IconButtonPadding? padding;

  IconButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  double? width;

  double? height;

  Widget? child;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildIconButtonWidget(),
          )
        : _buildIconButtonWidget();
  }

  _buildIconButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton(
        iconSize: getSize(height ?? 0),
        padding: EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width: getSize(width ?? 0),
          height: getSize(height ?? 0),
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: child,
        ),
        onPressed: onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      border: _setBorder(),
      borderRadius: _setBorderRadius(),
      boxShadow: _setBoxShadow(),
    );
  }

  _setPadding() {
    switch (padding) {
      case IconButtonPadding.PaddingAll8:
        return getPadding(
          all: 8,
        );
      case IconButtonPadding.PaddingAll5:
        return getPadding(
          all: 5,
        );
      default:
        return getPadding(
          all: 11,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case IconButtonVariant.OutlineBlack90019:
        return ColorConstant.whiteA700;
      case IconButtonVariant.OutlineLightblue800:
        return ColorConstant.black90002;
      case IconButtonVariant.OutlineLightblue800_1:
        return ColorConstant.whiteA70044;
      default:
        return ColorConstant.whiteA700;
    }
  }

  _setBorder() {
    switch (variant) {
      case IconButtonVariant.OutlineLightblue800:
        return Border.all(
          color: ColorConstant.lightBlue800,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.OutlineLightblue800_1:
        return Border.all(
          color: ColorConstant.lightBlue800,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case IconButtonVariant.OutlineBlack90019:
      case IconButtonVariant.OutlineBlack9000f:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case IconButtonShape.CircleBorder26:
        return BorderRadius.circular(26.0);
      case IconButtonShape.CircleBorder40:
        return BorderRadius.circular(40.0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            23.00,
          ),
        );
    }
  }

  _setBoxShadow() {
    switch (variant) {
      case IconButtonVariant.OutlineBlack90019:
        return [
          BoxShadow(
            color: ColorConstant.black90019,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              2,
            ),
          )
        ];
      case IconButtonVariant.OutlineLightblue800:
      case IconButtonVariant.OutlineLightblue800_1:
        return null;
      default:
        return [
          BoxShadow(
            color: ColorConstant.black9000f,
            spreadRadius: getHorizontalSize(
              2.00,
            ),
            blurRadius: getHorizontalSize(
              2.00,
            ),
            offset: Offset(
              0,
              0,
            ),
          )
        ];
    }
  }
}

enum IconButtonShape { CircleBorder23, CircleBorder26, CircleBorder40 }

enum IconButtonPadding {
  PaddingAll11,
  PaddingAll8,
  PaddingAll5,
}

enum IconButtonVariant {
  OutlineBlack90019,
  OutlineBlack9000f,
  OutlineLightblue800,
  OutlineLightblue800_1,
}
