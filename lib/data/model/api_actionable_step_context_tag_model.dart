import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';

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
  final String actionableStepContextTagId;
  final String actionableStepId;
  final String? userContextId;
  final String? userTagId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ActionableStepContextTagResponse({
    required this.actionableStepContextTagId,
    required this.actionableStepId,
    this.userContextId,
    this.userTagId,
    required this.createdAt,
    this.updatedAt,
  });

  factory ActionableStepContextTagResponse.fromJson(Map<String, dynamic> json) {
    return ActionableStepContextTagResponse(
      actionableStepContextTagId:
          json['actionable_step_context_tag_id'] as String,
      actionableStepId: json['actionable_step_id'] as String,
      userContextId: json['user_context_id'] as String?,
      userTagId: json['user_tag_id'] as String?,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionable_step_context_tag_id': actionableStepContextTagId,
      'actionable_step_id': actionableStepId,
      'user_context_id': userContextId,
      'user_tag_id': userTagId,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}

// 리스트 조회 응답 DTO
class ActionableStepContextTagListResponse {
  final List<ActionableStepContextTagResponse> data;

  ActionableStepContextTagListResponse({required this.data});

  factory ActionableStepContextTagListResponse.fromJson(
      Map<String, dynamic> json) {
    return ActionableStepContextTagListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => ActionableStepContextTagResponse.fromJson(
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
typedef ActionableStepContextTagCreateResponse
    = BaseResponse<ActionableStepContextTagResponse>;
typedef ActionableStepContextTagGetResponse
    = BaseResponse<ActionableStepContextTagResponse>;
typedef ActionableStepContextTagListResponseDto
    = BaseResponse<ActionableStepContextTagListResponse>;
typedef ActionableStepContextTagUpdateResponse
    = BaseResponse<ActionableStepContextTagResponse>;
typedef ActionableStepContextTagDeleteResponse = BaseResponse<void>;
