import 'package:get/get.dart';

class FilterController extends GetxController {
  var selectedGender = ''.obs;
  var selectedCountry = 'Bangladesh'.obs;
  var selectedDivision = ''.obs;
  var selectedDistrict = ''.obs;

  void resetFilters() {
    selectedGender.value = '';
    selectedCountry.value = 'Bangladesh';
    selectedDivision.value = '';
    selectedDistrict.value = '';
  }
}
