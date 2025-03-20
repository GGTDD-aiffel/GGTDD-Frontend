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

  factory DefaultContext.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return DefaultContext(
      defaultContextId: docId,
      contextName: json['context_name'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'context_name': contextName,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
