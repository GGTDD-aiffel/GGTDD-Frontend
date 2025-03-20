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

  factory TempActionableStep.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return TempActionableStep(
      tempActionableStepId: docId,
      recognitionId: json['recognition_id'] as String,
      weekNumber: json['week_number'] as int,
      stepContent: json['step_content'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recognition_id': recognitionId,
      'week_number': weekNumber,
      'step_content': stepContent,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}
