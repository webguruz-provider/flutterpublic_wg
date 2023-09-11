import 'package:foodguru/app_values/export.dart';

class AddCardController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isCardSave = false.obs;
  Rxn<CardModel> cardModel = Rxn<CardModel>();
  Rxn<CardType> cardType = Rxn<CardType>();
  TextEditingController? cardNumberController;
  TextEditingController? cardHolderNameController;
  TextEditingController? expiryController;
  TextEditingController? cvvController;

  FocusNode? cardNumberNode;
  FocusNode? cardHolderNameNode;
  FocusNode? expiryNode;
  FocusNode? cvvNode;

  @override
  void onInit() {
    _initializeControllerAndNodes();
    cardNumberListner();
    super.onInit();
  }

  _initializeControllerAndNodes() {
    cardNumberController = TextEditingController();
    cardHolderNameController = TextEditingController();
    expiryController = TextEditingController();
    cvvController = TextEditingController();
    cardNumberNode = FocusNode();
    cardHolderNameNode = FocusNode();
    expiryNode = FocusNode();
    cvvNode = FocusNode();
  }

  _disposeControllerAndNodes() {
    cardNumberController?.dispose();
    cardHolderNameController?.dispose();
    expiryController?.dispose();
    cvvController?.dispose();
    cardNumberNode?.dispose();
    cardHolderNameNode?.dispose();
    expiryNode?.dispose();
    cvvNode?.dispose();
  }

  cardNumberListner() {
    cardNumberController?.addListener(() {
      getCardTypeFrmNumber();
    });
  }

  void getCardTypeFrmNumber() {
    if ((cardNumberController?.text.length ?? 0) <= 6) {
      String input = CardUtils.getCleanedNumber(cardNumberController?.text);
      CardType type = CardUtils.getCardTypeFrmNumber(input);
      if (type != cardType.value) {
        cardType.value = type;
      }
    }
  }

  onAddCard() {
    cardModel.value = CardModel(
        cardNumber: cardNumberController?.text.trim(),
        cardHolderName: cardHolderNameController?.text.trim(),
        expiry: expiryController?.text.trim(),
        cvv: cvvController?.text.trim(),
        cardType: cardType.value);
    Get.back(result: cardModel.value);
  }

  @override
  void dispose() {
    _disposeControllerAndNodes();
    super.dispose();
  }

  @override
  void onClose() {
    _disposeControllerAndNodes();
    super.onClose();
  }
}
