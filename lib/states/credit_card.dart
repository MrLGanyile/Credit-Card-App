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
