import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_occupation_context_tag_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_tag_model.dart';

// 생성 요청 DTO
class DefaultOccupationContextTagCreateRequest {
  final String occupationId;
  final String defaultContextId;
  final String defaultTagId;

  DefaultOccupationContextTagCreateRequest({
    required this.occupationId,
    required this.defaultContextId,
    required this.defaultTagId,
  });

  Map<String, dynamic> toJson() {
    return {
      'occupation_id': occupationId,
      'default_context_id': defaultContextId,
      'default_tag_id': defaultTagId,
      'created_at': Timestamp.now(),
      'updated_at': null,
    };
  }
}

// 수정 요청 DTO
class DefaultOccupationContextTagUpdateRequest {
  final String? occupationId;
  final String? defaultContextId;
  final String? defaultTagId;
  final DateTime? updatedAt;

  DefaultOccupationContextTagUpdateRequest({
    this.occupationId,
    this.defaultContextId,
    this.defaultTagId,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (occupationId != null) data['occupation_id'] = occupationId;
    if (defaultContextId != null) data['default_context_id'] = defaultContextId;
    if (defaultTagId != null) data['default_tag_id'] = defaultTagId;
    if (updatedAt != null) data['updated_at'] = Timestamp.fromDate(updatedAt!);
    return data;
  }
}

// 원본 데이터 조회 응답 DTO (컬렉션 필드 그대로)
class DefaultOccupationContextTagResponse {
  final String defaultOccupationTagId;
  final String occupationId;
  final String defaultContextId;
  final String defaultTagId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  DefaultOccupationContextTagResponse({
    required this.defaultOccupationTagId,
    required this.occupationId,
    required this.defaultContextId,
    required this.defaultTagId,
    required this.createdAt,
    this.updatedAt,
  });

  factory DefaultOccupationContextTagResponse.fromJson(
      Map<String, dynamic> json) {
    return DefaultOccupationContextTagResponse(
      defaultOccupationTagId: json['default_occupation_tag_id'] as String,
      occupationId: json['occupation_id'] as String,
      defaultContextId: json['default_context_id'] as String,
      defaultTagId: json['default_tag_id'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'default_occupation_tag_id': defaultOccupationTagId,
      'occupation_id': occupationId,
      'default_context_id': defaultContextId,
      'default_tag_id': defaultTagId,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}

// UI 맞춤 조회 응답 DTO (occupation_name, context_name, tag_name 포함)
class OccupationContextTagUiResponse {
  final String defaultOccupationTagId;
  final String occupationId;
  final String occupationName;
  final String contextId;
  final String contextName;
  final List<DefaultTag> tags;
  final DateTime createdAt;
  final DateTime? updatedAt;

  OccupationContextTagUiResponse({
    required this.defaultOccupationTagId,
    required this.occupationId,
    required this.occupationName,
    required this.contextId,
    required this.contextName,
    required this.tags,
    required this.createdAt,
    this.updatedAt,
  });

  factory OccupationContextTagUiResponse.fromJson(Map<String, dynamic> json) {
    return OccupationContextTagUiResponse(
      defaultOccupationTagId: json['default_occupation_tag_id'] as String,
      occupationId: json['occupation_id'] as String,
      occupationName: json['occupation_name'] as String,
      contextId: json['context_id'] as String,
      contextName: json['context_name'] as String,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => DefaultTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'default_occupation_tag_id': defaultOccupationTagId,
      'occupation_id': occupationId,
      'occupation_name': occupationName,
      'context_id': contextId,
      'context_name': contextName,
      'tags': tags.map((t) => t.toJson()).toList(),
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}

// 리스트 조회 응답 DTO (원본)
class DefaultOccupationContextTagListResponse {
  final List<DefaultOccupationContextTagResponse> data;

  DefaultOccupationContextTagListResponse({required this.data});

  factory DefaultOccupationContextTagListResponse.fromJson(
      Map<String, dynamic> json) {
    return DefaultOccupationContextTagListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => DefaultOccupationContextTagResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((d) => d.toJson()).toList(),
    };
  }
}

// 리스트 조회 응답 DTO (UI 맞춤)
class OccupationContextTagUiListResponse {
  final List<OccupationContextTagUiResponse> data;

  OccupationContextTagUiListResponse({required this.data});

  factory OccupationContextTagUiListResponse.fromJson(
      Map<String, dynamic> json) {
    return OccupationContextTagUiListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => OccupationContextTagUiResponse.fromJson(
              e as Map<String, dynamic>))
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
typedef DefaultOccupationContextTagCreateResponse
    = BaseResponse<DefaultOccupationContextTag>;
typedef DefaultOccupationContextTagListResponseDto
    = BaseResponse<DefaultOccupationContextTagListResponse>;
typedef DefaultOccupationContextTagGetResponse
    = BaseResponse<DefaultOccupationContextTagResponse>;
typedef DefaultOccupationContextTagUpdateResponse
    = BaseResponse<DefaultOccupationContextTag>;
typedef DefaultOccupationContextTagDeleteResponse = BaseResponse<void>;
typedef OccupationContextTagUiListResponseDto
    = BaseResponse<OccupationContextTagUiListResponse>;
typedef OccupationContextTagUiGetResponse
    = BaseResponse<OccupationContextTagUiResponse>;
