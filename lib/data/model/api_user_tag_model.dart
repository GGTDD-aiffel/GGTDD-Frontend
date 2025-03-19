import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';

// 생성 요청 DTO
class UserTagCreateRequest {
  final String userId;
  final String? defaultTagId;
  final String userContextId;
  final String tagName;
  final String type;
  final String? category;

  UserTagCreateRequest({
    required this.userId,
    this.defaultTagId,
    required this.userContextId,
    required this.tagName,
    required this.type,
    this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'default_tag_id': defaultTagId,
      'user_context_id': userContextId,
      'tag_name': tagName,
      'type': type,
      'category': category,
      'created_at': Timestamp.now(),
      'updated_at': null,
    };
  }
}

// 수정 요청 DTO
class UserTagUpdateRequest {
  final String? tagName;
  final String? type;
  final String? category;
  final DateTime? updatedAt;

  UserTagUpdateRequest({
    this.tagName,
    this.type,
    this.category,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (tagName != null) data['tag_name'] = tagName;
    if (type != null) data['type'] = type;
    if (category != null) data['category'] = category;
    if (updatedAt != null) data['updated_at'] = Timestamp.fromDate(updatedAt!);
    return data;
  }
}

// 기본 조회 응답 DTO
class UserTagResponse {
  final String userTagId;
  final String userId;
  final String? defaultTagId;
  final String userContextId;
  final String tagName;
  final String type;
  final String? category;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserTagResponse({
    required this.userTagId,
    required this.userId,
    this.defaultTagId,
    required this.userContextId,
    required this.tagName,
    required this.type,
    this.category,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserTagResponse.fromJson(Map<String, dynamic> json) {
    return UserTagResponse(
      userTagId: json['user_tag_id'] as String,
      userId: json['user_id'] as String,
      defaultTagId: json['default_tag_id'] as String?,
      userContextId: json['user_context_id'] as String,
      tagName: json['tag_name'] as String,
      type: json['type'] as String,
      category: json['category'] as String?,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_tag_id': userTagId,
      'user_id': userId,
      'default_tag_id': defaultTagId,
      'user_context_id': userContextId,
      'tag_name': tagName,
      'type': type,
      'category': category,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}

// 리스트 조회 응답 DTO
class UserTagListResponse {
  final List<UserTagResponse> data;

  UserTagListResponse({required this.data});

  factory UserTagListResponse.fromJson(Map<String, dynamic> json) {
    return UserTagListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => UserTagResponse.fromJson(e as Map<String, dynamic>))
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
typedef UserTagCreateResponse = BaseResponse<UserTagResponse>;
typedef UserTagGetResponse = BaseResponse<UserTagResponse>;
typedef UserTagListResponseDto = BaseResponse<UserTagListResponse>;
typedef UserTagUpdateResponse = BaseResponse<UserTagResponse>;
typedef UserTagDeleteResponse = BaseResponse<void>;
