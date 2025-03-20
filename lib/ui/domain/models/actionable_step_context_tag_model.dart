import 'package:cloud_firestore/cloud_firestore.dart';

class ActionableStepContextTag {
  final String actionableStepContextTagId;
  final String actionableStepId;
  final String? userContextId;
  final String? userTagId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ActionableStepContextTag({
    required this.actionableStepContextTagId,
    required this.actionableStepId,
    this.userContextId,
    this.userTagId,
    required this.createdAt,
    this.updatedAt,
  });

  factory ActionableStepContextTag.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return ActionableStepContextTag(
      actionableStepContextTagId: docId,
      actionableStepId: json['actionable_step_id'] as String,
      userContextId: json['user_context_id'] as String?,
      userTagId: json['user_tag_id'] as String?,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionable_step_id': actionableStepId,
      'user_context_id': userContextId,
      'user_tag_id': userTagId,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
