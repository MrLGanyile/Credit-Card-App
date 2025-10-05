import '../utilities.dart';
import 'country.dart';
import 'credit_card_type.dart';

class CreditCard implements Comparable<CreditCard> {
  String? creditCardNumber; // Stores credit card number.
  CreditCardType? cardType; // Stores card type from 12 predefined ones.
  String? cvv; // Stores a cvv of a card.
  Country? issuingCountry; // Stores the issuing country.
  bool isChecked;

  CreditCard({
    this.creditCardNumber,
    this.cardType = CreditCardType.cardType,
    this.cvv,
    this.issuingCountry,
    this.isChecked = false,
  });

  @override
  int get hashCode =>
      Object.hash(creditCardNumber, cardType, cvv, issuingCountry);

  @override
  int compareTo(CreditCard other) {
    int result = issuingCountry!.compareTo(other.issuingCountry!);
    if (result == 0) {
      result = Utilities.convertCardTypeToString(cardType!)
          .compareTo(Utilities.convertCardTypeToString(other.cardType!));
      if (result == 0) {
        result = creditCardNumber!.compareTo(other.creditCardNumber!);
        if (result == 0) {
          result = cvv!.compareTo(other.cvv!);
        }
      }
    }
    return result;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreditCard &&
        creditCardNumber == other.creditCardNumber &&
        Utilities.convertCardTypeToString(cardType!) ==
            Utilities.convertCardTypeToString(other.cardType!) &&
        issuingCountry == other.issuingCountry &&
        cvv == other.cvv &&
        isChecked == other.isChecked;
  }

  @override
  String toString() {
    return 'Card Type : ${Utilities.convertCardTypeToString(cardType!)} Card Number : $creditCardNumber CVV : $cvv Country: ${issuingCountry!.toString()}';
  }

  void clear() {
    creditCardNumber = null;
    cardType = CreditCardType.cardType;
    cvv = null;
    issuingCountry = null;
    isChecked = false;
  }

  // Check whether the provided card is valid or not.
  bool isValidCard() {
    return !issuingCountry!.isBanned && creditCardNumber!.length == 16 ||
        creditCardNumber!.length == 18 &&
            _containsNumbersOnly(creditCardNumber!) &&
            cardType != CreditCardType.cardType &&
            _containsNumbersOnly(cvv!) &&
            cvv!.length == 3;
  }

  // Determines whether a given card number contains numbers only.
  bool _containsNumbersOnly(String number) {
    for (int characterIndex = 0;
        characterIndex < number.length;
        characterIndex++) {
      if (!(number[characterIndex] == '0' ||
          number[characterIndex] == '0' ||
          number[characterIndex] == '1' ||
          number[characterIndex] == '2' ||
          number[characterIndex] == '3' ||
          number[characterIndex] == '4' ||
          number[characterIndex] == '5' ||
          number[characterIndex] == '6' ||
          number[characterIndex] == '7' ||
          number[characterIndex] == '8' ||
          number[characterIndex] == '9')) {
        return false;
      }
    }
    return true;
  }

  set setIsChecked(bool isChecked) => this.isChecked = isChecked;

  // Saves a credit card.
  void addCreditCard() {
    Utilities.creditCardsRepository.saveCreditCard(this);
  }

  // Delete a saved credit card.
  void removeFromStoredCreditCards() {
    Utilities.creditCardsRepository.removeFromStoredCreditCards(this);
  }
}
