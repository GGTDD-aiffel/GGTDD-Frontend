import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_context_model.dart';

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
  final UserContext context;

  UserContextResponse({required this.context});

  factory UserContextResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return UserContextResponse(
      context: UserContext.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return context.toJson();
  }
}

// 리스트 조회 응답 DTO
class UserContextListResponse {
  final List<UserContext> contexts;

  UserContextListResponse({required this.contexts});

  factory UserContextListResponse.fromJson(Map<String, dynamic> json) {
    return UserContextListResponse(
      contexts: (json['data'] as List<dynamic>)
          .map((e) => UserContext.fromJson(e as Map<String, dynamic>,
              docId: e['user_context_id'] ?? ''))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': contexts.map((c) => c.toJson()).toList(),
    };
  }
}

// BaseResponse 적용
typedef UserContextCreateResponse = BaseResponse<UserContextResponse>;
typedef UserContextGetResponse = BaseResponse<UserContextResponse>;
typedef UserContextListResponseDto = BaseResponse<UserContextListResponse>;
typedef UserContextUpdateResponse = BaseResponse<UserContextResponse>;
typedef UserContextDeleteResponse = BaseResponse<void>;
