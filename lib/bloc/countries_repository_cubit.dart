import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/countries_repository.dart';
import '../states/country.dart';
import '../utilities.dart';

class CountriesRepositoryCubit extends Cubit<CountriesRepository> {
  CountriesRepositoryCubit() : super(Utilities.bannedCountries);

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
    emit(CountriesRepository(state.bannedCountries));
  }
}
