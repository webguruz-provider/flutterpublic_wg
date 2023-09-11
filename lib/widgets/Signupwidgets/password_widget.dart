// import 'package:flutter/material.dart';

// import '../../utils/constant_images.dart';
// import '../../utils/size_constant.dart';
// import '../custom_image_widget.dart';
// import '../textfield_widget.dart';

// class PasswordWidget extends StatelessWidget {
//   PasswordWidget(
//       {super.key,
//       this.hintText,
//       this.inputController,
//       this.width,
//       this.validMsg,
//       this.iconPath,
//       this.showtext,
//       this.imagEye,
//       this.obsecure});

//   String? hintText;
//   TextEditingController? inputController;
//   double? width;
//   String? validMsg;
//   String? iconPath;
//   VoidCallback? showtext;
//   String? imagEye;
//   bool? obsecure;

//   @override
//   Widget build(BuildContext context) {
//     return CustomTextFormField(
//       width: width,
//       height: 45,
     
//       focusNode: FocusNode(),
//       controller: inputController,
//       hintText: hintText,
//       margin: getMargin(top: 10),
//       padding: TextFormFieldPadding.PaddingT13,
//       prefix: Container(
//           margin: getMargin(left: 16, top: 14, right: 10, bottom: 14),
//           child: CustomImageView(svgPath: ImageConstant.imalockGreen)),
//       prefixConstraints:
//           BoxConstraints(minWidth: getSize(16.00), minHeight: getSize(16.00)),
//       suffix: InkWell(
//           onTap: showtext,
//           child: Container(
//               margin: getMargin(left: 30, top: 17, right: 17, bottom: 17),
//               child: CustomImageView(svgPath: imagEye))),
//       suffixConstraints: BoxConstraints(
//           minWidth: getHorizontalSize(16.00),
//           minHeight: getVerticalSize(10.00)),
//       isObscureText: obsecure,
//     );
//   }
// }
