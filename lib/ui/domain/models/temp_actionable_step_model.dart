import 'package:cloud_firestore/cloud_firestore.dart';

class TempActionableStep {
  final String tempActionableStepId;
  final String recognitionId;
  final int weekNumber;
  final String stepContent;
  final DateTime createdAt;

  TempActionableStep({
    required this.tempActionableStepId,
    required this.recognitionId,
    required this.weekNumber,
    required this.stepContent,
    required this.createdAt,
  });

  factory TempActionableStep.fromJson(Map<String, dynamic> json) {
    return TempActionableStep(
      tempActionableStepId: json['temp_actionable_step_id'] as String,
      recognitionId: json['recognition_id'] as String,
      weekNumber: json['week_number'] as int,
      stepContent: json['step_content'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp_actionable_step_id': tempActionableStepId,
      'recognition_id': recognitionId,
      'week_number': weekNumber,
      'step_content': stepContent,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}
