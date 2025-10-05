import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/credit_card.dart';
import '../states/credit_card_repository.dart';
import '../utilities.dart';

class CreditCardRepositoryCubit extends Cubit<CreditCardRepository> {
  CreditCardRepositoryCubit() : super(Utilities.creditCardsRepository);

  // Saves a credit card.
  void saveCreditCard(CreditCard creditCard) {
    state.saveCreditCard(creditCard);
    emit(state);
  }

  // Delete a saved credit card.
  void removeFromStoredCreditCards(CreditCard creditCard) {
    state.removeFromStoredCreditCards(creditCard);
    emit(CreditCardRepository(state.storedCards, state.checkedCards));
  }

  /* Determines whether a given status produced by the BIN Codes API
  refers to one of the supported card types or not. */
  bool isStatusACardType(String status) {
    return state.isStatusACardType(status);
  }

  /* Determines a card type from a given six or eight digit number. 
     The return is the status refering to either one of the supported 
     card types or an error message produced by calling the API.
  */
  Future<String> inferCardType(String sixOrEightDigits) async {
    return state.inferCardType(sixOrEightDigits);
  }
}
