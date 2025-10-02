import 'package:credit_card_app/model/credit_card_type.dart';

import '../utilities.dart';
import 'country.dart';

class CreditCard implements Comparable<CreditCard> {
  String creditCardNumber;
  CreditCardType cardType;
  String cvv;
  Country issuingCountry;

  CreditCard({
    required this.creditCardNumber,
    required this.cardType,
    required this.cvv,
    required this.issuingCountry,
  });

  bool isValid() {
    return true;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreditCard &&
        creditCardNumber == other.creditCardNumber &&
        Utilities.convertCardTypeToString(cardType) ==
            Utilities.convertCardTypeToString(other.cardType) &&
        issuingCountry == other.issuingCountry &&
        cvv == other.cvv;
  }

  @override
  int get hashCode =>
      Object.hash(creditCardNumber, cardType, cvv, issuingCountry);

  @override
  int compareTo(CreditCard other) {
    int result = issuingCountry.compareTo(other.issuingCountry);
    if (result == 0) {
      result = Utilities.convertCardTypeToString(cardType)
          .compareTo(Utilities.convertCardTypeToString(other.cardType));
      if (result == 0) {
        result = creditCardNumber.compareTo(other.creditCardNumber);
        if (result == 0) {
          result = cvv.compareTo(other.cvv);
        }
      }
    }
    return result;
  }

  @override
  String toString() {
    return 'Card Type : ${Utilities.convertCardTypeToString(cardType)} Card Number : $creditCardNumber CVV : $cvv';
  }
}
