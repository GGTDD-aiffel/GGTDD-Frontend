import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/data/model/api_pagination_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/actionable_step_model.dart';

// 생성 요청 DTO
class ActionableStepCreateRequest {
  final String contentId;
  final int weekNumber;
  final String stepContent;

  ActionableStepCreateRequest({
    required this.contentId,
    required this.weekNumber,
    required this.stepContent,
  });

  Map<String, dynamic> toJson() {
    return {
      'content_id': contentId,
      'week_number': weekNumber,
      'step_content': stepContent,
      'is_completed': false,
      'review': null,
      'created_at': Timestamp.now(),
      'updated_at': null,
    };
  }
}

// 수정 요청 DTO
class ActionableStepUpdateRequest {
  final int? weekNumber;
  final String? stepContent;
  final bool? isCompleted;
  final String? review;
  final DateTime? updatedAt;

  ActionableStepUpdateRequest({
    this.weekNumber,
    this.stepContent,
    this.isCompleted,
    this.review,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (weekNumber != null) data['week_number'] = weekNumber;
    if (stepContent != null) data['step_content'] = stepContent;
    if (isCompleted != null) data['is_completed'] = isCompleted;
    if (review != null) data['review'] = review;
    if (updatedAt != null) data['updated_at'] = Timestamp.fromDate(updatedAt!);
    return data;
  }
}

// 기본 조회 응답 DTO
class ActionableStepResponse {
  final ActionableStep step;

  ActionableStepResponse({required this.step});

  factory ActionableStepResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return ActionableStepResponse(
      step: ActionableStep.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return step.toJson();
  }
}

// 리스트 조회 응답 DTO (페이지네이션 포함)
class ActionableStepListResponse {
  final List<ActionableStep> steps;
  final PaginationMeta meta;

  ActionableStepListResponse({
    required this.steps,
    required this.meta,
  });

  factory ActionableStepListResponse.fromJson(Map<String, dynamic> json) {
    return ActionableStepListResponse(
      steps: (json['data'] as List<dynamic>)
          .map((e) => ActionableStep.fromJson(e as Map<String, dynamic>,
              docId: e['actionable_step_id'] ?? ''))
          .toList(),
      meta: PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': steps.map((s) => s.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

// BaseResponse 적용
typedef ActionableStepCreateResponse = BaseResponse<ActionableStepResponse>;
typedef ActionableStepGetResponse = BaseResponse<ActionableStepResponse>;
typedef ActionableStepListResponseDto
    = BaseResponse<ActionableStepListResponse>;
typedef ActionableStepUpdateResponse = BaseResponse<ActionableStepResponse>;
typedef ActionableStepDeleteResponse = BaseResponse<void>;
