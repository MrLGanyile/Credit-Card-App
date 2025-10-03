import 'package:flutter_bloc/flutter_bloc.dart';

import '../utilities.dart';
import 'banned_countries.dart';
import 'country.dart';

class BannedCountriesCubit extends Cubit<BannedCountries> {
  BannedCountriesCubit() : super(Utilities.bannedCountries);

  int findNumberOfBannedCountries() => state.findNumberOfBannedCountries();

  Country findSingleCardInfo(int index) => state.findSingleCardInfo(index);

  // Checks whether a given country is banned or not.
  bool isBanned(String countryCode) {
    return state.isBanned(countryCode);
  }

  // Add a country to a list of banned countries.
  void addToBannedCountries(String countryCode, String countryName) {
    state.bannedCountries
        .add(Country(countryCode: countryCode, countryName: countryName));

    emit(state);
  }

  // Remove a country from a list of banned countries.
  void removeFromBannedCountries(Country country) {
    state.removeFromBannedCountries(country);
    emit(BannedCountries(state.bannedCountries));
  }
}
