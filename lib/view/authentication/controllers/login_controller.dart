import 'package:foodguru/app_values/export.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  bool checkBox = false;
  RxBool isVisiblePassword = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  final StreamController<bool> checkBoxController = StreamController();

  Stream<bool> get checkBoxStream => checkBoxController.stream;
  final Uri toLaunch = Uri(scheme: 'https', host: 'www.Google.com');

/*============================ Local DB Login ============================*/
  localDbLogin() async {
    if(DataSettings.isDBActive==true){
      login(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          onSuccess: () async {
            List<Map<String, dynamic>>? itemMaps1 =
            await databaseHelper.getItems(DatabaseValues.tableUser);
            List<UserDbModel> userData = itemMaps1!
                .map((element) => UserDbModel.fromMap(element))
                .toList();
            int index = userData.indexWhere(
                    (element) => element.email == emailController.text.trim());
            PreferenceManger().saveRegisterData(userData[index]);
            Get.offAllNamed(AppRoutes.mainScreen);
            showToast(TextFile.loginSuccessful.tr);
          });
    }else{
      Get.offAllNamed(AppRoutes.mainScreen);
    }

  }

/*============================ Firebase Login ============================*/
  firebaseLogin() async {
    try {
      customLoader?.show(Get.overlayContext);
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      customLoader?.hide();
      Get.offAllNamed(AppRoutes.mainScreen);
      showToast(TextFile.loginSuccessful.tr);
    } on FirebaseException catch (e) {
      customLoader?.hide();
      if (e.code == 'user-not-found') {
        showToast(TextFile.noUserFoundWithEmail.tr);
      } else if (e.code == 'wrong-password') {
        showToast(TextFile.incorrectPassword.tr);
      }
    } catch (e) {
      customLoader?.hide();
      debugPrint(e.toString());
    }
  }

/*============================ Google Signin ============================*/

  Future googleLogin() async {
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
      showToast('User Logged in Successfully');
    } catch (e) {
      customLoader?.hide();
      debugPrint('Error $e');
    }
  }

/*============================ Value Assigning Google Signin ============================*/

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
