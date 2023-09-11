import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:foodguru/app_values/export.dart';

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rxn<File> imageFile = Rxn<File>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode dobNode = FocusNode();
  FocusNode phoneNumberNode = FocusNode();
  Rxn<DateTime> dateOfBirth = Rxn<DateTime>();
  Rxn<UserDbModel> userDbModel = Rxn<UserDbModel>();

  void showImageSourceActionSheet(BuildContext context) {
    getFromCamera() async {
      XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera, maxHeight: 1800, maxWidth: 1800);

      if (pickedFile != null) {
        // final bytes = await File(pickedFile.path).readAsBytes();
        imageFile.value = File(pickedFile.path);
      }
    }

    getFromGallery() async {
      XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery, maxHeight: 1800, maxWidth: 1800);

      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
      }
    }

    if (GetPlatform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) =>
            CupertinoActionSheet(
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
        builder: (context) =>
            Wrap(children: [
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

  @override
  void onInit() async {
    await getSavedLoginData();

    super.onInit();
    initalizeData();
  }

  getSavedLoginData() async {
    userDbModel.value = await PreferenceManger().getSavedLoginData();
    print(userDbModel.value);
  }

  void initalizeData() {
    firstNameController.text = userDbModel.value?.firstName ?? "";
    lastNameController.text = userDbModel.value?.lastName ?? "";
    emailController.text = userDbModel.value?.email ?? "";
    phoneNumberController.text = userDbModel.value?.phone ?? "";
    dobController.text = userDbModel.value?.dob ?? "";
    if (userDbModel.value?.imageUrl != null &&
        userDbModel.value?.imageUrl != "")
      imageFile.value = File(userDbModel.value?.imageUrl ?? "");
  }

/*============================ Local DB Edit Profile ============================*/
  localDbEditProfile() async {
    updateProfile(
      userDbModel: UserDbModel(
        id: userDbModel.value?.id,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: userDbModel.value?.password,
        createdOn: userDbModel.value?.createdOn,
        loginType: userDbModel.value?.loginType,
        phone: phoneNumberController.text.trim(),
        dob: dobController.text.trim(),
        deviceType: Platform.isAndroid ? 'Android' : 'Ios',
        imageUrl: (imageFile.value != null) ? imageFile.value!.path : "",
      ),
      onSuccess: () async {
        List<Map<String, dynamic>>? itemMaps1 =
        await databaseHelper.getItems(DatabaseValues.tableUser);
        List<UserDbModel> userData =
        itemMaps1!.map((element) => UserDbModel.fromMap(element)).toList();
        int index = userData.indexWhere(
                (element) => element.email == emailController.text.trim());
        PreferenceManger().saveRegisterData(userData[index]);
        await NotificationMainNetwork.addNotificationsMain(
          reference: 'profile_edited',
          title: 'Profile Edit Successful',
          notificationType: 3,
          description: 'Your Profile is Edited Successfully',);
        showToast(TextFile.userProfileUpdateSuccessfully.tr);
        // Get.offAllNamed(AppRoutes.mainScreen);
      },
    );
  }
}
