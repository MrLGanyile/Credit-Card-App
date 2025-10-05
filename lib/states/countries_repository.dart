import 'country.dart';

class CountriesRepository {
  // Stores a list of all banned countries.
  List<Country> bannedCountries;

  CountriesRepository(this.bannedCountries);

  // Checks whether a given country is banned or not.
  bool isBanned(String countryCode) {
    for (Country country in bannedCountries) {
      if (country.countryCode == countryCode && country.isBanned) {
        return true;
      }
    }

    return false;
  }

  int findNumberOfBannedCountries() => bannedCountries.length;

  Country findSingleCardInfo(int index) => bannedCountries[index];

  // Add a country to a list of banned countries.
  void addToBannedCountries(String countryCode, String countryName) {
    print('..........................${bannedCountries.length}');
    if (!isBanned(countryCode)) {
      bannedCountries.add(Country(
          countryCode: countryCode, countryName: countryName, isBanned: true));
    }
  }

  // Remove a country from a list of banned countries.
  void removeFromBannedCountries(Country country) {
    //if (isBanned(country.countryCode)) {

    bannedCountries.remove(country);
    print('..........................${bannedCountries.length}');

    //}
  }
}
