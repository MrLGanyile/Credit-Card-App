import '../model/country.dart';

class CountryController {
  // Stores a list of all banned countries.
  static List<Country> bannedCountries = [];

  // Checks whether a given country is banned or not.
  bool isBanned(String countryCode) {
    for (Country country in bannedCountries) {
      if (country.countryCode == countryCode && country.isBanned) {
        return true;
      }
    }

    return false;
  }

  // Add a country to a list of banned countries.
  void addToBannedCountries(String countryCode, String countryName) {
    if (!isBanned(countryCode)) {
      bannedCountries.add(Country(
          countryCode: countryCode, countryName: countryName, isBanned: true));
    }
  }

  // Remove a country from a list of banned countries.
  void removeFromBannedCountries(Country country) {
    if (isBanned(country.countryCode)) {
      bannedCountries.remove(country);
    }
  }
}
