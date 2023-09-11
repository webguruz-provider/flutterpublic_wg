import 'dart:io';

import 'package:foodguru/app_values/export.dart';

class HomeController extends GetxController {
  Rxn<UserDbModel> userDbModel = Rxn<UserDbModel>();

  var currentLocation = "";
  Rxn<File> imageFile = Rxn<File>();
  RxList<RestaurantItemDataModel> restaurantList =
      <RestaurantItemDataModel>[].obs;
  RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;
  int selectedTab = 1;
  List<CouponModel> specialOfferList = <CouponModel>[];
  int currentIndex = 0;
  List<ItemModel> itemsList = <ItemModel>[];
  List<ItemModel> recentlyOrderedList = <ItemModel>[];
  List<ItemModel> recommendedList = <ItemModel>[];
  ItemModel seasonalSpecial = ItemModel();
  String? currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast('Location services are disabled. Please enable the services');

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast('Location permissions are denied');

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showToast(
          'Location permissions are permanently denied, we cannot request permissions.');

      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      currentAddress =
          '${place.subLocality}, ${place.locality}, ${place.administrativeArea}';
      currentLocation = currentAddress!;
      PreferenceManger().selectedLocation(currentAddress);
      update();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void onInit() async {
    getRegisterData();
    fetchRestaurantList();
    fetchCategoryList();
    getAllItemDetails();
    getSpecialOffers();
    getSeasonalSpecial();
    getRecentlyOrderedList();
    getRecommendedItemsList();
    locationFetch();
    super.onInit();
  }

  refreshAllLists(){
    getRegisterData();
    fetchRestaurantList();
    fetchCategoryList();
    getAllItemDetails();
    getSpecialOffers();
    getSeasonalSpecial();
    getRecentlyOrderedList();
    getRecommendedItemsList();
    locationFetch();
  }



  locationFetch() async {
    if (PreferenceManger().getSelectedLocation() == "") {
      currentAddress = "Location Fetching....";
      update();
      _getCurrentPosition();
    } else {
      currentAddress = await PreferenceManger().getSelectedLocation();
      update();
    }
  }

  getRegisterData() async {
    userDbModel.value = await PreferenceManger().getSavedLoginData();
    debugPrint(jsonEncode(userDbModel.value));
    if (userDbModel.value?.imageUrl != null &&
        userDbModel.value?.imageUrl != "")
      imageFile.value = File(userDbModel.value?.imageUrl ?? "");
  }

  fetchRestaurantList() async {
    await OutletNetwork.getAllRestaurantList().then((value) {
      restaurantList.value = value ?? [];
    });
    update();
  }

  fetchCategoryList() async {
    await CategoriesNetwork.getAllCategoriesList().then((value) {
      categoriesList.value = value ?? [];
    });
    update();
  }

  getAllItemDetails() async {
    await ItemNetwork.getAllItemsList().then((value) {
      itemsList = value!;
    });
    update();
  }

  getSpecialOffers() async {
    await CouponNetwork.getAllCoupons().then((value) {
      specialOfferList = value;
      update();
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  getSeasonalSpecial() async {
    await ItemNetwork.getRandomSeasonalItem().then((value) {
      seasonalSpecial = value!;
    }).onError((error, stackTrace) {
      debugPrint('getSeasonalSpecial ${error.toString()}');
    });
  }
  getRecentlyOrderedList() async {
    await ItemNetwork.recentlyOrderedList().then((value) {
      recentlyOrderedList = value!;
    }).onError((error, stackTrace) {
      debugPrint('getSeasonalSpecial ${error.toString()}');
    });
  }
  getRecommendedItemsList() async {
    await ItemNetwork.recommendedItemsList().then((value) {
      recommendedList = value!;
    }).onError((error, stackTrace) {
      debugPrint('getSeasonalSpecial ${error.toString()}');
    });
  }

}
