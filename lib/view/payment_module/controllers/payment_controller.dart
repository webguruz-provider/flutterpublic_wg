import 'package:foodguru/app_values/export.dart';
import 'package:foodguru/network/payment_module/payment_network.dart';

class PaymentController extends GetxController {
  RxnInt selectedListType = RxnInt();
  RxnInt pointValue = RxnInt();
  RxnString amountToAdd = RxnString();
  RxnBool isPointUse = RxnBool();
  RxnString selectedPaymentType = RxnString();
  OrderDataSendModel? orderDataSendModel;
  List<ItemModel>? itemsList;
  RxInt walletValue= 0.obs;
  @override
  void onInit()async {
    getArguments();
    super.onInit();
    await  localDbGetWallet();
  }

  getArguments() {
    if (Get.arguments != null) {

      orderDataSendModel = Get.arguments[keyModel];
      itemsList = Get.arguments[keyList];
      if(Get.arguments[point]!=null){
        pointValue.value = Get.arguments[point].toInt();
      }
      isPointUse.value = Get.arguments[pointUse];
      amountToAdd.value=Get.arguments[keyAmountToAdd];
      debugPrint(Get.arguments.toString());
    }
  }

  RxList<PaymentModel> recommendedList = <PaymentModel>[
    PaymentModel(
        title: 'Google Pay', icon: ImageConstant.imagesIcGooglePay, id: 'r1'),
  ].obs;
  RxList<CardModel> creditCardList = <CardModel>[
    CardModel(
        cardNumber: '4111 1111 1111 1111',
        cardHolderName: 'John',
        expiry: '12/34',
        cvv: '342',
        cardType: CardType.visa),
  ].obs;
  RxList<PaymentModel> upiList = <PaymentModel>[
    PaymentModel(title: 'Paytm', icon: ImageConstant.imagesIcPaytm, id: 'u1'),
    PaymentModel(
        title: 'Phone Pe', icon: ImageConstant.imagesIcPhonePe, id: 'u2'),
    PaymentModel(
        title: 'Google Pay', icon: ImageConstant.imagesIcGooglePay, id: 'u3'),
  ].obs;
  RxList<PaymentModel> otherList = <PaymentModel>[
    PaymentModel(
        title: 'Cash on Delivery', icon: ImageConstant.imagesIcCod, id: 'o1'),
  ].obs;

  placeOrder() async {
    await OrderNetwork.addOrder(
      data: orderDataSendModel?.toJson(),
      itemList: itemsList,
      onSuccess: () async {
        await databaseHelper.deleteTable(DatabaseValues.tableCart);
       await pointsUpdate();
       if(Get.arguments[keyAmountToAdd]!=null){
         await walletUpdate();
       }else{
         if(selectedPaymentType.value=='w1'){
           await walletDeductUpdate();
         }
         Get.toNamed(AppRoutes.orderSuccessScreen);
       }


      },
    );
  }

  pointsUpdate() async {
    var points=0;

    await PaymentNetwork.getPointsByUserId(
      onSuccess: (value) async {
        points = value.points ?? 0;
      },
    );
    if((isPointUse.value) == true) points = 0;
    points = points + (pointValue.value ?? 0);
    await PaymentNetwork.updatePoints(points: points);
  }


  /*============================ Local DB Wallet ============================*/
  localDbGetWallet() async {
    await PaymentNetwork.getWalletByUserId(
      onSuccess: (value) async {
        walletValue.value = value.wallet ?? 0;
      },
    );
  }
  walletUpdate() async {
    var wallet=0;
    await PaymentNetwork.getWalletByUserId(
      onSuccess: (value) async {
        wallet = value.wallet ?? 0;
      },
    );
    wallet = wallet + (int.parse(amountToAdd.value??'0'));
    await PaymentNetwork.updateWallet(wallet: wallet,onSuccess: () {
      if(Get.arguments[keyAmountToAdd]!=null){
        Get.back(result: true);
        // Get.offNamed(AppRoutes.walletScreen);
        Get.find<WalletController>().localDbGetWallet();

      }else{
        amountToAdd.value=null;
        localDbGetWallet();
      }

    },);
  }
  walletDeductUpdate() async {
    var wallet=0;
    await PaymentNetwork.getWalletByUserId(
      onSuccess: (value) async {
        wallet = value.wallet ?? 0;
      },
    );
    wallet = wallet - (int.parse(orderDataSendModel?.grandTotal?.toStringAsFixed(0)??'0'));
    await PaymentNetwork.updateWallet(wallet: wallet,onSuccess: () {
    },);
  }


}

class PaymentModel {
  String? title;
  String? icon;
  String? id;

  PaymentModel({this.title, this.icon, this.id});
}
