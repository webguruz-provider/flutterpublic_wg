import 'package:foodguru/app_values/export.dart';

class AddressListController extends GetxController {
  CustomLoader customLoader = CustomLoader();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxnInt selectedAddress = RxnInt();
  RxList<AddressModel> addressList = <AddressModel>[].obs;
  bool fromProfileView = false;
  bool fromHomeView = false;
  @override
  void onInit() {
    // getAddressStream();
    getArguments();
    getAddressList();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null ) {
      fromProfileView = Get.arguments[fromProfileKey] ?? false;
      fromHomeView = Get.arguments[fromHomeKey] ?? false;
    }
  }

  deleteAddress(String completeAddress) async {
    customLoader.show(Get.overlayContext);
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(firebaseUsers)
        .doc(auth.currentUser?.uid)
        .collection(firebaseAddresses)
        .where('complete_address', isEqualTo: completeAddress)
        .get();

    await firestore
        .collection(firebaseUsers)
        .doc(auth.currentUser?.uid)
        .collection(firebaseAddresses)
        .doc(snapshot.docs[0].id)
        .delete()
        .then((value) {
      customLoader.hide();

      showToast(TextFile.addressDeletedSuccessfully.tr);
    }).onError((error, stackTrace) {
      customLoader.hide();
      debugPrint(error.toString());
    });
  }

  Stream<List<AddressModel>> getAddressStream() {
    return FirebaseFirestore.instance
        .collection(firebaseUsers)
        .doc(auth.currentUser?.uid)
        .collection(firebaseAddresses)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((document) {
              Map<String, dynamic> data = document.data();

              return AddressModel(
                address: data['complete_address'],
                addressType: data['address_type'],
                longitude: data['longitude'],
                latitude: data['latitude'],
              );
            }).toList());
  }

  getAddressList() async {
    await AddressNetwork.getAllAddressList().then((value) {
      addressList.value = value ?? [];
    });
  }
}
