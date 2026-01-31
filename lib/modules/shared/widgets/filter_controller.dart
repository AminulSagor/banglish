import 'package:get/get.dart';

import '../../../core/services/mock_data_service.dart';

class FilterController extends GetxController {
  var selectedGender = 'All'.obs;
  var selectedCountry = 'All Country'.obs;
  var selectedDivision = ''.obs;
  var selectedDistrict = ''.obs;

  final allCountries = <String>[
    'All Country',
    ...MockDataService.countries.take(15),
  ].obs;

  List<String> get divisions => MockDataService.bangladeshDivisions;

  List<String> get districts {
    if (selectedDivision.value.isEmpty) return [];
    return MockDataService.bangladeshDistricts[selectedDivision.value] ?? [];
  }

  void resetFilters() {
    selectedGender.value = 'All';
    selectedCountry.value = 'All Country';
    selectedDivision.value = '';
    selectedDistrict.value = '';
  }
}
