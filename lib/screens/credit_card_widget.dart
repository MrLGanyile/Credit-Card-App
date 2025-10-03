import 'package:country_picker/country_picker.dart';
import 'package:credit_card_app/controller/credit_card_controller.dart';
import 'package:credit_card_app/model/credit_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as debug;

import '../model/banned_countries.dart';
import '../model/card_info.dart';
import '../model/country.dart' as c;
import '../utilities.dart';

class CreditCardWidget extends StatelessWidget {
  TextEditingController countryEditingController = TextEditingController();
  TextEditingController cvvEditingController = TextEditingController();
  TextEditingController creditCardNumberEditingController =
      TextEditingController();
  CreditCardController creditCardController = CreditCardController();

  // Supposed to be the same as the others defined on other widgets.
  // BannedCountries bannedCountries = BannedCountries();

  late DropdownButton2<String> dropDowButton;

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

  // We need a varibale to make sure this is only called once.
  void initialize(BuildContext context, CardInfo cardInfo) {
    creditCardNumberEditingController.addListener(() {
      // Once there are 6-8 card numbers entered display card type is possible.
      if ((creditCardNumberEditingController.text.length == 6 ||
              creditCardNumberEditingController.text.length == 8) &&
          Utilities.convertCardTypeToString(cardInfo.cardType!) ==
              'Card Type') {
        creditCardController
            .inferCardType(creditCardNumberEditingController.text)
            .then((status) {
          // Set the card type whenever it is detected from a card number.
          if (creditCardController.isStatusACardType(status)) {
            context.read<CreditCardCubit>().setCardType =
                Utilities.convertCardType(status);
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
          if (Utilities.bannedCountries.isBanned(countryCode)) {
            countryEditingController.clear();

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.black,
                content: Text('Error : Chosen Country Is Banned.',
                    style: TextStyle(fontSize: 16, color: Utilities.color2))));
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) =>
      // BlocBuilder<BlocA, BlocAState>
      BlocBuilder<CreditCardCubit, CardInfo>(
          buildWhen: (previous, current) => previous != current,
          // The bloc parameter is omitted [CreditCardCubit], however it will be found automatically.
          builder: (context, cardInfo) {
            initialize(context, cardInfo);
            return Container(
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
                          if (!Utilities.bannedCountries
                              .isBanned(country.countryCode)) {
                            c.Country myCountry = c.Country();
                            myCountry.setCountryCode = country.countryCode;
                            myCountry.setCountryName = country.name;
                            context.read<CreditCardCubit>().setIssuingCountry =
                                myCountry;
                            countryEditingController.text = country.displayName;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                    'Error : ${country.name} Is Banned.',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Utilities.color2))));
                          }
                        },

                        countryListTheme: const CountryListThemeData(
                          flagSize: 25,
                          backgroundColor: Colors.black,
                          textStyle:
                              TextStyle(fontSize: 16, color: Colors.blueGrey),
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
                        labelStyle:
                            TextStyle(fontSize: 14, color: Utilities.color1),
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
                        prefixIcon:
                            Icon(Icons.credit_card, color: Utilities.color1),
                        labelStyle:
                            TextStyle(fontSize: 14, color: Utilities.color1),
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
                        prefixIcon:
                            Icon(Icons.numbers, color: Utilities.color1),
                        labelStyle:
                            TextStyle(fontSize: 14, color: Utilities.color1),
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
                      child: pickCardType(context, cardInfo)),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: submitButton(cardInfo),
                  ),
                ],
              ),
            );
          });

  Widget pickCardType(BuildContext context, CardInfo cardInfo) {
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
      value: Utilities.convertCardTypeToString(cardInfo.cardType!),
      onChanged: (String? value) {
        context.read<CreditCardCubit>().setCardType =
            Utilities.convertCardType(value!);
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

  Widget submitButton(CardInfo cardInfo) => Builder(builder: (context) {
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
              else if (Utilities.convertCardTypeToString(cardInfo.cardType!)
                  .contains('Card Type')) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text('Error: Card Type Is Not Chosen.',
                        style:
                            TextStyle(fontSize: 16, color: Utilities.color2))));
                return;
              }

              /*String countryName = countryEditingController.text
                  .substring(0, countryEditingController.text.indexOf('(') - 1); 
              String countryCode = countryEditingController.text.substring(
                  countryEditingController.text.indexOf('(') + 1,
                  countryEditingController.text.indexOf(')')); */

              // The issuing country and the card type are already set.
              context.read<CreditCardCubit>().setCreditCardNumber =
                  creditCardNumberEditingController.text;
              context.read<CreditCardCubit>().setCVV =
                  cvvEditingController.text;

              // Check if the credit card has been checked before or not.
              if (creditCardController.isCreditCardChecked(cardInfo)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text('Error : The Credit Card Is Already Checked.',
                        style:
                            TextStyle(fontSize: 16, color: Utilities.color2))));
                return;
              }

              // Now, use BlocListener to show a dialog box in response to credit card capturing.
              creditCardController.addCreditCard(cardInfo);
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
