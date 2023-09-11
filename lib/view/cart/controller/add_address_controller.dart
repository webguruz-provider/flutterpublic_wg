import 'package:foodguru/app_values/export.dart';

class AddAddressController extends GetxController {
  CustomLoader customLoader = CustomLoader();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController? addressTextController;
  FocusNode? addressNode;
  RxBool isMannualAddress = false.obs;
  Placemark? addressPlaceMark;
  Rxn<AddressModel> addressModel = Rxn<AddressModel>();
  RxnInt selectedAddressType = RxnInt();
  final Completer<GoogleMapController> googleMapsController =
      Completer<GoogleMapController>();
  final marker = <Marker>{}.obs;
  Position? position;
  CameraPosition? cameraPosition;
  RxnString address = RxnString();

  @override
  void onInit() {
    _initalizeControllersAndNodes();
    getArguments();
    _getCurrentLocation();
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      addressModel.value = Get.arguments[keyModel];
      debugPrint(addressModel.value?.address.toString());
      selectedAddressType.value = addressModel.value?.addressType;
      if (addressModel.value?.isManualAddress == typeTrue) {
        addressTextController?.text = addressModel.value!.address!;
        isMannualAddress.value =
            addressModel.value?.isManualAddress == typeTrue;
      }
    }
  }

  _initalizeControllersAndNodes() {
    addressTextController = TextEditingController();
    addressNode = FocusNode();
  }

  void _getCurrentLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        if (addressModel.value == null) {
          _fetchUserLocation();
        } else {
          _fetchUserLocationEdit();
        }
      }
    } else {
      // Handle location services disabled
    }
  }

  void _fetchUserLocation() async {
    Position userPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position = userPosition;

    cameraPosition = CameraPosition(
        target: LatLng(userPosition.latitude, userPosition.longitude),
        zoom: 15.5);
    animateCamera(cameraPosition!);
  }

  void _fetchUserLocationEdit() async {
    Position userPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position = userPosition;

    cameraPosition = CameraPosition(
        target: LatLng(addressModel.value?.latitude ?? 0.0,
            addressModel.value?.longitude ?? 0.0),
        zoom: 15.5);
    animateCamera(cameraPosition!);
  }

  animateCamera(CameraPosition position) async {
    final controller = await googleMapsController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  Future<String> getAddress(double latitude, double longitude) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude, longitude,
          localeIdentifier: 'en_us');
      if (placemarks.isNotEmpty) {
        addressPlaceMark = placemarks[0];
        debugPrint(addressPlaceMark.toString());
        final String address = addressTextFunction(
            houseNo: addressPlaceMark?.street,
            street: addressPlaceMark?.subLocality,
            city: addressPlaceMark?.locality,
            zipCode: addressPlaceMark?.postalCode,
            state: addressPlaceMark?.administrativeArea);
        debugPrint(address);
        return address;
      }
    } catch (e) {
      print('Error: $e');
    }
    return '';
  }

  validationAndAddAddress() {
    if (isMannualAddress.value == true &&
        (addressTextController?.text == null ||
            addressTextController?.text == '')) {
      showToast(TextFile.pleaseEnterCompleteAddress.tr);
    } else if (isMannualAddress.value == true &&
        (addressTextController?.text.trim().length ?? 0) < 20) {
      showToast(TextFile.addressShouldContainAtLeast20Characters.tr);
    } else if (selectedAddressType.value == null) {
      showToast(TextFile.pleaseSelectAddressType.tr);
    } else {
      if (addressModel.value == null) {
        addAddressToLocalDB();
      } else {
        updateAddressToLocalDB();
      }
    }
  }

  addAddressToLocalDB() async {
    UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
    var addressAuth = await AuthRequestModel.addAddressRequestModel(
      address: isMannualAddress.value == true
          ? addressTextController?.text.trim()
          : address.value,
      userId: userDbModel.id,
      city: addressPlaceMark?.locality,
      pincode: addressPlaceMark?.postalCode,
      state: addressPlaceMark?.administrativeArea,
      country: addressPlaceMark?.country,
      addressType: selectedAddressType.value,
      latitude: cameraPosition?.target.latitude,
      longitude: cameraPosition?.target.longitude,
      isManualAddress: isMannualAddress.value == true ? typeTrue : typeFalse,
    );
    bool isDataAlreadyPresent = await AddressNetwork.isDuplicateEntry(
        userId: userDbModel.id,
        address: isMannualAddress.value == true
            ? addressTextController?.text.trim()
            : address.value,
        latitude: cameraPosition?.target.latitude,
        longitude: cameraPosition?.target.longitude);
    if (isDataAlreadyPresent != true) {
      await AddressNetwork.addAddress(
        data: addressAuth,
        onSuccess: () {
          Get.back(result: true);
        },
      );
    } else {
      showToast(TextFile.addressAlreadyAdded.tr);
    }
  }

  updateAddressToLocalDB() async {
    UserDbModel userDbModel = await PreferenceManger().getSavedLoginData();
    var addressAuth = await AuthRequestModel.addAddressRequestModel(
      address: isMannualAddress.value == true
          ? addressTextController?.text.trim()
          : address.value,
      userId: userDbModel.id,
      city: addressPlaceMark?.locality,
      pincode: addressPlaceMark?.postalCode,
      state: addressPlaceMark?.administrativeArea,
      country: addressPlaceMark?.country,
      addressType: selectedAddressType.value,
      latitude: cameraPosition?.target.latitude,
      longitude: cameraPosition?.target.longitude,
      isManualAddress: isMannualAddress.value == true ? typeTrue : typeFalse,
    );
    await AddressNetwork.updateAddress(
      data: addressAuth,
      id: addressModel.value?.id,
      onSuccess: () {
        Get.back(result: true);
      },
    );
  }

  addAddressToFirebase() async {
    customLoader.show(Get.overlayContext);
    var addressAuth = AuthRequestModel.addAddressRequestModel(
      address: isMannualAddress.value == true
          ? addressTextController?.text.trim()
          : address.value,
      addressType: selectedAddressType.value,
      latitude: cameraPosition?.target.latitude,
      longitude: cameraPosition?.target.longitude,
    );
    await firestore
        .collection(firebaseUsers)
        .doc(auth.currentUser?.uid)
        .collection(firebaseAddresses)
        .doc()
        .set(addressAuth)
        .then((value) {
      customLoader.hide();
      Get.back();
    }).onError((error, stackTrace) {
      customLoader.hide();
      showToast(error.toString());
    });
  }
}
