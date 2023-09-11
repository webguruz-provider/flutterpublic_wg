import 'package:flutter/material.dart';
import 'package:foodguru/app_values/export.dart';

import '../utils/color.dart';
import '../utils/size_constant.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.margin,
      this.onTap,
      this.width,
      this.height,
      this.text,
      this.prefixWidget,
      this.suffixWidget,
      this.elevation});

  ButtonShape? shape;

  EdgeInsets? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  VoidCallback? onTap;

  double? width;

  double? height;

  String? text;

  Widget? prefixWidget;

  Widget? suffixWidget;
  ButtonVariant? shadowColor;
  double? elevation;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: onTap,
        style: _buildTextButtonStyle(),
        child: _buildButtonWithOrWithoutIcon(),
      ),
    );
  }

  _buildButtonWithOrWithoutIcon() {
    if (prefixWidget != null || suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixWidget ?? const SizedBox(),
          Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: _setFontStyle(),
          ),
          suffixWidget ?? const SizedBox(),
        ],
      );
    } else {
      return Text(
        text ?? "",
        textAlign: TextAlign.center,
        style: _setFontStyle(),
      );
    }
  }

  _buildTextButtonStyle() {
    return TextButton.styleFrom(
      elevation: elevation,
      fixedSize: Size(
        getHorizontalSize(width ?? 0),
        getVerticalSize(height ?? 0),
      ),
      padding:padding?? getPadding(
        all: 4,
      ),
      backgroundColor: _setColor(),
      side: _setTextButtonBorder(),
      shadowColor: _setTextButtonShadowColor(),
      shape: RoundedRectangleBorder(
        borderRadius: _setBorderRadius(),
      ),
    );
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.FillBluegray100:
        return ColorConstant.blueGray100;
      case ButtonVariant.OutlineGray500_1:
        return ColorConstant.black900;
      case ButtonVariant.OutlineGray50001:
        return ColorConstant.whiteA700;
      case ButtonVariant.FillGray50004:
        return ColorConstant.gray50004;
      case ButtonVariant.OutlineBlack9003f:
        return ColorConstant.greenA700;
      case ButtonVariant.OutlineGreenA700:
        return ColorConstant.greenA70026;
      case ButtonVariant.OutlineGreenA700_1:
        return ColorConstant.green50;
      case ButtonVariant.OutlineBluegray40001:
        return ColorConstant.gray60026;
      case ButtonVariant.FillRed500:
        return ColorConstant.red500;
      case ButtonVariant.OutlineBlack90019:
        return ColorConstant.whiteA700;
      case ButtonVariant.FillOrange400:
        return ColorConstant.orange400;
      case ButtonVariant.OutlineGreenA700_2:
        return ColorConstant.gray90001;
      case ButtonVariant.OutlineBlack9003f_1:
        return ColorConstant.red500;
      case ButtonVariant.OutlineGreenA700_3:
        return ColorConstant.whiteA700;
      case ButtonVariant.OutlineGray500:
        return null;
      default:
        return ColorConstant.greenA700;
    }
  }

  _setTextButtonBorder() {
    switch (variant) {
      case ButtonVariant.OutlineGray500:
        return BorderSide(
          color: ColorConstant.gray500,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineGray500_1:
        return BorderSide(
          color: ColorConstant.gray500,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineGray50001:
        return BorderSide(
          color: ColorConstant.gray50001,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineGreenA700:
        return BorderSide(
          color: ColorConstant.greenA700,
          width: getHorizontalSize(
            0.50,
          ),
        );
      case ButtonVariant.OutlineGreenA700_1:
        return BorderSide(
          color: ColorConstant.greenA700,
          width: getHorizontalSize(
            0.50,
          ),
        );
      case ButtonVariant.OutlineBluegray40001:
        return BorderSide(
          color: ColorConstant.blueGray40001,
          width: getHorizontalSize(
            0.50,
          ),
        );
      case ButtonVariant.OutlineGreenA700_2:
        return BorderSide(
          color: ColorConstant.greenA700,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineGreenA700_3:
        return BorderSide(
          color: ColorConstant.greenA700,
          width: getHorizontalSize(
            1.00,
          ),
        );
      default:
        return null;
    }
  }

  _setTextButtonShadowColor() {
    switch (variant) {
      case ButtonVariant.OutlineBlack9003f:
        return ColorConstant.black9003f;
      case ButtonVariant.OutlineBlack90019:
        return ColorConstant.black90019;
      case ButtonVariant.OutlineBlack9003f_1:
        return ColorConstant.black9003f;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.RoundedBorder5:
        return BorderRadius.circular(
          getHorizontalSize(
            5.00,
          ),
        );
      case ButtonShape.RoundedBorder22:
        return BorderRadius.circular(
          getHorizontalSize(
            22.00,
          ),
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            13.00,
          ),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.InterSemiBold14:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.InterSemiBold14WhiteA700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.InterRegular12:
        return TextStyle(
          color: ColorConstant.gray50002,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.InterRegular14:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.InterRegular13:
        return TextStyle(
          color: ColorConstant.gray50002,
          fontSize: getFontSize(
            13,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.InterSemiBold18:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.DMSansRegular12GreenA700:
        return TextStyle(
          color: ColorConstant.greenA700,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.InterSemiBold18GreenA700:
        return TextStyle(
          color: ColorConstant.greenA700,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.DMSansBold18:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.DMSansRegular12Black90002:
        return TextStyle(
          color: ColorConstant.black90002,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      case ButtonFontStyle.DMSansBold20:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            20,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        );
      default:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
    }
  }
}

enum ButtonShadow { Color, RadiusColor }

enum ButtonShape {
  Square,
  CircleBorder13,
  RoundedBorder5,
  RoundedBorder22,
}

enum ButtonPadding {
  PaddingAll4,
  PaddingAll22,
  PaddingAll15,
  PaddingAll10,
  PaddingT12,
  PaddingT7,
  PaddingAll30,
  PaddingT3,
}

enum ButtonVariant {
  FillGreenA700,
  FillBluegray100,
  OutlineGray500,
  OutlineGray500_1,
  OutlineGray50001,
  FillGray50004,
  OutlineBlack9003f,
  OutlineGreenA700,
  OutlineGreenA700_1,
  OutlineBluegray40001,
  FillRed500,
  OutlineBlack90019,
  FillOrange400,
  OutlineGreenA700_2,
  OutlineBlack9003f_1,
  OutlineGreenA700_3,
}

enum ButtonFontStyle {
  DMSansRegular12,
  InterSemiBold14,
  InterSemiBold14WhiteA700,
  InterRegular12,
  InterRegular14,
  InterRegular13,
  InterSemiBold18,
  DMSansRegular12GreenA700,
  InterSemiBold18GreenA700,
  DMSansBold18,
  DMSansRegular12Black90002,
  DMSansBold20,
}

class ActionButtonWidget extends StatelessWidget {
  String text;
  VoidCallback actionCallBack;
  ActionButtonWidget(
      {super.key, required this.text, required this.actionCallBack});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(),
      onPressed: () => actionCallBack,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
