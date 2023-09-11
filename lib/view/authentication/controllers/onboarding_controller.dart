import 'package:foodguru/app_values/export.dart';
import 'package:foodguru/data/response/api_response.dart';
import 'package:foodguru/model/dummy_onboarding_model.dart';
import 'package:foodguru/respository/home_repository.dart';

class OnBoardingController extends GetxController {
  final _myRepo = HomeRepository();
  bool isLocal = true;
  List onBoardingList = [];
  dynamic onBoardingData;

  @override
  void onInit() {
    isLocal ? readJson() : fetchOnBoarding();
    super.onInit();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/JsonData/onBoardingData.json');
    onBoardingData = await json.decode(response);
    onBoardingList = onBoardingData["items"];
    update();
  }

  ApiResponse<OnBoardingModel> onBoardingLists = ApiResponse.loading();

  setOnBoardingList(ApiResponse<OnBoardingModel> response) {
    onBoardingLists = response;
    update();
  }

  Future<void> fetchOnBoarding() async {
    setOnBoardingList(ApiResponse.loading());

    _myRepo.fetchonBoardingGetUrlData().then((value) {
      setOnBoardingList(ApiResponse.completed(value));
      update();
    }).onError((error, stackTrace) {
      setOnBoardingList(ApiResponse.error(error.toString()));
      update();
    });
  }
}
