import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';

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
  final String tempActionableStepId;
  final String recognitionId;
  final int weekNumber;
  final String stepContent;
  final DateTime createdAt;

  TempActionableStepResponse({
    required this.tempActionableStepId,
    required this.recognitionId,
    required this.weekNumber,
    required this.stepContent,
    required this.createdAt,
  });

  factory TempActionableStepResponse.fromJson(Map<String, dynamic> json) {
    return TempActionableStepResponse(
      tempActionableStepId: json['temp_actionable_step_id'] as String,
      recognitionId: json['recognition_id'] as String,
      weekNumber: json['week_number'] as int,
      stepContent: json['step_content'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp_actionable_step_id': tempActionableStepId,
      'recognition_id': recognitionId,
      'week_number': weekNumber,
      'step_content': stepContent,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}

// 리스트 조회 응답 DTO
class TempActionableStepListResponse {
  final List<TempActionableStepResponse> data;

  TempActionableStepListResponse({required this.data});

  factory TempActionableStepListResponse.fromJson(Map<String, dynamic> json) {
    return TempActionableStepListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              TempActionableStepResponse.fromJson(e as Map<String, dynamic>))
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
typedef TempActionableStepCreateResponse
    = BaseResponse<TempActionableStepResponse>;
typedef TempActionableStepGetResponse
    = BaseResponse<TempActionableStepResponse>;
typedef TempActionableStepListResponseDto
    = BaseResponse<TempActionableStepListResponse>;
typedef TempActionableStepUpdateResponse
    = BaseResponse<TempActionableStepResponse>;
typedef TempActionableStepDeleteResponse = BaseResponse<void>;
