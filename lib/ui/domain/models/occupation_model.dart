import 'package:cloud_firestore/cloud_firestore.dart';

class Occupation {
  final String occupationId;
  final String occupationName;
  final DateTime createdAt;

  Occupation({
    required this.occupationId,
    required this.occupationName,
    required this.createdAt,
  });

  factory Occupation.fromJson(Map<String, dynamic> json) {
    return Occupation(
      occupationId: json['occupation_id'] as String,
      occupationName: json['occupation_name'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'occupation_id': occupationId,
      'occupation_name': occupationName,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}
