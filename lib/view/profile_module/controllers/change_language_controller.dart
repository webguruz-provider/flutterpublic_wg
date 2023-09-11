import 'package:foodguru/app_values/export.dart';

class ChangeLanguageController extends GetxController {
  TextEditingController? searchController;
  FocusNode? searchNode;
  RxInt selectedLanguage = 0.obs;
  RxString selectedLangCode = ''.obs;
  RxList<LanguageModel> languageList = <LanguageModel>[].obs;
  List<LanguageModel> tempLanguageList = [];

  @override
  void onInit() {
    fetchLanguageList();
    selectedLangCode.value = PreferenceManger().getLanguage()?.languageCode ??
        Get.deviceLocale!.languageCode;
    initializeControllersAndNodes();
    super.onInit();
  }

  initializeControllersAndNodes() {
    searchController = TextEditingController();
    searchNode = FocusNode();
  }

  searchFunction(String value) {
    languageList.value = [];
    if (value.isNotEmpty) {
      for (int i = 0; i < tempLanguageList.length; i++) {
        if (tempLanguageList[i]
            .title!
            .toLowerCase()
            .contains(value.toLowerCase())) {
          languageList.add(
            tempLanguageList[i],
          );
        }
      }
    } else {
      languageList.value = tempLanguageList;
    }
    update();
  }

  fetchLanguageList() async {
    await LanguageNetwork.getAllLanguageList().then((value) {
      languageList.value = value ?? [];
      tempLanguageList = languageList.value;
    });
  }
}
