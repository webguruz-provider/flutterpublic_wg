import 'package:foodguru/app_values/export.dart';

class AboutUsController extends GetxController{
  RxList<String> aboutList=<String>[
    TextFile.termsOfService.tr,
    TextFile.appVersion.tr,
    TextFile.openSourceLibraries.tr,
    TextFile.licenseAndRegistration.tr,
  ].obs;


}