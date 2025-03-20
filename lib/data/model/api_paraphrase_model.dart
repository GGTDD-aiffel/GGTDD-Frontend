import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/paraphrase_model.dart';

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
  final Paraphrase paraphrase;

  ParaphraseResponse({required this.paraphrase});

  factory ParaphraseResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return ParaphraseResponse(
      paraphrase: Paraphrase.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return paraphrase.toJson();
  }
}

// 리스트 조회 응답 DTO
class ParaphraseListResponse {
  final List<Paraphrase> paraphrases;

  ParaphraseListResponse({required this.paraphrases});

  factory ParaphraseListResponse.fromJson(Map<String, dynamic> json) {
    return ParaphraseListResponse(
      paraphrases: (json['data'] as List<dynamic>)
          .map((e) => Paraphrase.fromJson(e as Map<String, dynamic>,
              docId: e['paraphrase_id'] ?? ''))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': paraphrases.map((p) => p.toJson()).toList(),
    };
  }
}

// BaseResponse 적용
typedef ParaphraseCreateResponse = BaseResponse<ParaphraseResponse>;
typedef ParaphraseGetResponse = BaseResponse<ParaphraseResponse>;
typedef ParaphraseListResponseDto = BaseResponse<ParaphraseListResponse>;
typedef ParaphraseUpdateResponse = BaseResponse<ParaphraseResponse>;
typedef ParaphraseDeleteResponse = BaseResponse<void>;
