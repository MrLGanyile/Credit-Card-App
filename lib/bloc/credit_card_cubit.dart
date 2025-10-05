import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/country.dart';
import '../states/credit_card.dart';
import '../states/credit_card_type.dart';
import '../utilities.dart';

class CreditCardCubit extends Cubit<CreditCard>
    implements Comparable<CreditCardCubit> {
  CreditCardCubit() : super(CreditCard());

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
    CreditCard creditCard = CreditCard(
        creditCardNumber: cardNumber,
        cardType: state.cardType,
        cvv: state.cvv,
        issuingCountry: state.issuingCountry,
        isChecked: state.isChecked);
    emit(creditCard);
  }

  set setCardType(CreditCardType cardType) {
    CreditCard creditCard = CreditCard(
        creditCardNumber: state.creditCardNumber,
        cardType: cardType,
        cvv: state.cvv,
        issuingCountry: state.issuingCountry,
        isChecked: state.isChecked);
    emit(creditCard);
  }

  set setCVV(String cvv) {
    CreditCard creditCard = CreditCard(
        creditCardNumber: state.creditCardNumber,
        cardType: state.cardType,
        cvv: cvv,
        issuingCountry: state.issuingCountry,
        isChecked: state.isChecked);
    emit(creditCard);
  }

  set setIssuingCountry(Country issuingCountry) {
    // Perheps there is no need to emit the changes.
    CreditCard creditCard = CreditCard(
        creditCardNumber: state.creditCardNumber,
        cardType: state.cardType,
        cvv: state.cvv,
        issuingCountry: issuingCountry,
        isChecked: state.isChecked);
    emit(creditCard);
  }

  set setIsChecked(bool isChecked) {
    // Perheps there is no need to emit the changes.
    CreditCard creditCard = CreditCard(
        creditCardNumber: state.creditCardNumber,
        cardType: state.cardType,
        cvv: state.cvv,
        issuingCountry: state.issuingCountry,
        isChecked: isChecked);
    emit(creditCard);
  }

  void clear() {
    state.clear();
    emit(CreditCard(
        creditCardNumber: state.creditCardNumber,
        cardType: state.cardType,
        cvv: state.cvv,
        issuingCountry: state.issuingCountry,
        isChecked: state.isChecked));
  }
}
