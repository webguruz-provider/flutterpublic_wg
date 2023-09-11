import 'dart:io';
import 'package:foodguru/app_values/export.dart';

class SignUpControllerScreen extends GetxController {
  final formKey = GlobalKey<FormState>();
  final StreamController<bool> checkBoxController = StreamController();

  Stream<bool> get checkBoxStream => checkBoxController.stream;
  final _myRepo = ApiProvider();
  bool checkBox = false;
  RxBool isVisiblePassword = false.obs;
  RxBool isVisibleConfirmPassword = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  TextEditingController firstNameContoller = TextEditingController();
  TextEditingController lastNameContoller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();
  FocusNode phoneNumberNode = FocusNode();
  final googleSignIn = GoogleSignIn;
  GoogleSignInAccount? _googleSignUp;

  GoogleSignInAccount get googleSign => _googleSignUp!;
  Rxn<File> imageFile = Rxn<File>();
  bool isShowPassword = false;
  var imageUrlUpload;

  void togglePasswordView() {
    isShowPassword = !isShowPassword;
  }

  final Uri toLaunch = Uri(scheme: 'https', host: 'www.Google.com');

/*============================ Local Database ============================*/
  localDbSignup() async {
    signUp(
      userDbModel: UserDbModel(
        firstName: firstNameContoller.text.trim(),
        lastName: lastNameContoller.text.trim(),
        email: emailController.text.trim(),
        phone: phoneNumberController.text.trim(),
        deviceType: Platform.isAndroid ? 'Android' : 'Ios',
        password: passwordController.text.trim(),
        loginType: typeEmail,
        imageUrl: imageUrlUpload,
      ),
      onSuccess: () async {
        List<Map<String, dynamic>>? itemMaps1 =
            await databaseHelper.getItems(DatabaseValues.tableUser);
        List<UserDbModel> userData =
            itemMaps1!.map((element) => UserDbModel.fromMap(element)).toList();
        int index = userData.indexWhere(
            (element) => element.email == emailController.text.trim());
        PreferenceManger().saveRegisterData(userData[index]);
        Get.offAllNamed(AppRoutes.mainScreen);
        showToast(TextFile.userSignedUpSuccessfully.tr);

        await PaymentNetwork.addPoints(
          onSuccess: () {
           print("test");
          },
        );
        await PaymentNetwork.addWallet(
          onSuccess: () {
            print("test");
          },
        );
      },
    );

    // _createTable();
    // _insertTable();
  }

  /*Create Table*/
  _createTable() async {
    // ${DatabaseValues.columnPassword} TEXT NOT NULL, we cant save user's
    // Password so this should be removed

    await databaseHelper.createtables(databaseHelper.db!,
        tableName: DatabaseValues.tableUser,
        executeCommamd: """CREATE TABLE ${DatabaseValues.tableUser} (
      ${DatabaseValues.columnId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${DatabaseValues.columnFirstName} TEXT NOT NULL,
      ${DatabaseValues.columnLastName} TEXT NOT NULL,
      ${DatabaseValues.columnEmail} TEXT NOT NULL,
      ${DatabaseValues.columnImageUrl} TEXT,
      ${DatabaseValues.columnLoginType} TEXT,
      ${DatabaseValues.columnPhone} TEXT,
      ${DatabaseValues.columnPassword} TEXT NOT NULL,
      ${DatabaseValues.columnDeviceType} TEXT,
      ${DatabaseValues.createdOn} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

  /*Insert Data to Table*/
  _insertTable() async {
    //Fetching List
    List<Map<String, dynamic>>? itemMaps =
        await databaseHelper.getItems(DatabaseValues.tableUser);
    if (itemMaps != null) {
      List<UserDbModel> items =
          itemMaps.map((element) => UserDbModel.fromMap(element)).toList();
      int index = items.indexWhere(
          (element) => element.email == emailController.text.trim());
      if (index == -1) {
        int index1 = items.indexWhere(
            (element) => element.phone == phoneNumberController.text.trim());
        if (index1 == -1) {
          await databaseHelper
              .insertItem(DatabaseValues.tableUser,
                  model: UserDbModel(
                    firstName: firstNameContoller.text.trim(),
                    lastName: lastNameContoller.text.trim(),
                    email: emailController.text.trim(),
                    phone: phoneNumberController.text.trim(),
                    deviceType: Platform.isAndroid ? 'Android' : 'Ios',
                    password: passwordController.text.trim(),
                    loginType: typeEmail,
                    imageUrl: imageUrlUpload,
                  ))
              .then((value) {
            showToast(TextFile.userSignedUpSuccessfully.tr);
          }).onError((error, stackTrace) {
            showToast(error.toString());
          });
        } else {
          showToast(TextFile.userAlreadyExistsWithSamePhoneNumber.tr);
        }
      } else {
        showToast(TextFile.userAlreadyExistsWithSameEmailID.tr);
      }
    } else {
      debugPrint('Failed to fetch items from the database.');
    }
  }

/*============================ Firebase Signup ============================*/
  Future firebseSignUp() async {
    customLoader?.show(Get.overlayContext!);
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (imageFile.value != null) {
        final Reference storageReference = firebaseStorage
            .ref()
            .child('user_images')
            .child(credential.user?.uid ?? '')
            .child('profile_img.jpg');
        final UploadTask uploadTask =
            storageReference.putFile(File(imageFile.value?.path ?? ''));
        final TaskSnapshot uploadSnapshot = await uploadTask;
        imageUrlUpload = await uploadSnapshot.ref.getDownloadURL();
      }
      credential.user?.updateDisplayName(
          '${firstNameContoller.text.trim()} ${lastNameContoller.text.trim()}');
      credential.user?.updatePhotoURL(imageUrlUpload);
      var signupAuth = AuthRequestModel.signupRequestModel(
        firstName: firstNameContoller.text.trim(),
        lastName: lastNameContoller.text.trim(),
        email: emailController.text.trim(),
        phone: phoneNumberController.text.trim(),
        uid: credential.user?.uid,
        deviceType: Platform.isAndroid ? 'Android' : 'Ios',
        loginType: typeEmail,
        imageUrl: imageUrlUpload,
      );
      await fireStore
          .collection(firebaseUsers)
          .doc(credential.user?.uid)
          .set(signupAuth);
      customLoader?.hide();
      Get.offAllNamed(AppRoutes.mainScreen);
      showToast(TextFile.userSignedUpSuccessfully.tr);
    } on FirebaseAuthException catch (e) {
      customLoader?.hide();

      if (e.code == 'email-already-in-use') {
        showToast(TextFile.userAlreadyExistsWithSameEmailID.tr);
      }
    } catch (e) {
      customLoader?.hide();
      print(e);
    }
  }

/*============================ Google Signup ============================*/
  Future googleSignUp() async {
    try {
      customLoader?.show(Get.overlayContext!);
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>["email"]).signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      UserCredential result = await auth.signInWithCredential(credential);
      User? user = result.user;
      //For Check if User's Details are available on firestore
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await fireStore.collection(firebaseUsers).doc(user?.uid).get();

      if (snapshot.exists) {
        //if Exist we will update the values insted of adding or replacing
        var signupAuth = _valueAssigningGoogleSignin(user);
        //Update
        await fireStore
            .collection(firebaseUsers)
            .doc(user?.uid)
            .update(signupAuth);
      } else {
        // User does not exist, add data to Firestore
        var signupAuth = _valueAssigningGoogleSignin(user);

        //Add
        await fireStore
            .collection(firebaseUsers)
            .doc(user?.uid)
            .set(signupAuth);
      }
      customLoader?.hide();
      Get.offAllNamed(AppRoutes.mainScreen);
      showToast(TextFile.userSignedUpSuccessfully.tr);
    } catch (e) {
      customLoader?.hide();
      debugPrint('Error $e');
    }
  }

/*============================ Values Assigning Google Signup ============================*/
  _valueAssigningGoogleSignin(User? user) {
    String? userFullName = user?.displayName;
    List<String>? nameParts = userFullName?.split(' ');
    return AuthRequestModel.signupRequestModel(
        firstName: nameParts?.sublist(0, nameParts.length - 1).join(' '),
        lastName: nameParts?.last ?? '',
        email: user?.email,
        phone: user?.phoneNumber ?? '',
        uid: user?.uid,
        deviceType: GetPlatform.isAndroid ? 'Android' : 'Ios',
        loginType: typeGoogle,
        imageUrl: user?.photoURL);
  }
}
