import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ApiResponseInterface {
  void onSuccess(
      Response response, GlobalKey<ScaffoldState> formKey, String url,
      {BuildContext context,
      SharedPreferences sharedPreferences,
      dynamic provider});
  void onFailure(Error error, BuildContext context);
  void onTokenExpired(BuildContext context, SharedPreferences sharedPreferences,
      {dynamic provider});
}
