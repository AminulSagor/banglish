import 'package:get/get.dart';

class FilterController extends GetxController {
  var selectedGender = 'All'.obs;
  var selectedCountry = 'All Country'.obs;
  var selectedDivision = ''.obs;
  var selectedDistrict = ''.obs;

  // List of all available countries including 'All Country' option
  final allCountries = <String>[
    'All Country',
    'Bangladesh',
    'India',
    'Pakistan',
    'Nepal',
    'Sri Lanka',
    'USA',
    'UK',
    'Canada',
    'Australia',
    'Germany',
    // Add more as needed
  ].obs;

  void resetFilters() {
    selectedGender.value = '';
    selectedCountry.value = 'All Country';
    selectedDivision.value = '';
    selectedDistrict.value = '';
  }
}
