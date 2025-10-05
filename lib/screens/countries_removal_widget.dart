import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/countries_repository_cubit.dart';
import '../states/countries_repository.dart';
import '../utilities.dart';

class CountriesRemovalWidget extends StatelessWidget {
  TextEditingController countryEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CountriesRepositoryCubit, CountriesRepository>(
        builder: (context, bannedCountries) {
          return Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                // Display message
                Text(
                  'Pick Country To Ban',
                  style: TextStyle(
                    fontSize: 18,
                    color: Utilities.color1,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                // Delete Icon
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
                        // Check if the selected country isn't banned before accepting it.
                        // debug.log('Select country: ${country.displayName}');
                        if (!bannedCountries.isBanned(country.countryCode)) {
                          countryEditingController.text = country.displayName;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.black,
                              content: Text(
                                  overflow: TextOverflow.ellipsis,
                                  'Error : The Chosen Country Is Banned Already.',
                                  style: TextStyle(
                                      fontSize: 16, color: Utilities.color2))));
                        }
                      },
                      countryListTheme: const CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.black,
                        textStyle:
                            TextStyle(fontSize: 16, color: Colors.blueGrey),
                        bottomSheetHeight: 400,
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
                // Ban Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: banButton(context, bannedCountries),
                )
              ],
            ),
          );
        },
      );

  Widget banButton(BuildContext context, CountriesRepository bannedCountries) =>
      Container(
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
            if (bannedCountries.isBanned(countryCode)) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.black,
                  content: Text(
                      overflow: TextOverflow.ellipsis,
                      'Error : The Chosen Country Is Banned Already.',
                      style:
                          TextStyle(fontSize: 16, color: Utilities.color2))));
              return;
            }

            bannedCountries.addToBannedCountries(countryCode, countryName);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.black,
                content: Text('$countryName Banned Successfully.',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Utilities.color1))));
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
}
