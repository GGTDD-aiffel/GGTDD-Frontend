import 'package:cloud_firestore/cloud_firestore.dart';

class DefaultContext {
  final String defaultContextId;
  final String contextName;
  final DateTime createdAt;
  final DateTime? updatedAt;

  DefaultContext({
    required this.defaultContextId,
    required this.contextName,
    required this.createdAt,
    this.updatedAt,
  });

  factory DefaultContext.fromJson(Map<String, dynamic> json) {
    return DefaultContext(
      defaultContextId: json['default_context_id'] as String,
      contextName: json['context_name'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'default_context_id': defaultContextId,
      'context_name': contextName,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
