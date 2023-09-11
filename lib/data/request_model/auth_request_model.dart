import 'dart:convert';

import '../../app_values/export.dart';

class AuthRequestModel {
  static signupRequestModel(
      {var firstName,
      var lastName,
      var email,
      var phone,
      var uid,
      var deviceType,
      var loginType,
      var imageUrl}) {
    Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['uid'] = uid;
    data['device_type'] = deviceType;
    data['login_type'] = loginType;
    data['image_url'] = imageUrl;
    debugPrint(jsonEncode(data));
    return data;
  }

  static  addAddressRequestModel(
      {
        var address,
      var latitude,
      var longitude,
      var userId,
      var city,
      var state,
      var country,
      var pincode,
      int? addressType,
      int? isManualAddress,
      }) async {


    Map<String, dynamic> data = <String, dynamic>{};
    data[DatabaseValues.columnUserId] = userId;
    data[DatabaseValues.columnAddress] = address;
    data[DatabaseValues.columnCity] = city;
    data[DatabaseValues.columnState] = state;
    data[DatabaseValues.columnCountry] = country;
    data[DatabaseValues.columnPinCode] = pincode;
    data[DatabaseValues.columnLatitude] = latitude;
    data[DatabaseValues.columnLongitude] = longitude;
    data[DatabaseValues.columnAddressType] = addressType;
    data[DatabaseValues.columnIsManualAddress] = isManualAddress;
    debugPrint(jsonEncode(data));
    return data;
  }
}
