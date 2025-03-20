import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/actionable_step_context_tag_model.dart';

// 생성 요청 DTO
class ActionableStepContextTagCreateRequest {
  final String actionableStepId;
  final String? userContextId;
  final String? userTagId;

  ActionableStepContextTagCreateRequest({
    required this.actionableStepId,
    this.userContextId,
    this.userTagId,
  });

  Map<String, dynamic> toJson() {
    return {
      'actionable_step_id': actionableStepId,
      'user_context_id': userContextId,
      'user_tag_id': userTagId,
      'created_at': Timestamp.now(),
      'updated_at': null,
    };
  }
}

// 수정 요청 DTO
class ActionableStepContextTagUpdateRequest {
  final String? userContextId;
  final String? userTagId;
  final DateTime? updatedAt;

  ActionableStepContextTagUpdateRequest({
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
class ActionableStepContextTagResponse {
  final ActionableStepContextTag tag;

  ActionableStepContextTagResponse({required this.tag});

  factory ActionableStepContextTagResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return ActionableStepContextTagResponse(
      tag: ActionableStepContextTag.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return tag.toJson();
  }
}

// 리스트 조회 응답 DTO
class ActionableStepContextTagListResponse {
  final List<ActionableStepContextTag> tags;

  ActionableStepContextTagListResponse({required this.tags});

  factory ActionableStepContextTagListResponse.fromJson(
      Map<String, dynamic> json) {
    return ActionableStepContextTagListResponse(
      tags: (json['data'] as List<dynamic>)
          .map((e) => ActionableStepContextTag.fromJson(
              e as Map<String, dynamic>,
              docId: e['actionable_step_context_tag_id'] ?? ''))
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
typedef ActionableStepContextTagCreateResponse
    = BaseResponse<ActionableStepContextTagResponse>;
typedef ActionableStepContextTagGetResponse
    = BaseResponse<ActionableStepContextTagResponse>;
typedef ActionableStepContextTagListResponseDto
    = BaseResponse<ActionableStepContextTagListResponse>;
typedef ActionableStepContextTagUpdateResponse
    = BaseResponse<ActionableStepContextTagResponse>;
typedef ActionableStepContextTagDeleteResponse = BaseResponse<void>;
