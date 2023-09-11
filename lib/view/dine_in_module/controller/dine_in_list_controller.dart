import 'package:foodguru/app_values/export.dart';

class DineInListController extends GetxController {
  TextEditingController? searchController;
  FocusNode? searchNode;
  BitmapDescriptor? restaurantMarkerLocation;

  Rxn<RestaurantItemDataModel> selectedRestaurant =
      Rxn<RestaurantItemDataModel>();
  Location location = Location();

  final Set<Marker> markers = <Marker>{}.obs;
  final Completer<GoogleMapController> googleMapsController =
      Completer<GoogleMapController>();
  bool isMapView = false;
  RxList<RestaurantItemDataModel> tempDineInList = <RestaurantItemDataModel>[].obs;
  RxList<RestaurantItemDataModel> dineInList = <RestaurantItemDataModel>[].obs;
  RxList<RestaurantItemDataModel> searchList = <RestaurantItemDataModel>[].obs;
  Position? position;
  CameraPosition? cameraPosition;

  @override
  void onInit() {
    _initializeTextFieldsAndNodes();
    searchController?.addListener(() {
      searchFunction(searchController?.text ?? '');
    });
    _getCurrentLocation();
    fetchRestaurantList();
    fetchSearchRestaurantList();
    super.onInit();
  }

  _initializeTextFieldsAndNodes() {
    searchController = TextEditingController();
    searchNode = FocusNode();
  }

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      _fetchUserLocation();
    }
  }

  void _fetchUserLocation() async {
    try {
      Position userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      position = userPosition;
      cameraPosition = CameraPosition(
          target: LatLng(userPosition.latitude, userPosition.longitude),
          zoom: 15.5);
      animateCamera(cameraPosition!);
    } catch (e) {
      Get.dialog(LocationServiceDisabledDialog());
    }
  }

  animateCamera(CameraPosition position) async {
    final controller = await googleMapsController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  setMarkers() async {
    final Uint8List restaurantMarker =
        await getBytesFromAsset(ImageConstant.imagesIcResMarker, 70);
    restaurantMarkerLocation = BitmapDescriptor.fromBytes(restaurantMarker);
    dineInList.forEach((element) {
      markers.add(Marker(
          draggable: false,
          onTap: () {
            selectedRestaurant.value = element;
            debugPrint(selectedRestaurant.value?.restaurantName);
            update();
          },
          markerId: MarkerId('${element.latitude},${element.longitude}'),
          infoWindow: InfoWindow(
            title: element.restaurantName,
          ),
          icon: BitmapDescriptor.fromBytes(restaurantMarker),
          position: LatLng(element.latitude ?? 0.0, element.longitude ?? 0.0)));
    });
    update();
  }

  //this is the function to load custom map style json

  void changeMapMode(GoogleMapController mapController) {
    getJsonFile(ImageConstant.jsonDataMapViewJson)
        .then((value) => setMapStyle(value, mapController));
  }

  fetchRestaurantList() async {
    await OutletNetwork.getAllDineinList().then((value) {
      dineInList.value = value ?? [];
      tempDineInList.value = dineInList.value;
    });
    update();
  }
  fetchSearchRestaurantList() async {
    await OutletNetwork.getSearchAllDineinList().then((value) {
      searchList.value = value ?? [];

    });
    update();
  }

  // searchFunction(String value) {
  //   dineInList = [];
  //   if (value.isNotEmpty) {
  //     for (int i = 0; i < tempDineInList.length; i++) {
  //       if (tempDineInList[i]
  //           .restaurantName!
  //           .toLowerCase()
  //           .contains(value.toLowerCase())) {
  //         dineInList.add(
  //           tempDineInList[i],
  //         );
  //       }
  //     }
  //   } else {
  //     dineInList = tempDineInList;
  //   }
  //   update();
  // }

  searchFunction(String value) async{
    dineInList.value = [];
    int languageId = await PreferenceManger().getLanguageId();
    if (value.isNotEmpty) {
      for (int i = 0; i < searchList.length; i++) {
        if (searchList[i].restaurantName!.toLowerCase().contains(value.toLowerCase())) {
          for(int j=0 ; j< searchList.length; j++){
            if(searchList[j].outletId == searchList[i].outletId && searchList[j].languageId == languageId ){
              dineInList.add(searchList[j]);
            }
          }

        }
      }

      dineInList.value = dineInList.toSet().toList();


    } else {
      dineInList.value = tempDineInList;
    }
    update();
  }
}
