import 'package:cloud_firestore/cloud_firestore.dart';

class Subtask {
  final String subtaskId;
  final String? actionableStepId;
  final String? tempActionableStepId;
  final String subtaskContent;
  final bool isCompleted;
  final int priority;
  final String subtaskContext;
  final String subtaskTag;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Subtask({
    required this.subtaskId,
    this.actionableStepId,
    this.tempActionableStepId,
    required this.subtaskContent,
    required this.isCompleted,
    required this.priority,
    required this.subtaskContext,
    required this.subtaskTag,
    required this.createdAt,
    this.updatedAt,
  });

  factory Subtask.fromJson(Map<String, dynamic> json, {required String docId}) {
    return Subtask(
      subtaskId: docId,
      actionableStepId: json['actionable_step_id'] as String?,
      tempActionableStepId: json['temp_actionable_step_id'] as String?,
      subtaskContent: json['subtask_content'] as String,
      isCompleted: json['is_completed'] as bool,
      priority: json['priority'] as int,
      subtaskContext: json['subtask_context'] as String,
      subtaskTag: json['subtask_tag'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionable_step_id': actionableStepId,
      'temp_actionable_step_id': tempActionableStepId,
      'subtask_content': subtaskContent,
      'is_completed': isCompleted,
      'priority': priority,
      'subtask_context': subtaskContext,
      'subtask_tag': subtaskTag,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
