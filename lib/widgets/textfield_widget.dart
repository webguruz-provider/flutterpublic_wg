import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodguru/app_values/export.dart';

import '../utils/color.dart';
import '../utils/size_constant.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    this.shape,
    this.readOnly=false,
    this.padding,
    this.variant,
    this.fontStyle,
    this.maxLength,
    this.fillColor,

    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.isObscureText,
    this.textInputAction = TextInputAction.done,
    this.maxLines,
    this.hintText,
    this.prefix,
    this.border,
    this.onChanged,
    this.prefixConstraints,
    this.suffix,
    this.inputFormatters,
    this.suffixConstraints,
    this.onFieldSubmitted,
    this.validator,
    this.contentPadding,
    this.height,
    this.keyBoardInputType,
    this.onTap
  });

  TextFormFieldShape? shape;

  TextFormFieldPadding? padding;

  TextFormFieldVariant? variant;

  TextFormFieldFontStyle? fontStyle;

  double? width;
  Color? fillColor;
  double? height;
  bool readOnly;
  int? maxLength;

  EdgeInsetsGeometry? margin;
  EdgeInsets? contentPadding;
  TextEditingController? controller;

  FocusNode? focusNode;

  bool? isObscureText;
  InputBorder? border;

  TextInputAction? textInputAction;

  int? maxLines;

  String? hintText;

  Widget? prefix;

  ValueChanged<String>? onFieldSubmitted;
  ValueChanged<String>? onChanged;
  Function()? onTap;
  BoxConstraints? prefixConstraints;

  Widget? suffix;

  BoxConstraints? suffixConstraints;

  FormFieldValidator<String>? validator;
  TextInputType? keyBoardInputType;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return _buildTextFormFieldWidget();
  }

  _buildTextFormFieldWidget() {
    return Material(
      color: Colors.transparent,
      child: TextFormField(autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyBoardInputType,
        readOnly: readOnly,
        inputFormatters: inputFormatters??[],
        controller: controller,maxLength:maxLength ,
        focusNode: focusNode,validator: validator,
        style: _setFontStyle(),
        onFieldSubmitted:onFieldSubmitted ,
        onChanged:onChanged ,onTap:onTap??(){},
        obscureText: isObscureText??false,
        textInputAction: textInputAction,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        // validator: validator,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      // errorMaxLines: 3,
      // counterText: "",
      filled: true,counterText: '',
      fillColor:fillColor?? Colors.white,
      hintText: hintText ?? "",
      // errorBorder: const OutlineInputBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(22)),
      //     borderSide: BorderSide(
      //       width: 1,
      //       color: Colors.red,
      //     )),
      hintStyle: _setFontStyle(),
      border: border??_setBorderStyle(),
      enabledBorder:border?? _setBorderStyle(),
      focusedBorder:border?? _setBorderStyle(),
      disabledBorder:border?? _setBorderStyle(),
      focusedErrorBorder:border?? _setBorderStyle(),

      // errorBorder: _setBorderStyle(),

      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      // fillColor: _setFillColor(),
      // // filled: true,
      // filled: _setFilled(),
      isDense: true,
      contentPadding: contentPadding??_setPadding(),
    );
  }

  _setFontStyle() {
    switch (fontStyle) {
      case TextFormFieldFontStyle.DMSansRegular12:
        return TextStyle(
          color: ColorConstant.gray700,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      case TextFormFieldFontStyle.DMSansRegular12Black900:
        return TextStyle(
          color: ColorConstant.black900,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      case TextFormFieldFontStyle.DMSansRegular16:
        return TextStyle(
          color: ColorConstant.blueGray400,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      case TextFormFieldFontStyle.DMSansMedium16:
        return TextStyle(
          color: ColorConstant.black90002,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        );
      case TextFormFieldFontStyle.DMSansRegular14:
        return TextStyle(
          color: ColorConstant.black90002,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      case TextFormFieldFontStyle.DMSansRegular12Black90002:
        return TextStyle(
          color: ColorConstant.black90002,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
      case TextFormFieldFontStyle.InterSemiBold18:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        );
      default:
        return TextStyle(
          color: ColorConstant.gray50002,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      case TextFormFieldShape.RoundedBorder5:
        return BorderRadius.circular(
          getHorizontalSize(
            5.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            22.00,
          ),
        );
    }
  }

  _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.OutlineGray50001:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.gray50001,
            width: 1,
          ),
        );
      case TextFormFieldVariant.FillGray200:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.OutlineGray300:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.gray300,
            width: 1,
          ),
        );
      case TextFormFieldVariant.UnderLineGray30002:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstant.gray30002,
          ),
        );
      case TextFormFieldVariant.OutlineBlack9001e:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.UnderLineGreenA700:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstant.greenA700,
          ),
        );
      case TextFormFieldVariant.OutlineBlack9003f:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.None:
        return InputBorder.none;
      default:
        return DecoratedInputBorder(child: OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        ),shadow: [BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 2,
          offset: const Offset(0, 3),
        ),]);
    }
  }

  _setFillColor() {
    switch (variant) {
      case TextFormFieldVariant.OutlineGray50001:
        return ColorConstant.whiteA700;
      case TextFormFieldVariant.FillGray200:
        return ColorConstant.gray200;
      case TextFormFieldVariant.OutlineGray300:
        return ColorConstant.gray100;
      case TextFormFieldVariant.OutlineBlack9001e:
        return ColorConstant.gray50;
      case TextFormFieldVariant.OutlineBlack9003f:
        return ColorConstant.greenA700;
      default:
        return ColorConstant.whiteA700;
    }
  }

  _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.OutlineGray50001:
        return true;
      case TextFormFieldVariant.FillGray200:
        return true;
      case TextFormFieldVariant.OutlineGray300:
        return true;
      case TextFormFieldVariant.UnderLineGray30002:
        return false;
      case TextFormFieldVariant.OutlineBlack9001e:
        return true;
      case TextFormFieldVariant.UnderLineGreenA700:
        return false;
      case TextFormFieldVariant.OutlineBlack9003f:
        return true;
      case TextFormFieldVariant.None:
        return false;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingAll14:
        return getPadding(
          all: 14,
        );
      case TextFormFieldPadding.PaddingT13:
        return getPadding(
          top: 13,
          bottom: 13,
        );
      case TextFormFieldPadding.PaddingAll8:
        return getPadding(
          all: 8,
        );
      default:
        return getPadding(
          top: 14,
          right: 14,
          bottom: 14,
        );
    }
  }
}

enum TextFormFieldShape {
  RoundedBorder22,
  RoundedBorder5,
}

enum TextFormFieldPadding {
  PaddingAll14,
  PaddingT13,
  PaddingT14,
  PaddingAll8,
}

enum TextFormFieldVariant {
  None,
  OutlineBlack90019,
  OutlineGray50001,
  FillGray200,
  OutlineGray300,
  UnderLineGray30002,
  OutlineBlack9001e,
  UnderLineGreenA700,
  OutlineBlack9003f,
}

enum TextFormFieldFontStyle {
  InterRegular12,
  DMSansRegular12,
  DMSansRegular12Black900,
  DMSansRegular16,
  DMSansMedium16,
  DMSansRegular14,
  DMSansRegular12Black90002,
  InterSemiBold18,
}
