import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/temp_actionable_step_model.dart';

// 생성 요청 DTO
class TempActionableStepCreateRequest {
  final String recognitionId;
  final int weekNumber;
  final String stepContent;

  TempActionableStepCreateRequest({
    required this.recognitionId,
    required this.weekNumber,
    required this.stepContent,
  });

  Map<String, dynamic> toJson() {
    return {
      'recognition_id': recognitionId,
      'week_number': weekNumber,
      'step_content': stepContent,
      'created_at': Timestamp.now(),
    };
  }
}

// 수정 요청 DTO
class TempActionableStepUpdateRequest {
  final int? weekNumber;
  final String? stepContent;

  TempActionableStepUpdateRequest({
    this.weekNumber,
    this.stepContent,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (weekNumber != null) data['week_number'] = weekNumber;
    if (stepContent != null) data['step_content'] = stepContent;
    return data;
  }
}

// 기본 조회 응답 DTO
class TempActionableStepResponse {
  final TempActionableStep step;

  TempActionableStepResponse({required this.step});

  factory TempActionableStepResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return TempActionableStepResponse(
      step: TempActionableStep.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return step.toJson();
  }
}

// 리스트 조회 응답 DTO
class TempActionableStepListResponse {
  final List<TempActionableStep> steps;

  TempActionableStepListResponse({required this.steps});

  factory TempActionableStepListResponse.fromJson(Map<String, dynamic> json) {
    return TempActionableStepListResponse(
      steps: (json['data'] as List<dynamic>)
          .map((e) => TempActionableStep.fromJson(e as Map<String, dynamic>,
              docId: e['temp_actionable_step_id'] ?? ''))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': steps.map((s) => s.toJson()).toList(),
    };
  }
}

// BaseResponse 적용
typedef TempActionableStepCreateResponse
    = BaseResponse<TempActionableStepResponse>;
typedef TempActionableStepGetResponse
    = BaseResponse<TempActionableStepResponse>;
typedef TempActionableStepListResponseDto
    = BaseResponse<TempActionableStepListResponse>;
typedef TempActionableStepUpdateResponse
    = BaseResponse<TempActionableStepResponse>;
typedef TempActionableStepDeleteResponse = BaseResponse<void>;
