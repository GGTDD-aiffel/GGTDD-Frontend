import 'package:cloud_firestore/cloud_firestore.dart';

class DefaultOccupationContextTag {
  final String defaultOccupationTagId;
  final String occupationId;
  final String defaultContextId;
  final String defaultTagId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  DefaultOccupationContextTag({
    required this.defaultOccupationTagId,
    required this.occupationId,
    required this.defaultContextId,
    required this.defaultTagId,
    required this.createdAt,
    this.updatedAt,
  });

  factory DefaultOccupationContextTag.fromJson(Map<String, dynamic> json) {
    return DefaultOccupationContextTag(
      defaultOccupationTagId: json['default_occupation_tag_id'] as String,
      occupationId: json['occupation_id'] as String,
      defaultContextId: json['default_context_id'] as String,
      defaultTagId: json['default_tag_id'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'default_occupation_tag_id': defaultOccupationTagId,
      'occupation_id': occupationId,
      'default_context_id': defaultContextId,
      'default_tag_id': defaultTagId,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
