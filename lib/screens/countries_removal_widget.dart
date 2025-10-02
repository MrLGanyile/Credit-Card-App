import 'package:country_picker/country_picker.dart';
import 'package:credit_card_app/controller/country_controller.dart';
import 'package:credit_card_app/model/country.dart' as my;
import 'package:flutter/material.dart';
import 'dart:developer' as debug;

import '../utilities.dart';

class CountriesRemovalWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CountriesRemovalWidgetState();
}

class CountriesRemovalWidgetState extends State<CountriesRemovalWidget> {
  CountryController countryController = CountryController();
  TextEditingController countryEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              'Pick Country To Ban',
              style: TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                color: Utilities.color1,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Icon(
              Icons.delete,
              size: 40,
              color: Utilities.color1,
            ),

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
                  showPhoneCode: true,
                  onSelect: (Country country) {
                    // Check if the selected country isn't banned
                    // debug.log('Select country: ${country.displayName}');
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: banButton(),
            )
          ],
        ),
      );

  Widget banButton() => Builder(builder: (context) {
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
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 16, color: Utilities.color2))));
                return;
              }

              String countryName = countryEditingController.text
                  .substring(0, countryEditingController.text.indexOf('(') - 1);
              String countryCode = countryEditingController.text.substring(
                  countryEditingController.text.indexOf('(') + 1,
                  countryEditingController.text.indexOf(')'));

              // Check if the issuing country is banned already or not.
              if (countryController.isBanned(countryCode)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                        overflow: TextOverflow.ellipsis,
                        'Error : The Chosen Country Is Banned Already.',
                        style:
                            TextStyle(fontSize: 16, color: Utilities.color2))));
                return;
              }

              countryController.addToBannedCountries(countryCode, countryName);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.black,
                  content: Text('$countryName Banned Successfully.',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, color: Utilities.color1))));
              countryEditingController.clear();
            },
            child: const Center(
              child: Text(
                'Ban',
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
