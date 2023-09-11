import 'package:foodguru/app_values/export.dart';

class DataSettings{
  static bool isDBActive=GetPlatform.isWeb?false:true;
  static bool isFirebaseOn=false;
  static bool isDataAddToLocalDB=true;
  static bool isPublic=true;
  static int langugaeId=1;
  static String languageCode=typeEnglish;
}