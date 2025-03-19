import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';

// 생성 요청 DTO
class SubtaskCreateRequest {
  final String? actionableStepId;
  final String subtaskContent;
  final int priority;
  final String subtaskContext;
  final String subtaskTag;

  SubtaskCreateRequest({
    this.actionableStepId,
    required this.subtaskContent,
    required this.priority,
    required this.subtaskContext,
    required this.subtaskTag,
  });

  Map<String, dynamic> toJson() {
    return {
      'actionable_step_id': actionableStepId,
      'temp_actionable_step_id': null,
      'subtask_content': subtaskContent,
      'is_completed': false,
      'priority': priority,
      'subtask_context': subtaskContext,
      'subtask_tag': subtaskTag,
      'created_at': Timestamp.now(),
      'updated_at': null,
    };
  }
}

// 수정 요청 DTO
class SubtaskUpdateRequest {
  final String? subtaskContent;
  final bool? isCompleted;
  final int? priority;
  final String? subtaskContext;
  final String? subtaskTag;
  final DateTime? updatedAt;

  SubtaskUpdateRequest({
    this.subtaskContent,
    this.isCompleted,
    this.priority,
    this.subtaskContext,
    this.subtaskTag,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (subtaskContent != null) data['subtask_content'] = subtaskContent;
    if (isCompleted != null) data['is_completed'] = isCompleted;
    if (priority != null) data['priority'] = priority;
    if (subtaskContext != null) data['subtask_context'] = subtaskContext;
    if (subtaskTag != null) data['subtask_tag'] = subtaskTag;
    if (updatedAt != null) data['updated_at'] = Timestamp.fromDate(updatedAt!);
    return data;
  }
}

// 기본 조회 응답 DTO
class SubtaskResponse {
  final String subtaskId;
  final String? actionableStepId;
  final String? tempActionableStepId;
  final String subtaskContent;
  final bool isCompleted;
  final int priority;
  final String subtaskContext;
  final String subtaskTag;
  final DateTime createdAt;
  final DateTime? updatedAt;

  SubtaskResponse({
    required this.subtaskId,
    this.actionableStepId,
    this.tempActionableStepId,
    required this.subtaskContent,
    required this.isCompleted,
    required this.priority,
    required this.subtaskContext,
    required this.subtaskTag,
    required this.createdAt,
    this.updatedAt,
  });

  factory SubtaskResponse.fromJson(Map<String, dynamic> json) {
    return SubtaskResponse(
      subtaskId: json['subtask_id'] as String,
      actionableStepId: json['actionable_step_id'] as String?,
      tempActionableStepId: json['temp_actionable_step_id'] as String?,
      subtaskContent: json['subtask_content'] as String,
      isCompleted: json['is_completed'] as bool,
      priority: json['priority'] as int,
      subtaskContext: json['subtask_context'] as String,
      subtaskTag: json['subtask_tag'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtask_id': subtaskId,
      'actionable_step_id': actionableStepId,
      'temp_actionable_step_id': tempActionableStepId,
      'subtask_content': subtaskContent,
      'is_completed': isCompleted,
      'priority': priority,
      'subtask_context': subtaskContext,
      'subtask_tag': subtaskTag,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}

// 리스트 조회 응답 DTO
class SubtaskListResponse {
  final List<SubtaskResponse> data;

  SubtaskListResponse({required this.data});

  factory SubtaskListResponse.fromJson(Map<String, dynamic> json) {
    return SubtaskListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => SubtaskResponse.fromJson(e as Map<String, dynamic>))
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
typedef SubtaskCreateResponse = BaseResponse<SubtaskResponse>;
typedef SubtaskGetResponse = BaseResponse<SubtaskResponse>;
typedef SubtaskListResponseDto = BaseResponse<SubtaskListResponse>;
typedef SubtaskUpdateResponse = BaseResponse<SubtaskResponse>;
typedef SubtaskDeleteResponse = BaseResponse<void>;
