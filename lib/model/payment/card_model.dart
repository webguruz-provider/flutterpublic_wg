import 'package:foodguru/app_values/export.dart';

class CardModel {
  String? cardNumber;
  String? cardHolderName;
  String? expiry;
  String? cvv;
  CardType? cardType;


  CardModel({this.cardNumber, this.cardHolderName, this.cvv, this.expiry,this.cardType});
}
