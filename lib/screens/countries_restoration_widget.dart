import 'package:credit_card_app/utilities.dart';
import 'package:flutter/material.dart';

import '../controller/country_controller.dart';
import '../model/country.dart';

class CountriesRestorationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CountriesRestorationWidgetState();
}

class CountriesRestorationWidgetState
    extends State<CountriesRestorationWidget> {
  CountryController countryController = CountryController();
  late List<Country> bannedCountries;

  @override
  void initState() {
    super.initState();
    bannedCountries = CountryController.bannedCountries;
    print('.................no of banned countries ${bannedCountries.length}');
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: bannedCountries.length,
        itemBuilder: ((context, index) {
          return bannedCountryWidget(bannedCountries[index]);
        }),
      );

  Widget bannedCountryWidget(Country country) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 5),
          child: Text(
            '${country.countryName} [${country.countryCode}]',
            style: TextStyle(
              fontSize: 16,
              color: Utilities.color3,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Utilities.color1,
          ),
          onPressed: () => setState(() {
            countryController.removeFromBannedCountries(country);
          }),
        )
      ],
    );
  }
}
