import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodguru/app_values/export.dart';
import 'package:foodguru/view/authentication/controllers/sign_up_controller.dart';
import 'package:image_picker/image_picker.dart';

void showImageSourceActionSheet(BuildContext context) {
  var signUpControllerScreen=Get.find<SignUpControllerScreen>();

  getFromCamera() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera,);

    if (pickedFile != null) {
      // final bytes = await File(pickedFile.path).readAsBytes();
      signUpControllerScreen.imageFile.value = File(pickedFile.path);
    }
  }

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1800, maxWidth: 1800);

    if (pickedFile != null) {
      signUpControllerScreen.imageFile.value = File(pickedFile.path);
    }
  }

  if (Platform.isIOS) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Get.back();
              getFromCamera();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            onPressed: () {
              Get.back();
              getFromGallery();
            },
          )
        ],
      ),
    );
  } else {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Camera'),
          onTap: () {
            Get.back();
            getFromCamera();
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo_album),
          title: const Text('Gallery'),
          onTap: () {
            Get.back();
            getFromGallery();
          },
        ),
      ]),
    );
  }
}
