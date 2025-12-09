import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/regionfilter_model.dart';

final regionFilterProvider = ChangeNotifierProvider(
  (ref) => RegionFilterViewModel(),
);

class RegionFilterViewModel extends ChangeNotifier {
  String? _selectedRegion;
  List<String> _filteredCities = [];

  String? get selectedRegion => _selectedRegion;
  List<String> get filteredCities => _filteredCities;
  List<RegionFilter> get regions => RegionsData.regions;

  void selectRegion(String region) {
    _selectedRegion = region;

    final regionData = RegionsData.regions
        .firstWhere((r) => r.regionName == region)
        .cities;

    _filteredCities = regionData;
    notifyListeners();
  }
}
