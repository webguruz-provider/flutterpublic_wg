import 'package:foodguru/app_values/export.dart';

class PreferenceManger {
  static const String locale = "locale";
  static const String userModel = "userModel";
  static const String isFirstTime = "isFirstTime";
  static const String locationSelected = "locationSelected";
  static const String idLanguage = "idLanguage";
  static const String notificationToggle = "notificationToggle";

  firstLaunch(bool? isFirstCheck) {
    localStorage.write(isFirstTime, isFirstCheck).onError((error, stackTrace) {
      debugPrint(error.toString());
      return false;
    });
    debugPrint(localStorage.read(isFirstTime).toString());
  }

  setNotificationToggle(bool? value) {
    localStorage.write(notificationToggle, value).onError((error, stackTrace) {
      debugPrint(error.toString());
      return false;
    });
    debugPrint(localStorage.read(notificationToggle).toString());
  }

  getStatusFirstLaunch() {
    return localStorage.read(isFirstTime) ?? false;
  }

  getStatusNotificationToggle() {
    return localStorage.read(notificationToggle) ?? false;
  }

  selectedLocation(String? location) {
    localStorage.write(locationSelected, location).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
    debugPrint(localStorage.read(locationSelected).toString());
  }

  getSelectedLocation() {
    return localStorage.read(locationSelected) ?? '';
  }

  setLanguage(String? localeValue) {
    localStorage.write(locale, localeValue);
  }

  setLanguageId(int? languageId) {
    localStorage.write(idLanguage, languageId);
  }

  Locale? getLanguage() {
    final languageTag = localStorage.read(locale) as String?;
    if (languageTag != null) {
      return Locale(languageTag);
    } else {
      return null;
    }
  }

  getLanguageId() async {
    final languageId = localStorage.read(idLanguage) as int?;
    if (languageId != null) {
      return languageId;
    } else {
      return null;
    }
  }

  saveRegisterData(UserDbModel? model) async {
    localStorage.write(userModel, jsonEncode(model));
    debugPrint(model?.email);
  }

  Future getSavedLoginData() async {
    Map<String, dynamic>? userMap;
    final userStr = await localStorage.read(userModel);
    if (userStr != null) userMap = jsonDecode(userStr) as Map<String, dynamic>;
    if (userMap != null) {
      UserDbModel user = UserDbModel.fromMap(userMap);
      return user;
    }
    return null;
  }

  clearLoginData() {
    localStorage.remove(userModel);
  }
}
