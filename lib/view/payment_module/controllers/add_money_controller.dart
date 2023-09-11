import 'package:foodguru/app_values/export.dart';

import '../../../network/payment_module/payment_network.dart';

class AddMoneyController extends GetxController {
  TextEditingController? amountController;
  FocusNode? amountNode;
  RxString amount = ''.obs;
  bool fromWallet = false;


  @override
  void onInit() {
    initializeControllerAndNode();
    getArguments();
    amountControllerListener();
    super.onInit();
  }

  getArguments(){
    if(Get.arguments!=null){
      fromWallet=Get.arguments[keyFromWallet];
    }
  }


  initializeControllerAndNode() {
    amountController = TextEditingController();
    amountNode = FocusNode();
  }

  amountControllerListener() {
    amountController?.addListener(() {
      amount.value = amountController?.text.trim() ?? '';

    });
  }



}
