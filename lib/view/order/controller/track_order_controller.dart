import 'dart:math';

import 'package:foodguru/app_values/export.dart';

class TrackOrderController extends GetxController {
  final Completer<GoogleMapController> googleMapsController =
      Completer<GoogleMapController>();
  TextEditingController? amountController;
  StreamSubscription<Position>? positionStream;
  Rxn<OrderDataModel> orderModel = Rxn<OrderDataModel>();
  RxnInt id = RxnInt();
  Rxn<UserDbModel> driverDetails = Rxn<UserDbModel>();
  final Set<Polyline> polyline = <Polyline>{}.obs;
  final Set<Marker> markers = <Marker>{}.obs;
  PolylinePoints polylinePoints = PolylinePoints();
  RxString amount = ''.obs;
  RxnInt otp = RxnInt();
  List<LatLng> latLngList = [];
  LatLng resLatLng = const LatLng(30.376017516404367, 76.77951446992077);
  LatLng homeLatLng = const LatLng(30.359453, 76.788537);
  // LatLng? resLatLng;
  // LatLng? homeLatLng;
  BitmapDescriptor? resMarkerIcon;
  BitmapDescriptor? homeMarkerIcon;
  BitmapDescriptor? deliveryGuyMarkerIcon;
  Timer? timer;
  int cancellationTimer = 30;
  RxDouble cancellationProgress = 0.0.obs;
  Position? position;
  RxnString address = RxnString();
  CameraPosition? cameraPosition;
  bool fromOrderFlow = false;

  @override
  Future<void> onInit() async {
    amountController = TextEditingController();
    getArguments();
    getDriverDetails();
    getOrderDetails();
    getOtp();
    cancelTimerFunction();
    _getCurrentLocation();
    super.onInit();
  }

  getOtp() {
    otp.value = Random().nextInt(9999);
    debugPrint(otp.value.toString());
  }

  getArguments() {
    if (Get.arguments != null) {
      if (Get.arguments[fromOrderFlowKey] != null) {
        fromOrderFlow = Get.arguments[fromOrderFlowKey];
      }
      if (Get.arguments[keyId] != null) {
        id.value = Get.arguments[keyId];
      }
    }
  }

  cancelTimerFunction() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (cancellationTimer > 0) {
        cancellationTimer--;
        cancellationProgress.value = 1 - (cancellationTimer / 30);
        debugPrint(cancellationProgress.value.toString());
      } else {
        timer.cancel();
      }
    });
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
        _fetchUserLocation();

        final Uint8List deliveryGuyMarker =
            await getBytesFromAsset(ImageConstant.imagesIcDeliveryGuy, 150);
        deliveryGuyMarkerIcon = BitmapDescriptor.fromBytes(deliveryGuyMarker);
        positionStream = Geolocator.getPositionStream(
                locationSettings:
                    LocationSettings(accuracy: LocationAccuracy.high))
            .listen((Position userPosition) {
          position = userPosition;
          debugPrint('${position?.longitude},${position?.latitude}');
          cameraPosition = CameraPosition(
              target: LatLng(userPosition.latitude, userPosition.longitude),
              zoom: 15.5);
          markers.removeWhere((m) => m.markerId.value == 'sourcePin');
          markers.add(Marker(
              markerId: MarkerId('sourcePin'),
              position:
                  LatLng(userPosition.latitude, userPosition.longitude), // up
              icon: BitmapDescriptor.fromBytes(deliveryGuyMarker)));
        });
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
  }

  animateCamera(CameraPosition position) async {
    final controller = await googleMapsController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  polyLineWork() async {
    latLngList.add(resLatLng!);
    latLngList.add(homeLatLng!);
    final Uint8List resMarkerIcon8 =
        await getBytesFromAsset(ImageConstant.imagesIcMapRes, 100);
    final Uint8List homeMarkerIcon8 =
        await getBytesFromAsset(ImageConstant.imagesIcMapHome, 100);
    resMarkerIcon = BitmapDescriptor.fromBytes(resMarkerIcon8);
    homeMarkerIcon = BitmapDescriptor.fromBytes(homeMarkerIcon8);
    markers.add(Marker(
        markerId: MarkerId('1'),
        position: resLatLng!,
        icon: resMarkerIcon ?? BitmapDescriptor.defaultMarker));
    markers.add(Marker(
        markerId: MarkerId('2'),
        position: homeLatLng!,
        icon: homeMarkerIcon ?? BitmapDescriptor.defaultMarker));
    //Code For Getting Directions between two points
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //     apiKey,
    //     PointLatLng(resLatLng.latitude, resLatLng.longitude),
    //     PointLatLng(homeLatLng.latitude, homeLatLng.longitude),
    //     travelMode: TravelMode.driving);
    //
    //     if (result.points.isNotEmpty) {
    //       result.points.forEach((element) {
    //         latLngList.add(LatLng(element.latitude, element.longitude));
    //       });
    //     } else {}
    LatLngBounds bounds = calculateBounds(latLngList);
    final controller = await googleMapsController.future;
    adjustCameraToBounds(controller, bounds);
    polyline.add(Polyline(
        polylineId: PolylineId('value'),
        visible: true,
        points: latLngList,
        patterns: [],
        width: 4,
        color: Colors.black));
  }

  LatLngBounds calculateBounds(List<LatLng> points) {
    double minLat = double.infinity;
    double maxLat = double.negativeInfinity;
    double minLng = double.infinity;
    double maxLng = double.negativeInfinity;

    for (LatLng point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    LatLng southwest = LatLng(minLat, minLng);
    LatLng northeast = LatLng(maxLat, maxLng);

    return LatLngBounds(southwest: southwest, northeast: northeast);
  }

  void adjustCameraToBounds(
      GoogleMapController controller, LatLngBounds bounds) {
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  void changeMapMode(GoogleMapController mapController) {
    getJsonFile(ImageConstant.jsonDataMapViewJson)
        .then((value) => setMapStyle(value, mapController));
  }

  getDriverDetails() async {
    driverDetails.value = await getUserDetailsById(id: 1);
  }

  getOrderDetails() async {
    await OrderNetwork.getOrderById(id).then((value) async {
      orderModel.value = value;
      orderModel.value?.orderItemList =
          await OrderItemNetwork.getOrderItemsList(orderModel.value?.id);
      orderModel.value?.orderItemList?.forEach((element) async {
        element.images =
            await ItemImagesNetwork.getItemImagesById(element.itemId);
      });
      homeLatLng = LatLng(orderModel.value?.addressLatitude,
          orderModel.value?.addressLongitude);
      resLatLng = LatLng(
          orderModel.value?.outletLatitude, orderModel.value?.outletLongitude);
      polyLineWork();
    });
    orderModel.refresh();
  }

  @override
  void dispose() {
    timer?.cancel();
    positionStream?.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    timer?.cancel();
    positionStream?.cancel();
    super.onClose();
  }
}
