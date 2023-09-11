import 'package:foodguru/app_values/export.dart';

enum CardType {
  master,
  visa,
  verve,
  discover,
  americanExpress,
  dinersClub,
  jcb,
  others,
}


class CardUtils{

  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.master;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.visa;
    } else if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.verve;
    } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
      cardType = CardType.americanExpress;
    } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
      cardType = CardType.discover;
    } else if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = CardType.dinersClub;
    } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = CardType.jcb;
    } else {
      cardType = CardType.others;
    }
    return cardType;
  }

  static String getCleanedNumber(String? text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text!.replaceAll(regExp, '');
  }

  static String getCardIcon(CardType? cardType) {
    String img = "";
    switch (cardType) {
      case CardType.master:
        img = ImageConstant.imagesIcMastercard;
        break;
      case CardType.visa:
        img = ImageConstant.imagesIcVisa;
        break;
      case CardType.verve:
        img = ImageConstant.imagesIcVerve;
        break;
      case CardType.americanExpress:
        img = ImageConstant.imagesIcAmericanExpress;
        break;
      case CardType.discover:
        img = ImageConstant.imagesIcDiscover;
        break;
      case CardType.dinersClub:
        img = ImageConstant.imagesIcDinersClub;
        break;
      case CardType.jcb:
        img = ImageConstant.imagesIcJcb;
        break;
      case CardType.others:
        img = ImageConstant.imagesIcCreditCard;
        break;
      default:
        img = ImageConstant.imagesIcCreditCard;
        break;
    }
    return img;
  }
  static String getCardName(CardType? cardType) {
    String cardName = "";
    switch (cardType) {
      case CardType.master:
        cardName = TextFile.masterCard.tr;
        break;
      case CardType.visa:
        cardName = TextFile.visa.tr;
        break;
      case CardType.verve:
        cardName = TextFile.verve.tr;
        break;
      case CardType.americanExpress:
        cardName = TextFile.americanExpress.tr;
        break;
      case CardType.discover:
        cardName = TextFile.discover.tr;
        break;
      case CardType.dinersClub:
        cardName = TextFile.dinersClub.tr;
        break;
      case CardType.jcb:
        cardName = TextFile.jcb.tr;
        break;
      case CardType.others:
        cardName = TextFile.others.tr;
        break;
      default:
        cardName = TextFile.others.tr;
        break;
    }
    return cardName;
  }

  static String? validateCardNum(String? input) {
    if (input == null || input.isEmpty) {
      return TextFile.cardNumberEmpty.tr;
    }
    input = getCleanedNumber(input);
    if (input.length < 8) {
      return TextFile.cardNumberIsInvalid.tr;
    }
    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);
// every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }
    if (sum % 10 == 0) {
      return null;
    }
    return TextFile.cardNumberIsInvalid;
  }


  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }
  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }
  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }
  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }
  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }
  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }
  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return TextFile.cvvEmpty.tr;
    }
    if (value.length < 3 || value.length > 4) {
      return TextFile.cvvIsInvalid.tr;
    }
    return null;
  }
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return TextFile.validThruEmpty.tr;
    }
    int year;
    int month;
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));

      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {

      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }
    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return TextFile.expiryMonthIsInvalid.tr;
    }
    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return TextFile.expiryYearIsInvalid.tr;
    }
    if (!hasDateExpired(month, year)) {
      return TextFile.cardHasExpired.tr;
    }
    return null;
  }

}


class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }

}