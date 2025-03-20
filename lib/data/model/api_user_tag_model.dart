import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_tag_model.dart';

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
  final UserTag tag;

  UserTagResponse({required this.tag});

  factory UserTagResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return UserTagResponse(
      tag: UserTag.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return tag.toJson();
  }
}

// 리스트 조회 응답 DTO
class UserTagListResponse {
  final List<UserTag> tags;

  UserTagListResponse({required this.tags});

  factory UserTagListResponse.fromJson(Map<String, dynamic> json) {
    return UserTagListResponse(
      tags: (json['data'] as List<dynamic>)
          .map((e) => UserTag.fromJson(e as Map<String, dynamic>,
              docId: e['user_tag_id'] ?? ''))
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
typedef UserTagCreateResponse = BaseResponse<UserTagResponse>;
typedef UserTagGetResponse = BaseResponse<UserTagResponse>;
typedef UserTagListResponseDto = BaseResponse<UserTagListResponse>;
typedef UserTagUpdateResponse = BaseResponse<UserTagResponse>;
typedef UserTagDeleteResponse = BaseResponse<void>;
