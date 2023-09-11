import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../app_excaptions.dart';
import 'base_api_services.dart';

class NetworkApiService extends BaseApiService {

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: data).timeout(
            const Duration(seconds: 10),
          );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
    @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw BadRequestException(response.body.toString());
      default:
        throw FetchDataException(
            "Error accured while communicating with server with status code${response.statusCode.toString()} ");
    }
  }
}
