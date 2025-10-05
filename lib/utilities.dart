import 'package:flutter/material.dart';

import 'states/countries_repository.dart';
import 'states/credit_card_repository.dart';
import 'states/credit_card_type.dart';

class Utilities {
  static Color cardTypeTextColor = Colors.yellow;
  static Color color1 = Colors.green;
  static Color color2 = Colors.red;
  static Color color3 = Colors.blue;
  static Color backgroundColor = Colors.black;
  static Color color4 = Colors.pink;

  static CountriesRepository bannedCountries = CountriesRepository([]);
  static CreditCardRepository creditCardsRepository =
      CreditCardRepository([], {});

  static String convertCardTypeToString(CreditCardType cardType) {
    switch (cardType) {
      case CreditCardType.visa:
        return 'Visa';

      case CreditCardType.mastercard:
        return 'Mastercard';

      case CreditCardType.americanExpress:
        return 'American Express';

      case CreditCardType.discover:
        return 'Discover';

      case CreditCardType.dinersClub:
        return 'Diners Club';

      case CreditCardType.jcb:
        return 'JCB';

      case CreditCardType.unionPay:
        return 'Union Pay';

      case CreditCardType.maestro:
        return 'Maestro';

      case CreditCardType.mir:
        return 'Mir';

      case CreditCardType.elo:
        return 'Elo';

      case CreditCardType.hiperOrHipercard:
        return 'Hiper/Hipercard';
      default:
        return 'Card Type';
    }
  }

  static CreditCardType convertCardType(String cardType) {
    switch (cardType) {
      case 'Visa':
        return CreditCardType.visa;
      case 'Mastercard':
        return CreditCardType.mastercard;
      case 'American Express':
        return CreditCardType.americanExpress;
      case 'Discover':
        return CreditCardType.discover;
      case 'Diners Club':
        return CreditCardType.dinersClub;
      case 'JCB':
        return CreditCardType.jcb;
      case 'Union Pay':
        return CreditCardType.unionPay;
      case 'Maestro':
        return CreditCardType.maestro;
      case 'Mir':
        return CreditCardType.mir;
      case 'Elo':
        return CreditCardType.elo;
      case 'Hiper/Hipercard':
        return CreditCardType.hiperOrHipercard;
      default:
        return CreditCardType.cardType;
    }
  }
}
