class Country implements Comparable<Country> {
  String countryCode; // Stores a country code.
  String countryName; // Stores a country name.
  bool isBanned; // Tells whether or not a country is banned.

  Country({
    this.countryCode = 'ZA',
    this.countryName = 'South Africa',
    this.isBanned = false,
  });

  // Ban this country.
  void setIsBanned(bool isBanned) {
    this.isBanned = isBanned;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Country &&
        countryName == other.countryName &&
        countryCode == other.countryCode;
  }

  @override
  int get hashCode => Object.hash(countryName, countryCode);

  @override
  int compareTo(Country other) {
    return countryCode.compareTo(other.countryCode);
  }

  @override
  String toString() {
    return '$countryName [$countryCode]';
  }
}
