import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';

// 생성 요청 DTO
class UserContextCreateRequest {
  final String userId;
  final String? defaultContextId;
  final String contextName;

  UserContextCreateRequest({
    required this.userId,
    this.defaultContextId,
    required this.contextName,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'default_context_id': defaultContextId,
      'context_name': contextName,
      'created_at': Timestamp.now(),
      'updated_at': null,
    };
  }
}

// 수정 요청 DTO
class UserContextUpdateRequest {
  final String? contextName;
  final DateTime? updatedAt;

  UserContextUpdateRequest({
    this.contextName,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (contextName != null) data['context_name'] = contextName;
    if (updatedAt != null) data['updated_at'] = Timestamp.fromDate(updatedAt!);
    return data;
  }
}

// 기본 조회 응답 DTO
class UserContextResponse {
  final String userContextId;
  final String userId;
  final String? defaultContextId;
  final String contextName;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserContextResponse({
    required this.userContextId,
    required this.userId,
    this.defaultContextId,
    required this.contextName,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserContextResponse.fromJson(Map<String, dynamic> json) {
    return UserContextResponse(
      userContextId: json['user_context_id'] as String,
      userId: json['user_id'] as String,
      defaultContextId: json['default_context_id'] as String?,
      contextName: json['context_name'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_context_id': userContextId,
      'user_id': userId,
      'default_context_id': defaultContextId,
      'context_name': contextName,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}

// 리스트 조회 응답 DTO
class UserContextListResponse {
  final List<UserContextResponse> data;

  UserContextListResponse({required this.data});

  factory UserContextListResponse.fromJson(Map<String, dynamic> json) {
    return UserContextListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => UserContextResponse.fromJson(e as Map<String, dynamic>))
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
typedef UserContextCreateResponse = BaseResponse<UserContextResponse>;
typedef UserContextGetResponse = BaseResponse<UserContextResponse>;
typedef UserContextListResponseDto = BaseResponse<UserContextListResponse>;
typedef UserContextUpdateResponse = BaseResponse<UserContextResponse>;
typedef UserContextDeleteResponse = BaseResponse<void>;
