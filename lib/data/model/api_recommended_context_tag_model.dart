import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/recommended_context_tag_model.dart';

// 생성 요청 DTO
class RecommendedContextTagCreateRequest {
  final String recognitionId;
  final String? userContextId;
  final String? userTagId;

  RecommendedContextTagCreateRequest({
    required this.recognitionId,
    this.userContextId,
    this.userTagId,
  });

  Map<String, dynamic> toJson() {
    return {
      'recognition_id': recognitionId,
      'user_context_id': userContextId,
      'user_tag_id': userTagId,
      'created_at': Timestamp.now(),
    };
  }
}

// 수정 요청 DTO
class RecommendedContextTagUpdateRequest {
  final String? userContextId;
  final String? userTagId;

  RecommendedContextTagUpdateRequest({
    this.userContextId,
    this.userTagId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (userContextId != null) data['user_context_id'] = userContextId;
    if (userTagId != null) data['user_tag_id'] = userTagId;
    return data;
  }
}

// 기본 조회 응답 DTO
class RecommendedContextTagResponse {
  final RecommendedContextTag tag;

  RecommendedContextTagResponse({required this.tag});

  factory RecommendedContextTagResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return RecommendedContextTagResponse(
      tag: RecommendedContextTag.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return tag.toJson();
  }
}

// 리스트 조회 응답 DTO
class RecommendedContextTagListResponse {
  final List<RecommendedContextTag> tags;

  RecommendedContextTagListResponse({required this.tags});

  factory RecommendedContextTagListResponse.fromJson(
      Map<String, dynamic> json) {
    return RecommendedContextTagListResponse(
      tags: (json['data'] as List<dynamic>)
          .map((e) => RecommendedContextTag.fromJson(e as Map<String, dynamic>,
              docId: e['recommendation_id'] ?? ''))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': tags.map((t) => t.toJson()).toList(),
    };
  }
}

// BaseResponse 적용
typedef RecommendedContextTagCreateResponse
    = BaseResponse<RecommendedContextTagResponse>;
typedef RecommendedContextTagGetResponse
    = BaseResponse<RecommendedContextTagResponse>;
typedef RecommendedContextTagListResponseDto
    = BaseResponse<RecommendedContextTagListResponse>;
typedef RecommendedContextTagUpdateResponse
    = BaseResponse<RecommendedContextTagResponse>;
typedef RecommendedContextTagDeleteResponse = BaseResponse<void>;
