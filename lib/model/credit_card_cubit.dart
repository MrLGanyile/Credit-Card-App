import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/credit_card_controller.dart';
import 'card_info.dart';
import 'country.dart';
import 'credit_card_type.dart';

class CreditCardCubit extends Cubit<CardInfo>
    implements Comparable<CreditCardCubit> {
  CreditCardController creditCardController = CreditCardController();

  CreditCardCubit() : super(CardInfo());

  @override
  bool operator ==(Object other) {
    return other is CreditCardCubit && state == other.state;
  }

  @override
  int get hashCode => state.hashCode;

  @override
  int compareTo(CreditCardCubit other) {
    return state.compareTo(other.state);
  }

  @override
  String toString() {
    return state.toString();
  }

  set setCreditCardNumber(String cardNumber) {
    emit(CardInfo(
        creditCardNumber: cardNumber,
        cardType: state.cardType,
        cvv: state.cvv,
        issuingCountry: state.issuingCountry,
        isChecked: state.isChecked));
  }

  set setCardType(CreditCardType cardType) {
    emit(CardInfo(
        creditCardNumber: state.creditCardNumber,
        cardType: cardType,
        cvv: state.cvv,
        issuingCountry: state.issuingCountry,
        isChecked: state.isChecked));
  }

  set setCVV(String cvv) {
    emit(CardInfo(
        creditCardNumber: state.creditCardNumber,
        cardType: state.cardType,
        cvv: cvv,
        issuingCountry: state.issuingCountry,
        isChecked: state.isChecked));
  }

  set setIssuingCountry(Country issuingCountry) {
    // Perheps there is no need to emit the changes.
    emit(CardInfo(
        creditCardNumber: state.creditCardNumber,
        cardType: state.cardType,
        cvv: state.cvv,
        issuingCountry: issuingCountry,
        isChecked: state.isChecked));
  }

  set setIsChecked(bool isChecked) {
    // Perheps there is no need to emit the changes.
    emit(CardInfo(
        creditCardNumber: state.creditCardNumber,
        cardType: state.cardType,
        cvv: state.cvv,
        issuingCountry: state.issuingCountry,
        isChecked: isChecked));
  }

  void clear() {
    state.clear();
    emit(state);
  }

  // Saves a credit card.
  void addCreditCard() {
    creditCardController.addCreditCard(state);
  }

  // Delete a saved credit card.
  void removeFromStoredCreditCards() {
    creditCardController.removeFromStoredCreditCards(state);
  }
}
