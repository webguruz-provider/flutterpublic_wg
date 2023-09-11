import 'package:foodguru/app_values/export.dart';
import 'package:foodguru/network/payment_module/payment_network.dart';

class PointsController extends GetxController{

  Rxn<UserDbModel> userDbModel = Rxn<UserDbModel>();
  RxInt pointValue= 0.obs;

  @override
  void onInit() async{
    await  localDbGetPoints();
    super.onInit();
  }

  /*============================ Local DB Points ============================*/
  localDbGetPoints() async {
    await PaymentNetwork.getPointsByUserId(
      onSuccess: (value) async {
        pointValue.value = value.points ?? 0;

       // showToast(TextFile.userProfileUpdateSuccessfully.tr);
        // Get.offAllNamed(AppRoutes.mainScreen);

      },
    );
  }

}