import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class UserService {
  final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  Future<List<UserModel>> fetchUsers({
    DocumentSnapshot? startAfter,
    int limit = 10,
    required String excludeUid,
    String? gender,
    String? country,
    String? division,
    String? district,
    String? searchText,
  }) async {
    try {
      print('🔍 Starting fetchUsers with searchText="$searchText"');

      Query query = usersRef;

      // Search logic (case-insensitive using name_lowercase)
      if (searchText != null && searchText.trim().isNotEmpty) {
        final trimmed = searchText.trim();
        final capitalized = trimmed[0].toUpperCase() + trimmed.substring(1).toLowerCase();

        query = query
            .orderBy('name')
            .where('name', isGreaterThanOrEqualTo: capitalized)
            .where('name', isLessThanOrEqualTo: '$capitalized\uf8ff');

        print('🔠 Applied name search range: >= "$capitalized", <= "${'$capitalized\uf8ff'}"');
      } else {
        query = query.orderBy('createdAt', descending: true);
        print('🕒 Applied default orderBy createdAt');
      }


      // Gender
      if (gender != null && gender.isNotEmpty && gender != 'All') {
        query = query.where('gender', isEqualTo: gender);
        print('🚻 Applied gender filter: $gender');
      }

      // Country
      final isBangladesh = country != null && country.isNotEmpty && country == 'Bangladesh';
      if (country != null && country.isNotEmpty && country != 'All Country') {
        query = query.where('country', isEqualTo: country);
        print('🌍 Applied country filter: $country');
      }

      // Division
      if (isBangladesh && division != null && division.isNotEmpty && division != 'All Division') {
        query = query.where('division', isEqualTo: division);
        print('🏙️ Applied division filter: $division');
      }

      // District
      if (isBangladesh && district != null && district.isNotEmpty && district != 'All District') {
        query = query.where('district', isEqualTo: district);
        print('📍 Applied district filter: $district');
      }

      // Pagination
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
        print('📄 Applied pagination after document: ${startAfter.id}');
      }

      query = query.limit(limit);
      print('🔢 Query limit: $limit');

      final snapshot = await query.get();

      print('📥 Total documents fetched from Firestore: ${snapshot.docs.length}');

      final filteredDocs = snapshot.docs.where((doc) => doc.id != excludeUid).toList();
      print('✅ Filtered out current user (UID=$excludeUid), remaining: ${filteredDocs.length}');

      final userList = filteredDocs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromMap(data, uid: doc.id)..firestoreDoc = doc;
      }).toList();


      return userList;
    } catch (e) {
      print('❌ Error fetching users: $e');
      return [];
    }
  }

}
