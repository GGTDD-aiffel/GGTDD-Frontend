import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_context_tag_model.dart';

// 생성 요청 DTO
class UserContextTagCreateRequest {
  final String userContextId;
  final String userTagId;
  final String? defaultOccupationContextTagId;

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
  final UserContextTag tag;

  UserContextTagResponse({required this.tag});

  factory UserContextTagResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return UserContextTagResponse(
      tag: UserContextTag.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return tag.toJson();
  }
}

// 리스트 조회 응답 DTO
class UserContextTagListResponse {
  final List<UserContextTag> tags;

  UserContextTagListResponse({required this.tags});

  factory UserContextTagListResponse.fromJson(Map<String, dynamic> json) {
    return UserContextTagListResponse(
      tags: (json['data'] as List<dynamic>)
          .map((e) => UserContextTag.fromJson(e as Map<String, dynamic>,
              docId: e['user_context_tag_id'] ?? ''))
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
typedef UserContextTagCreateResponse = BaseResponse<UserContextTagResponse>;
typedef UserContextTagGetResponse = BaseResponse<UserContextTagResponse>;
typedef UserContextTagListResponseDto
    = BaseResponse<UserContextTagListResponse>;
typedef UserContextTagUpdateResponse = BaseResponse<UserContextTagResponse>;
typedef UserContextTagDeleteResponse = BaseResponse<void>;
