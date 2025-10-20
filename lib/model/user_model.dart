import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid; // ✅ Add this line
  final String name;
  final String country;
  final String division;
  final String district;
  final String gender;
  final String image;

  DocumentSnapshot? firestoreDoc;

  UserModel({
    required this.uid, // ✅ Add this line
    required this.name,
    required this.country,
    required this.division,
    required this.district,
    required this.gender,
    required this.image,
    this.firestoreDoc,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, {required String uid}) {
    return UserModel(
      uid: uid, // ✅ assign passed UID here
      name: map['name'] ?? '',
      country: map['country'] ?? '',
      division: map['division'] ?? '',
      district: map['district'] ?? '',
      gender: map['gender'] ?? '',
      image: map['photoUrl'] ?? '',
    );
  }
}
