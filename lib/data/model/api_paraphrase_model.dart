import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';

// 생성 요청 DTO
class ParaphraseCreateRequest {
  final String recognitionId;
  final String paraphraseContent;

  ParaphraseCreateRequest({
    required this.recognitionId,
    required this.paraphraseContent,
  });

  Map<String, dynamic> toJson() {
    return {
      'recognition_id': recognitionId,
      'paraphrase_content': paraphraseContent,
      'is_selected_paraphrase': false,
      'created_at': Timestamp.now(),
    };
  }
}

// 수정 요청 DTO
class ParaphraseUpdateRequest {
  final String? paraphraseContent;
  final bool? isSelectedParaphrase;

  ParaphraseUpdateRequest({
    this.paraphraseContent,
    this.isSelectedParaphrase,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (paraphraseContent != null)
      data['paraphrase_content'] = paraphraseContent;
    if (isSelectedParaphrase != null)
      data['is_selected_paraphrase'] = isSelectedParaphrase;
    return data;
  }
}

// 기본 조회 응답 DTO
class ParaphraseResponse {
  final String paraphraseId;
  final String recognitionId;
  final String paraphraseContent;
  final bool isSelectedParaphrase;
  final DateTime createdAt;

  ParaphraseResponse({
    required this.paraphraseId,
    required this.recognitionId,
    required this.paraphraseContent,
    required this.isSelectedParaphrase,
    required this.createdAt,
  });

  factory ParaphraseResponse.fromJson(Map<String, dynamic> json) {
    return ParaphraseResponse(
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

// 리스트 조회 응답 DTO
class ParaphraseListResponse {
  final List<ParaphraseResponse> data;

  ParaphraseListResponse({required this.data});

  factory ParaphraseListResponse.fromJson(Map<String, dynamic> json) {
    return ParaphraseListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => ParaphraseResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((d) => d.toJson()).toList(),
    };
  }
}

// BaseResponse 적용
typedef ParaphraseCreateResponse = BaseResponse<ParaphraseResponse>;
typedef ParaphraseGetResponse = BaseResponse<ParaphraseResponse>;
typedef ParaphraseListResponseDto = BaseResponse<ParaphraseListResponse>;
typedef ParaphraseUpdateResponse = BaseResponse<ParaphraseResponse>;
typedef ParaphraseDeleteResponse = BaseResponse<void>;
