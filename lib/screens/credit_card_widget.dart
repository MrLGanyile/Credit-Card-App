import 'package:country_picker/country_picker.dart';
import 'package:credit_card_app/controller/country_controller.dart';
import 'package:credit_card_app/controller/credit_card_controller.dart';
import 'package:credit_card_app/model/country.dart' as country;
import 'package:credit_card_app/model/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'dart:developer' as debug;

import '../utilities.dart';

class CreditCardWidget extends StatefulWidget {
  CreditCardWidget();

  @override
  State<StatefulWidget> createState() => CreditCardWidgetState();
}

class CreditCardWidgetState extends State<CreditCardWidget> {
  TextEditingController countryEditingController = TextEditingController();
  TextEditingController cvvEditingController = TextEditingController();
  TextEditingController creditCardNumberEditingController =
      TextEditingController();
  CreditCardController creditCardController = CreditCardController();
  CountryController countryController = CountryController();

  late DropdownButton2<String> dropDowButton;

  String selectedCardType = 'Card Type';

  List<String> cardTypes = [
    'Card Type',
    'Visa',
    'Mastercard',
    'American Express',
    'Discover',
    'Diners Club',
    'JCB',
    'Union Pay',
    'Maestro',
    'Mir',
    'Elo',
    'Hiper/Hipercard',
  ];

  @override
  void initState() {
    super.initState();
    creditCardNumberEditingController.addListener(() {
      print('Current text: ${creditCardNumberEditingController.text}');

      // Once there are 6-8 card numbers entered display card type is possible.
      if ((creditCardNumberEditingController.text.length == 6 ||
              creditCardNumberEditingController.text.length == 8) &&
          selectedCardType == 'Card Type') {
        creditCardController
            .inferCardType(creditCardNumberEditingController.text)
            .then((status) {
          // Set the card type whenever it is detected from a card number.
          if (creditCardController.isStatusACardType(status)) {
            setState(() {
              selectedCardType = status;
            });
          }
          // Unable to detect a card number from a BIN
          else {}
        });
      }

      // Check if the chosen country is not banned.
      countryEditingController.addListener(() {
        if (countryEditingController.text.isNotEmpty) {
          String countryCode = countryEditingController.text.substring(
              countryEditingController.text.indexOf('(') + 1,
              countryEditingController.text.indexOf(')'));
          if (countryController.isBanned(countryCode)) {
            countryEditingController.clear();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.black,
                content: Text('Error : Chosen Country Is Banned.',
                    style: TextStyle(fontSize: 16, color: Utilities.color2))));
          }
        }
      });

      // You can perform other actions here, like updating UI with setState()
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(color: Utilities.backgroundColor),
        child: ListView(
          children: [
            const SizedBox(
              height: 5,
            ),
            // Country Picker
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                readOnly: true,
                onTap: () => showCountryPicker(
                  context: context,
                  showSearch: false,
                  showPhoneCode:
                      true, // optional. Shows phone code before the country name.
                  onSelect: (Country country) {
                    // Check if the selected country isn't banned
                    debug.log('Select country: ${country.displayName}');
                    countryEditingController.text = country.displayName;
                  },
                  countryListTheme: const CountryListThemeData(
                    flagSize: 25,
                    backgroundColor: Colors.black,
                    textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                    bottomSheetHeight:
                        400, // Optional. Country list modal height
                    //Optional. Sets the border radius for the bottomsheet.
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                maxLength: 50,
                style: TextStyle(color: Utilities.color1),
                cursorColor: Utilities.color1,
                controller: countryEditingController,
                decoration: InputDecoration(
                  labelText: 'Country',
                  prefixIcon:
                      Icon(Icons.location_city, color: Utilities.color1),
                  labelStyle: TextStyle(fontSize: 14, color: Utilities.color1),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Utilities.color3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Utilities.color3),
                  ),
                ),
                obscureText: false,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // Credit Card Number Textfield
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                onChanged: ((value) {}),
                keyboardType: TextInputType.number,
                maxLength: 18,
                style: TextStyle(color: Utilities.color1),
                cursorColor: Utilities.color1,
                controller: creditCardNumberEditingController,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  prefixIcon: Icon(Icons.credit_card, color: Utilities.color1),
                  labelStyle: TextStyle(fontSize: 14, color: Utilities.color1),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Utilities.color3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Utilities.color3),
                  ),
                ),
                obscureText: false,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // CVV Textfield
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 4,
                style: TextStyle(color: Utilities.color1),
                cursorColor: Utilities.color1,
                controller: cvvEditingController,
                decoration: InputDecoration(
                  labelText: 'CVV',
                  prefixIcon: Icon(Icons.numbers, color: Utilities.color1),
                  labelStyle: TextStyle(fontSize: 14, color: Utilities.color1),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Utilities.color3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Utilities.color3),
                  ),
                ),
                obscureText: false,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // Card Type Picker
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: pickCardType(context)),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: submitButton(),
            ),
          ],
        ),
      );

  Widget pickCardType(BuildContext context) {
    cardTypes.sort();

    dropDowButton = DropdownButton2<String>(
      isExpanded: true,
      hint: Row(
        children: [
          Icon(Icons.card_membership, size: 22, color: Utilities.color1),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              'Card Types',
              style: TextStyle(fontSize: 14, color: Utilities.color1),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: cardTypes
          .map(
            (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Utilities.color1,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      value: selectedCardType,
      onChanged: (String? value) {
        setState(() {
          selectedCardType = value!;
        });
      },
      buttonStyleData: ButtonStyleData(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.90,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Utilities.color3),
          color: Utilities.backgroundColor,
        ),
        elevation: 0,
      ),
      iconStyleData: IconStyleData(
        icon: const Icon(Icons.arrow_forward_ios_outlined),
        iconSize: 14,
        iconEnabledColor: Utilities.color1,
        iconDisabledColor: Utilities.color1,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        offset: const Offset(10, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all<double>(6),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    );

    return DropdownButtonHideUnderline(child: dropDowButton);
  }

  Widget submitButton() => Builder(builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
              color: Utilities.color1,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              )),
          child: InkWell(
            onTap: () async {
              // Check if a country is picked.
              if (countryEditingController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text('Error: Country Is Not Picked.',
                        style:
                            TextStyle(fontSize: 16, color: Utilities.color2))));
                return;
              }

              // Check if a credit card number is inserted.
              else if (creditCardNumberEditingController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text('Error: Credit Card Number Is Not Inserted.',
                        style:
                            TextStyle(fontSize: 16, color: Utilities.color2))));
                return;
              }

              // Check if a cvv number is inserted.
              else if (cvvEditingController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text('Error: CVV Number Is Missing.',
                        style:
                            TextStyle(fontSize: 16, color: Utilities.color2))));
                return;
              }

              // Check if card type is chosen (manually/automatically).
              else if (selectedCardType.contains('Card Type')) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text('Error: Card Type Is Not Chosen.',
                        style:
                            TextStyle(fontSize: 16, color: Utilities.color2))));
                return;
              }

              String countryName = countryEditingController.text
                  .substring(0, countryEditingController.text.indexOf('(') - 1);
              String countryCode = countryEditingController.text.substring(
                  countryEditingController.text.indexOf('(') + 1,
                  countryEditingController.text.indexOf(')'));

              // Check if the issuing country is banned or not.
              if (countryController.isBanned(countryCode)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text('Error : The Chosen Country Is Banned.',
                        style:
                            TextStyle(fontSize: 16, color: Utilities.color2))));
                return;
              }

              CreditCard creditCard = CreditCard(
                  creditCardNumber: creditCardNumberEditingController.text,
                  cardType: Utilities.convertCardType(selectedCardType),
                  cvv: cvvEditingController.text,
                  issuingCountry: country.Country(
                      countryCode: countryCode, countryName: countryName));

              // Check if the credit card has been checked before or not.
              if (creditCardController.isCreditCardChecked(creditCard)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text('Error : The Credit Card Is Already Checked.',
                        style:
                            TextStyle(fontSize: 16, color: Utilities.color2))));
                return;
              }

              creditCardController.addCreditCard(creditCard);
            },
            child: const Center(
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      });
}
