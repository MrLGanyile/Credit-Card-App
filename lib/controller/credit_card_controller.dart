import 'package:credit_card_app/controller/country_controller.dart';
import 'package:credit_card_app/model/credit_card.dart';
import 'package:credit_card_validator/credit_card_validator.dart';

import '../model/credit_card_type.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utilities.dart';

class CreditCardController {
  // Limited to 20 Requests Per Day.
  // ignore: non_constant_identifier_names
  final String API_KEY = 'd7a9c1da43e44682b16913ddc3500401';

  final List<CreditCard> validatedCards = [];
  final Set<CreditCard> checkedCards = {};
  CreditCardValidator ccValidator = CreditCardValidator();
  CountryController countryController = CountryController();

  bool isValidCreditCard(CreditCard card) {
    var ccNumResults = ccValidator.validateCCNum(card.creditCardNumber);
    var cvvResults = ccValidator.validateCVV(card.cvv, ccNumResults.ccType);
    var countryResult =
        countryController.isBanned(card.issuingCountry.countryCode);
    addToCheckedCards(card);

    return ccNumResults.isValid && cvvResults.isValid && countryResult;
  }

  bool isCreditCardChecked(CreditCard creditCard) {
    return checkedCards.contains(creditCard);
  }

  void addToCheckedCards(CreditCard creditCard) {
    checkedCards.add(creditCard);
  }

  // Do not capture same card twice.
  void addCreditCard(CreditCard card) {
    if (isValidCreditCard(card) && !validatedCards.contains(card)) {
      validatedCards.add(card);
    }
  }

  void removeCreditCard(CreditCard card) {
    validatedCards.remove(card);
  }

  List<CreditCard> displayAllCreditCardCapturedDuringSession() {
    return validatedCards;
  }

  // Incomplete
  bool containsNumbersOnly(String cardNumber) {
    return true;
  }

  bool isStatusACardType(String status) {
    return status == 'Visa' ||
        status == 'Mastercard' ||
        status == 'American Express' ||
        status == 'Discover' ||
        status == 'Diners Club' ||
        status == 'JCB' ||
        status == 'Union Pay' ||
        status == 'Maestro' ||
        status == 'Mir' ||
        status == 'Elo' ||
        status == 'Hiper/Hipercard';
  }

  Future<String> inferCardType(String sixOrEightDigits) async {
    print(
        '.............................Before Internet Connection inferCardType');
    final url = Uri.parse(
        'https://api.bincodes.com/bin/?format=json&api_key=$API_KEY&bin=$sixOrEightDigits');

    try {
      final response = await http.get(url);
      Map<String, dynamic> jsonData = json.decode(response.body);
      print(
          '.............................After Internet Connection inferCardType');

      if (response.statusCode == 200) {
        // API call successful, process the response body
        print('.............................Response data: ${response.body}');

        /*
        Example of a successful call to the api.
        {
            "bin": "515735",
            "bank": "CITIBANK, N.A.",
            "card": "MASTERCARD",
            "type": "CREDIT",
            "level": "WORLD CARD",
            "country": "UNITED STATES",
            "countrycode": "US",
            "website": "HTTPS://ONLINE.CITIBANK.COM/",
            "phone": "1-800-374-9700",
            "valid": "true"
        }
         */

        switch (jsonData['card'].toString().toLowerCase()) {
          case 'mastercard':
            return Utilities.convertCardTypeToString(CreditCardType.mastercard);
          case 'visa':
            return Utilities.convertCardTypeToString(CreditCardType.visa);
          case 'american express':
            return Utilities.convertCardTypeToString(
                CreditCardType.americanExpress);
          case 'discover':
            return Utilities.convertCardTypeToString(CreditCardType.discover);
          case 'diners club international':
            return Utilities.convertCardTypeToString(CreditCardType.dinersClub);
          case 'jcb':
            return Utilities.convertCardTypeToString(CreditCardType.jcb);
          case 'china union pay':
            return Utilities.convertCardTypeToString(CreditCardType.unionPay);
          case 'maestro':
            return Utilities.convertCardTypeToString(CreditCardType.maestro);
          case 'nspk mir':
            return Utilities.convertCardTypeToString(CreditCardType.mir);
          case 'elo': // I'm not sure whether this card is supported or not.
            return Utilities.convertCardTypeToString(CreditCardType.elo);
          case 'hipercard': // I'm not sure whether this card is supported or not.
            return Utilities.convertCardTypeToString(
                CreditCardType.hiperOrHipercard);
        }

        // I'm not sure whether this card is supported or not.
        if (jsonData['card'].toString().toLowerCase().contains('elo')) {
          return Utilities.convertCardTypeToString(CreditCardType.elo);
        }
        // I'm not sure whether this card is supported or not.
        else if (jsonData['card']
            .toString()
            .toLowerCase()
            .contains('hipercard')) {
          return Utilities.convertCardTypeToString(
              CreditCardType.hiperOrHipercard);
        }

        // Card type not know.
        return Utilities.convertCardTypeToString(CreditCardType.cardType);
      } else {
        // API call failed
        /*
        Example of unsuccessful call
        {
            "error": "1002",
            "message": "Invalid API Key",
            "valid": "false"
        }
         */
        return jsonData['message'];
      }
    } catch (e) {
      return "Error Fetching BIN API Data $e";
    }
  }
}
