import 'package:cloud_firestore/cloud_firestore.dart';

class Recognition {
  final String recognitionId;
  final String contentId;
  final DateTime createdAt;
  final bool isProcessed;

  Recognition({
    required this.recognitionId,
    required this.contentId,
    required this.createdAt,
    required this.isProcessed,
  });

  factory Recognition.fromJson(Map<String, dynamic> json) {
    return Recognition(
      recognitionId: json['recognition_id'] as String,
      contentId: json['content_id'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      isProcessed: json['is_processed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recognition_id': recognitionId,
      'content_id': contentId,
      'created_at': Timestamp.fromDate(createdAt),
      'is_processed': isProcessed,
    };
  }
}
