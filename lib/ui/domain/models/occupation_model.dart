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

  factory Occupation.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return Occupation(
      occupationId: docId,
      occupationName: json['occupation_name'] as String? ?? 'Unknown',
      createdAt: json['created_at'] != null
          ? (json['created_at'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'occupation_id': occupationId,
      'occupation_name': occupationName,
      'created_at': createdAt,
    };
  }
}
