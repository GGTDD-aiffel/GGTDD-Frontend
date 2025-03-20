import 'package:cloud_firestore/cloud_firestore.dart';

class UserContextTag {
  final String userContextTagId;
  final String userContextId;
  final String userTagId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserContextTag({
    required this.userContextTagId,
    required this.userContextId,
    required this.userTagId,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserContextTag.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return UserContextTag(
      userContextTagId: docId,
      userContextId: json['user_context_id'] as String,
      userTagId: json['user_tag_id'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_context_id': userContextId,
      'user_tag_id': userTagId,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
