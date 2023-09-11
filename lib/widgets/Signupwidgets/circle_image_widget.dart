import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/color.dart';
import '../../utils/constant_images.dart';
import '../../utils/size_constant.dart';

class CircleImageWidget extends StatelessWidget {
  CircleImageWidget({super.key, this.cameraClick, this.image});

  VoidCallback? cameraClick;
  File? image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      width: 105,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          image == null
              ? Container(
                  height: getSize(95.00),
                  width: getSize(95.00),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 8,
                        offset: const Offset(1, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                      backgroundColor: ColorConstant.blueGray50,
                      child: Center(
                          child: SvgPicture.asset(
                        ImageConstant.imgFile,
                        height: getSize(height / 20),
                        width: getSize(height / 20),
                      ))),
                )
              : ClipRRect(
            borderRadius: BorderRadius.circular(getSize(100)),
                child: Image.file(
                    image!,
                    height: getSize(95.0),
                    width: getSize(95.0),
                    fit: BoxFit.cover,
                  ),
              ),
          Positioned(
              bottom: -10,
              right: -30,
              child: RawMaterialButton(
                  onPressed: cameraClick,
                  elevation: 2.0,
                  fillColor: ColorConstant.greenA700,
                  padding: const EdgeInsets.all(5.0),
                  shape: const CircleBorder(),
                  child: SvgPicture.asset(
                    ImageConstant.imgCamera,
                  ))),
        ],
      ),
    );
  }
}
