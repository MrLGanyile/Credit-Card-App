class Country implements Comparable<Country> {
  String countryCode;
  String countryName;
  bool isBanned;

  Country({
    required this.countryCode,
    required this.countryName,
    this.isBanned = false,
  });

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
