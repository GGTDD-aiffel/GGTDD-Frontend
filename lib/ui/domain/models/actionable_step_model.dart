import 'package:cloud_firestore/cloud_firestore.dart';

class ActionableStep {
  final String actionableStepId;
  final String contentId;
  final int weekNumber;
  final String stepContent;
  final bool isCompleted;
  final String? review;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ActionableStep({
    required this.actionableStepId,
    required this.contentId,
    required this.weekNumber,
    required this.stepContent,
    required this.isCompleted,
    this.review,
    required this.createdAt,
    this.updatedAt,
  });

  factory ActionableStep.fromJson(Map<String, dynamic> json) {
    return ActionableStep(
      actionableStepId: json['actionable_step_id'] as String,
      contentId: json['content_id'] as String,
      weekNumber: json['week_number'] as int,
      stepContent: json['step_content'] as String,
      isCompleted: json['is_completed'] as bool,
      review: json['review'] as String?,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionable_step_id': actionableStepId,
      'content_id': contentId,
      'week_number': weekNumber,
      'step_content': stepContent,
      'is_completed': isCompleted,
      'review': review,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
