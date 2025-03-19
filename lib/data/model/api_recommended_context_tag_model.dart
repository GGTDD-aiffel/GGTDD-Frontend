import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';

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
  final String recommendationId;
  final String recognitionId;
  final String? userContextId;
  final String? userTagId;
  final DateTime createdAt;

  RecommendedContextTagResponse({
    required this.recommendationId,
    required this.recognitionId,
    this.userContextId,
    this.userTagId,
    required this.createdAt,
  });

  factory RecommendedContextTagResponse.fromJson(Map<String, dynamic> json) {
    return RecommendedContextTagResponse(
      recommendationId: json['recommendation_id'] as String,
      recognitionId: json['recognition_id'] as String,
      userContextId: json['user_context_id'] as String?,
      userTagId: json['user_tag_id'] as String?,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recommendation_id': recommendationId,
      'recognition_id': recognitionId,
      'user_context_id': userContextId,
      'user_tag_id': userTagId,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}

// 리스트 조회 응답 DTO
class RecommendedContextTagListResponse {
  final List<RecommendedContextTagResponse> data;

  RecommendedContextTagListResponse({required this.data});

  factory RecommendedContextTagListResponse.fromJson(
      Map<String, dynamic> json) {
    return RecommendedContextTagListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              RecommendedContextTagResponse.fromJson(e as Map<String, dynamic>))
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
typedef RecommendedContextTagCreateResponse
    = BaseResponse<RecommendedContextTagResponse>;
typedef RecommendedContextTagGetResponse
    = BaseResponse<RecommendedContextTagResponse>;
typedef RecommendedContextTagListResponseDto
    = BaseResponse<RecommendedContextTagListResponse>;
typedef RecommendedContextTagUpdateResponse
    = BaseResponse<RecommendedContextTagResponse>;
typedef RecommendedContextTagDeleteResponse = BaseResponse<void>;
