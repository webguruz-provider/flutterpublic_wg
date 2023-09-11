import 'package:flutter/foundation.dart';

bool isValidString(String data) {
  return data.isNotEmpty;
}

bool isValidIndex(int data) {
  return data != -1;
}

void printLog(String tag, dynamic msg) {
  if (kDebugMode) {
    print("logs====> $tag" + " ==> " + msg.toString());
  }
}
