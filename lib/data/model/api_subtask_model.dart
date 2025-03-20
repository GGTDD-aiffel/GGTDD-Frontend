import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/sub_task_model.dart';

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
  final Subtask subtask;

  SubtaskResponse({required this.subtask});

  factory SubtaskResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return SubtaskResponse(
      subtask: Subtask.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return subtask.toJson();
  }
}

// 리스트 조회 응답 DTO
class SubtaskListResponse {
  final List<Subtask> subtasks;

  SubtaskListResponse({required this.subtasks});

  factory SubtaskListResponse.fromJson(Map<String, dynamic> json) {
    return SubtaskListResponse(
      subtasks: (json['data'] as List<dynamic>)
          .map((e) => Subtask.fromJson(e as Map<String, dynamic>,
              docId: e['subtask_id'] ?? ''))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': subtasks.map((s) => s.toJson()).toList(),
    };
  }
}

// BaseResponse 적용
typedef SubtaskCreateResponse = BaseResponse<SubtaskResponse>;
typedef SubtaskGetResponse = BaseResponse<SubtaskResponse>;
typedef SubtaskListResponseDto = BaseResponse<SubtaskListResponse>;
typedef SubtaskUpdateResponse = BaseResponse<SubtaskResponse>;
typedef SubtaskDeleteResponse = BaseResponse<void>;
