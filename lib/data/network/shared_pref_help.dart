import 'package:shared_preferences/shared_preferences.dart';

const String pref_user_data = "pref_user_data";
const String pref_access_token = "pref_access_token";

class SpHelper {
  static late SharedPreferences _pref;
  static setPref() async {
    _pref = await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    return _pref.getString(key) ?? "";
  }

  static setString(String key, String value) {
    _pref.setString(key, value);
  }

  static clear() {
    _pref.clear();
  }
}