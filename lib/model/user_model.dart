import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String country;
  final String division;
  final String district;
  final String gender;
  final String image;

  DocumentSnapshot? firestoreDoc; // Needed for pagination

  UserModel({
    required this.name,
    required this.country,
    required this.division,
    required this.district,
    required this.gender,
    required this.image,
    this.firestoreDoc,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      country: map['country'] ?? '',
      division: map['division'] ?? '',
      district: map['district'] ?? '',
      gender: map['gender'] ?? '',
      image: map['photoUrl'] ?? '',
    );
  }
}
