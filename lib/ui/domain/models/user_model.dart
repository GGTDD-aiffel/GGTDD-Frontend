import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  final String? occupationId;
  final String email;
  final String name;
  final DateTime birthDate;
  final String residence;
  final String mbti;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String status;
  final bool isPremium;

  User({
    required this.userId,
    this.occupationId,
    required this.email,
    required this.name,
    required this.birthDate,
    required this.residence,
    required this.mbti,
    required this.isAdmin,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.status,
    required this.isPremium,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] as String,
      occupationId: json['occupation_id'] as String?,
      email: json['email'] as String,
      name: json['name'] as String,
      birthDate: (json['birth_date'] as Timestamp).toDate(),
      residence: json['residence'] as String,
      mbti: json['mbti'] as String,
      isAdmin: json['is_admin'] as bool,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
      deletedAt: json['deleted_at'] != null
          ? (json['deleted_at'] as Timestamp).toDate()
          : null,
      status: json['status'],
      isPremium: json['is_premium'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'occupation_id': occupationId,
      'email': email,
      'name': name,
      'birth_date': Timestamp.fromDate(birthDate),
      'residence': residence,
      'mbti': mbti,
      'is_admin': isAdmin,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'deleted_at': deletedAt != null ? Timestamp.fromDate(deletedAt!) : null,
      'status': status,
      'is_premium': isPremium,
    };
  }
}
