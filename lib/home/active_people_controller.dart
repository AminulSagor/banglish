import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../home/user_service.dart';
import '../widget/filter_controller.dart';

class ActivePeopleController extends GetxController {
  final UserService _userService = UserService();
  final FilterController _filter = Get.put(FilterController());

  var people = <UserModel>[].obs;
  var isLoading = false.obs;
  var isMoreDataAvailable = true.obs;

  DocumentSnapshot? lastDoc;
  String? currentUid;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    final prefs = await SharedPreferences.getInstance();
    currentUid = prefs.getString('uid') ?? '';

    // Listen for any filter changes and reload
    everAll([
      _filter.selectedGender,
      _filter.selectedCountry,
      _filter.selectedDivision,
      _filter.selectedDistrict,
    ], (_) {
      lastDoc = null;
      isMoreDataAvailable.value = true;
      loadPeople(isInitial: true);
    });

    loadPeople();
  }

  void loadPeople({bool isInitial = true}) async {
    if (isLoading.value || currentUid == null) return;

    isLoading.value = true;

    final fetchedPeople = await _userService.fetchUsers(
      startAfter: isInitial ? null : lastDoc,
      excludeUid: currentUid!,
      gender: _filter.selectedGender.value,
      country: _filter.selectedCountry.value,
      division: _filter.selectedDivision.value,
      district: _filter.selectedDistrict.value,
    );

    if (isInitial) {
      people.assignAll(fetchedPeople);
    } else {
      people.addAll(fetchedPeople);
    }

    if (fetchedPeople.isNotEmpty) {
      lastDoc = fetchedPeople.last.firestoreDoc;
    } else {
      isMoreDataAvailable.value = false;
    }

    isLoading.value = false;
  }

  void loadMore() {
    if (!isMoreDataAvailable.value || isLoading.value) return;
    loadPeople(isInitial: false);
  }
}
