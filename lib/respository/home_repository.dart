import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_service.dart';
import '../data/network/shared_pref_help.dart';
import '../model/dummy_onboarding_model.dart';
import '../model/error_model.dart';
import '../model/signup/user_model.dart';
import '../res/app_url.dart';
import '../utils/utils.dart';

class HomeRepository {
  final BaseApiService _apiServices = NetworkApiService();

  Future<OnBoardingModel> fetchonBoardingGetUrlData() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.onBoardingUrlfinal);
      printLog("", response);
      return response = OnBoardingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<OnBoardingModel> signIn() async {
    try {
      dynamic response = await _apiServices
          .getPostApiResponse(AppUrl.onBoardingUrlfinal, {""});
      printLog("", response);
      return response = OnBoardingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}

class ApiProvider {
  static final ApiProvider _instance = ApiProvider.private();

  ApiProvider.private();

  factory ApiProvider() {
    return _instance;
  }
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppUrl.onBoardingUrl,
      validateStatus: (state) => true,
    ),
  )..interceptors.add(CustomInterceptor());


// post with form Data 
  Future<Response> _postWithFormData(
      String apiEnd, Map<String, dynamic>? map) async {
    FormData d = FormData.fromMap(map ?? {});
    return _dio.post(apiEnd, data: d);
  }

Future register(
      String name, String email, String password, bool isAgree) async {
    final response = await _postWithFormData(
      "",
      {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password,
        "terms": isAgree
      },
    );
    print(response.data);
    if (response.statusCode == 200) {
      return true;
    }
    return ResponseError()
      ..message = response.data['message'] ?? "Something went wrong";
  }
   

  }


class CustomInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final token = SpHelper.getString(pref_access_token);
    // log("token :- $token");
    // if (token != "") {
    //   options.headers["Authorization"] = "Bearer $token";
    // }
    // return super.onRequest(options, handler);
  }
}
