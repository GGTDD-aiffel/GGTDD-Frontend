import 'package:cloud_firestore/cloud_firestore.dart';

class DefaultTag {
  final String defaultTagId;
  final String tagName;
  final String type;
  final String? category;
  final String? timeRange;
  final DateTime createdAt;
  final DateTime? updatedAt;

  DefaultTag({
    required this.defaultTagId,
    required this.tagName,
    required this.type,
    this.category,
    this.timeRange,
    required this.createdAt,
    this.updatedAt,
  });

  factory DefaultTag.fromJson(Map<String, dynamic> json) {
    return DefaultTag(
      defaultTagId: json['default_tag_id'] as String,
      tagName: json['tag_name'] as String,
      type: json['type'] as String,
      category: json['category'] as String?,
      timeRange: json['time_range'] as String?,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'default_tag_id': defaultTagId,
      'tag_name': tagName,
      'type': type,
      'category': category,
      'time_range': timeRange,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
