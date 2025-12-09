class RegionFilter {
  final String regionName;
  final List<String> cities;

  RegionFilter({required this.regionName, required this.cities});
}

class RegionsData {
  static final List<RegionFilter> regions = [
    RegionFilter(
      regionName: "Asia",
      cities: ["Tokyo", "Beijing", "Mumbai", "Seoul", "Bangkok"],
    ),
    RegionFilter(
      regionName: "Europe",
      cities: ["London", "Paris", "Berlin", "Rome", "Madrid"],
    ),
    RegionFilter(
      regionName: "North America",
      cities: ["New York", "Los Angeles", "Chicago", "Toronto", "Mexico City"],
    ),
    RegionFilter(
      regionName: "South America",
      cities: ["São Paulo", "Buenos Aires", "Rio de Janeiro", "Lima", "Bogotá"],
    ),
    RegionFilter(
      regionName: "Africa",
      cities: ["Cairo", "Lagos", "Johannesburg", "Nairobi", "Casablanca"],
    ),
    RegionFilter(
      regionName: "Oceania",
      cities: ["Sydney", "Melbourne", "Auckland", "Brisbane", "Perth"],
    ),
  ];
}
