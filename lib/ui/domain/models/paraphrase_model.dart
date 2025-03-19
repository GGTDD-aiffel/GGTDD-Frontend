import 'package:cloud_firestore/cloud_firestore.dart';

class Paraphrase {
  final String paraphraseId;
  final String recognitionId; // 외래키
  final String paraphraseContent;
  final bool isSelectedParaphrase;
  final DateTime createdAt;

  Paraphrase({
    required this.paraphraseId,
    required this.recognitionId,
    required this.paraphraseContent,
    required this.isSelectedParaphrase,
    required this.createdAt,
  });

  factory Paraphrase.fromJson(Map<String, dynamic> json) {
    return Paraphrase(
      paraphraseId: json['paraphrase_id'] as String,
      recognitionId: json['recognition_id'] as String,
      paraphraseContent: json['paraphrase_content'] as String,
      isSelectedParaphrase: json['is_selected_paraphrase'] as bool,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paraphrase_id': paraphraseId,
      'recognition_id': recognitionId,
      'paraphrase_content': paraphraseContent,
      'is_selected_paraphrase': isSelectedParaphrase,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}
