import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';

// 생성 요청 DTO (default_occupation_context_tag_id 기반)
class UserContextTagCreateRequest {
  final String userContextId;
  final String userTagId;
  final String? defaultOccupationContextTagId; // 초기 조합 시 사용

  UserContextTagCreateRequest({
    required this.userContextId,
    required this.userTagId,
    this.defaultOccupationContextTagId,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_context_id': userContextId,
      'user_tag_id': userTagId,
      'default_occupation_context_tag_id': defaultOccupationContextTagId,
      'created_at': Timestamp.now(),
      'updated_at': null,
    };
  }
}

// 수정 요청 DTO
class UserContextTagUpdateRequest {
  final String? userContextId;
  final String? userTagId;
  final DateTime? updatedAt;

  UserContextTagUpdateRequest({
    this.userContextId,
    this.userTagId,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (userContextId != null) data['user_context_id'] = userContextId;
    if (userTagId != null) data['user_tag_id'] = userTagId;
    if (updatedAt != null) data['updated_at'] = Timestamp.fromDate(updatedAt!);
    return data;
  }
}

// 기본 조회 응답 DTO
class UserContextTagResponse {
  final String userContextTagId;
  final String userContextId;
  final String userTagId;
  final String? defaultOccupationContextTagId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserContextTagResponse({
    required this.userContextTagId,
    required this.userContextId,
    required this.userTagId,
    this.defaultOccupationContextTagId,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserContextTagResponse.fromJson(Map<String, dynamic> json) {
    return UserContextTagResponse(
      userContextTagId: json['user_context_tag_id'] as String,
      userContextId: json['user_context_id'] as String,
      userTagId: json['user_tag_id'] as String,
      defaultOccupationContextTagId:
          json['default_occupation_context_tag_id'] as String?,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_context_tag_id': userContextTagId,
      'user_context_id': userContextId,
      'user_tag_id': userTagId,
      'default_occupation_context_tag_id': defaultOccupationContextTagId,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}

// 리스트 조회 응답 DTO
class UserContextTagListResponse {
  final List<UserContextTagResponse> data;

  UserContextTagListResponse({required this.data});

  factory UserContextTagListResponse.fromJson(Map<String, dynamic> json) {
    return UserContextTagListResponse(
      data: (json['data'] as List<dynamic>)
          .map(
              (e) => UserContextTagResponse.fromJson(e as Map<String, dynamic>))
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
typedef UserContextTagCreateResponse = BaseResponse<UserContextTagResponse>;
typedef UserContextTagGetResponse = BaseResponse<UserContextTagResponse>;
typedef UserContextTagListResponseDto
    = BaseResponse<UserContextTagListResponse>;
typedef UserContextTagUpdateResponse = BaseResponse<UserContextTagResponse>;
typedef UserContextTagDeleteResponse = BaseResponse<void>;
