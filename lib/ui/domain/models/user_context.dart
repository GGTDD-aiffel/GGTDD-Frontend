import 'package:cloud_firestore/cloud_firestore.dart';

class UserContext {
  final String userContextId;
  final String userId;
  final String? defaultContextId;
  final String contextName;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserContext({
    required this.userContextId,
    required this.userId,
    this.defaultContextId,
    required this.contextName,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserContext.fromJson(Map<String, dynamic> json) {
    return UserContext(
      userContextId: json['user_context_id'] as String,
      userId: json['user_id'] as String,
      defaultContextId: json['default_context_id'] as String?,
      contextName: json['context_name'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_context_id': userContextId,
      'user_id': userId,
      'default_context_id': defaultContextId,
      'context_name': contextName,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
