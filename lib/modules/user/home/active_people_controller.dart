import 'package:get/get.dart';

import '../../../core/models/user_model.dart';
import '../../../core/services/mock_data_service.dart';
import '../../shared/widgets/filter_controller.dart';

class ActivePeopleController extends GetxController {
  final FilterController _filter = Get.find<FilterController>();

  var people = <UserModel>[].obs;
  var isLoading = false.obs;
  var isMoreDataAvailable = true.obs;
  var searchQuery = ''.obs;

  // Mock current user ID
  final String currentUid = 'current_user';

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  void _setupListeners() {
    // Listen for any filter OR search query change
    everAll(
      [
        _filter.selectedGender,
        _filter.selectedCountry,
        _filter.selectedDivision,
        _filter.selectedDistrict,
        searchQuery,
      ],
      (_) {
        loadPeople();
      },
    );
  }

  void loadPeople() {
    if (searchQuery.value.trim().isEmpty &&
        _filter.selectedGender.value == 'All' &&
        _filter.selectedCountry.value == 'All Country' &&
        _filter.selectedDivision.value.isEmpty &&
        _filter.selectedDistrict.value.isEmpty) {
      people.clear();
      isMoreDataAvailable.value = false;
      return;
    }

    isLoading.value = true;

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 300), () {
      final filteredUsers = MockDataService.getFilteredUsers(
        searchText: searchQuery.value,
        gender: _filter.selectedGender.value == 'All'
            ? null
            : _filter.selectedGender.value,
        country: _filter.selectedCountry.value == 'All Country'
            ? null
            : _filter.selectedCountry.value,
        division: _filter.selectedDivision.value.isEmpty
            ? null
            : _filter.selectedDivision.value,
        district: _filter.selectedDistrict.value.isEmpty
            ? null
            : _filter.selectedDistrict.value,
        excludeUid: currentUid,
      );

      people.assignAll(filteredUsers);
      isMoreDataAvailable.value = false; // Mock data doesn't have pagination
      isLoading.value = false;
    });
  }

  void loadMore() {
    // Mock implementation - no more data
    isMoreDataAvailable.value = false;
  }
}
