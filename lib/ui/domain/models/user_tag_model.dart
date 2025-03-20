import 'package:cloud_firestore/cloud_firestore.dart';

class UserTag {
  final String userTagId;
  final String userId;
  final String? defaultTagId;
  final String userContextId;
  final String tagName;
  final String type;
  final String? category;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserTag({
    required this.userTagId,
    required this.userId,
    this.defaultTagId,
    required this.userContextId,
    required this.tagName,
    required this.type,
    this.category,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserTag.fromJson(Map<String, dynamic> json, {required String docId}) {
    return UserTag(
      userTagId: docId,
      userId: json['user_id'] as String,
      defaultTagId: json['default_tag_id'] as String?,
      userContextId: json['user_context_id'] as String,
      tagName: json['tag_name'] as String,
      type: json['type'] as String,
      category: json['category'] as String?,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'default_tag_id': defaultTagId,
      'user_context_id': userContextId,
      'tag_name': tagName,
      'type': type,
      'category': category,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
