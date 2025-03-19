import 'package:cloud_firestore/cloud_firestore.dart';

class RecommendedContextTag {
  final String recommendationId;
  final String recognitionId;
  final String? userContextId;
  final String? userTagId;
  final DateTime createdAt;

  RecommendedContextTag({
    required this.recommendationId,
    required this.recognitionId,
    this.userContextId,
    this.userTagId,
    required this.createdAt,
  });

  factory RecommendedContextTag.fromJson(Map<String, dynamic> json) {
    return RecommendedContextTag(
      recommendationId: json['recommendation_id'] as String,
      recognitionId: json['recognition_id'] as String,
      userContextId: json['user_context_id'] as String?,
      userTagId: json['user_tag_id'] as String?,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recommendation_id': recommendationId,
      'recognition_id': recognitionId,
      'user_context_id': userContextId,
      'user_tag_id': userTagId,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}
