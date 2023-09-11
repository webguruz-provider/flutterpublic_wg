
import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../utils/size_constant.dart';

class CustomCheckbox extends StatelessWidget {
  CustomCheckbox(
      {this.shape,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.padding,
      this.iconSize,
      this.value,
      this.onChange,
      this.text});
  CheckboxShape? shape;
  CheckboxVariant? variant;
  CheckboxFontStyle? fontStyle;
  Alignment? alignment;
  EdgeInsetsGeometry? padding;
  double? iconSize;
  bool? value;
  Function(bool)? onChange;
  String? text;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildCheckboxWidget(),
          )
        : _buildCheckboxWidget();
  }

  _buildCheckboxWidget() {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          value = !(value!);
          onChange!(value!);
        },
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: getHorizontalSize(iconSize ?? 0),
          horizontalTitleGap: getHorizontalSize(
            10,
          ),
          leading: Checkbox(
            shape: _setShape(),
            value: value ?? false,
            onChanged: (value) {
              onChange!(value!);
            },
          ),
          title: Text(
            text ?? "",
            style: _setFontStyle(),
          ),
        ),
      ),
    );
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            3.00,
          ),
        );
    }
  }

  _setShape() {
    switch (variant) {
      case CheckboxVariant.OutlineGray40001:
        return RoundedRectangleBorder(
          side: BorderSide(
            color: ColorConstant.gray40001,
            width: 1,
          ),
          borderRadius: _setOutlineBorderRadius(),
        );
      default:
        return RoundedRectangleBorder(
          side: BorderSide(
            color: ColorConstant.gray500,
            width: 1,
          ),
          borderRadius: _setOutlineBorderRadius(),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
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
}

enum CheckboxShape { RoundedBorder3 }

enum CheckboxVariant { OutlineGray500, OutlineGray40001 }

enum CheckboxFontStyle { InterRegular12 }
