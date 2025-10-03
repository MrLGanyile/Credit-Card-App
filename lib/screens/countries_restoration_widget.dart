import 'package:credit_card_app/model/banned_countries.dart';
import 'package:credit_card_app/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/banned_countries_cubit.dart';

import '../model/country.dart';

class CountriesRestorationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BannedCountriesCubit, BannedCountries>(
        builder: (context, bannedCountries) {
          return ListView.builder(
            itemCount: Utilities.bannedCountries.findNumberOfBannedCountries(),
            itemBuilder: ((c, index) {
              Country country =
                  Utilities.bannedCountries.findSingleCardInfo(index);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Displays country name and country code, e.g South Africa [ZA].
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 5),
                    child: Text(
                      '${country.countryName} [${country.countryCode}]',
                      style: TextStyle(
                        fontSize: 16,
                        color: Utilities.color3,
                      ),
                    ),
                  ),
                  // Country deletion button
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Utilities.color1,
                      ),
                      onPressed: () {
                        c
                            .read<BannedCountriesCubit>()
                            .removeFromBannedCountries(country);
                      }),
                ],
              );
            }),
          );
        },
      );
}
