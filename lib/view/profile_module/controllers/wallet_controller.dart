import 'package:foodguru/app_values/export.dart';

import '../../../network/payment_module/payment_network.dart';

class WalletController extends GetxController {
  Rxn<UserDbModel> userDbModel = Rxn<UserDbModel>();
  RxInt walletValue = 0.obs;

  @override
  void onInit() async {
    await localDbGetWallet();
    super.onInit();
  }

  /*============================ Local DB Wallet ============================*/
  localDbGetWallet() async {
    await PaymentNetwork.getWalletByUserId(
      onSuccess: (value) async {
        walletValue.value = value.wallet ?? 0;
        update();
      },
    );
  }
}
