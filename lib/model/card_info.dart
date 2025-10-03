import '../controller/credit_card_controller.dart';
import '../utilities.dart';
import 'country.dart';
import 'credit_card_type.dart';

class CardInfo implements Comparable<CardInfo> {
  String? creditCardNumber; // Stores credit card number.
  CreditCardType? cardType; // Stores card type from 12 predefined ones.
  String? cvv; // Stores a cvv of a card.
  Country? issuingCountry; // Stores the issuing country.
  bool isChecked;

  CreditCardController creditCardController = CreditCardController();

  CardInfo({
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
  int compareTo(CardInfo other) {
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
    return other is CardInfo &&
        creditCardNumber == other.creditCardNumber &&
        Utilities.convertCardTypeToString(cardType!) ==
            Utilities.convertCardTypeToString(other.cardType!) &&
        issuingCountry == other.issuingCountry &&
        cvv == other.cvv &&
        isChecked == other.isChecked;
  }

  @override
  String toString() {
    return 'Card Type : ${Utilities.convertCardTypeToString(cardType!)} Card Number : $creditCardNumber CVV : $cvv';
  }

  void clear() {
    creditCardNumber = null;
    cardType = CreditCardType.cardType;
    cvv = null;
    issuingCountry = null;
    isChecked = false;
  }

  set setCreditCardNumber(String creditCardNumber) =>
      this.creditCardNumber = creditCardNumber;

  void setCardType(CreditCardType cardType) => this.cardType = cardType;
  set setCVV(String cvv) => this.cvv = cvv;
  set setIssuingCountry(Country issuingCountry) =>
      this.issuingCountry = issuingCountry;
  set setIsChecked(bool isChecked) => this.isChecked = isChecked;

  // Saves a credit card.
  void addCreditCard() {
    creditCardController.addCreditCard(this);
  }

  // Delete a saved credit card.
  void removeFromStoredCreditCards() {
    creditCardController.removeFromStoredCreditCards(this);
  }
}
