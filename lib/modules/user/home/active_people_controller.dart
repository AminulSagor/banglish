import 'package:get/get.dart';

import '../../../core/services/api_error_handler.dart';
import '../../../core/models/user_model.dart';
import '../services/user_module_service.dart';
import '../../shared/widgets/filter_controller.dart';

class ActivePeopleController extends GetxController {
  final FilterController _filter = Get.find<FilterController>();
  final ApiErrorHandler _apiErrorHandler = Get.find<ApiErrorHandler>();
  final UserModuleService _userService = Get.find<UserModuleService>();

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

    _apiErrorHandler
        .handle<List<UserModel>>(
          () => _userService.getActivePeople(),
          defaultErrorCode: 'ACTIVE_PEOPLE_LOAD_FAILED',
        )
        .then((ApiResponse<List<UserModel>> response) {
          final allUsers = response.data ?? <UserModel>[];
          final filteredUsers = allUsers.where((user) {
            if (user.uid == currentUid) return false;

            if (searchQuery.value.trim().isNotEmpty &&
                !user.name.toLowerCase().contains(
                  searchQuery.value.trim().toLowerCase(),
                )) {
              return false;
            }

            if (_filter.selectedGender.value != 'All' &&
                user.gender.toLowerCase() !=
                    _filter.selectedGender.value.toLowerCase()) {
              return false;
            }

            if (_filter.selectedCountry.value != 'All Country' &&
                user.country.toLowerCase() !=
                    _filter.selectedCountry.value.toLowerCase()) {
              return false;
            }

            if (_filter.selectedDivision.value.isNotEmpty &&
                user.division.toLowerCase() !=
                    _filter.selectedDivision.value.toLowerCase()) {
              return false;
            }

            if (_filter.selectedDistrict.value.isNotEmpty &&
                user.district.toLowerCase() !=
                    _filter.selectedDistrict.value.toLowerCase()) {
              return false;
            }

            return true;
          }).toList();

          people.assignAll(filteredUsers);
          isMoreDataAvailable.value = false;
          isLoading.value = false;
        });
  }

  void loadMore() {
    // Mock implementation - no more data
    isMoreDataAvailable.value = false;
  }
}
