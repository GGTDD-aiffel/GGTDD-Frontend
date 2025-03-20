import 'package:cloud_firestore/cloud_firestore.dart';

class Inbox {
  final String contentId;
  final String userId;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isClarified;
  final bool isSentToRecognition;

  Inbox({
    required this.contentId,
    required this.userId,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    required this.isClarified,
    required this.isSentToRecognition,
  });

  factory Inbox.fromJson(Map<String, dynamic> json, {required String docId}) {
    return Inbox(
      contentId: docId,
      userId: json['user_id'] as String,
      content: json['content'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
      isClarified: json['is_clarified'] as bool,
      isSentToRecognition: json['is_sent_to_recognition'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'content': content,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'is_clarified': isClarified,
      'is_sent_to_recognition': isSentToRecognition,
    };
  }
}
