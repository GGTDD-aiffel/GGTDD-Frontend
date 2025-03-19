import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';

// 생성 요청 DTO
class DefaultContextCreateRequest {
  final String contextName;

  DefaultContextCreateRequest({required this.contextName});

  Map<String, dynamic> toJson() {
    return {
      'context_name': contextName,
      'created_at': Timestamp.now(),
      'updated_at': null,
    };
  }
}

// 수정 요청 DTO
class DefaultContextUpdateRequest {
  final String? contextName;
  final DateTime? updatedAt;

  DefaultContextUpdateRequest({
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
class DefaultContextResponse {
  final String defaultContextId;
  final String contextName;
  final DateTime createdAt;
  final DateTime? updatedAt;

  DefaultContextResponse({
    required this.defaultContextId,
    required this.contextName,
    required this.createdAt,
    this.updatedAt,
  });

  factory DefaultContextResponse.fromJson(Map<String, dynamic> json) {
    return DefaultContextResponse(
      defaultContextId: json['default_context_id'] as String,
      contextName: json['context_name'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'default_context_id': defaultContextId,
      'context_name': contextName,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}

// 리스트 조회 응답 DTO
class DefaultContextListResponse {
  final List<DefaultContextResponse> data;

  DefaultContextListResponse({required this.data});

  factory DefaultContextListResponse.fromJson(Map<String, dynamic> json) {
    return DefaultContextListResponse(
      data: (json['data'] as List<dynamic>)
          .map(
              (e) => DefaultContextResponse.fromJson(e as Map<String, dynamic>))
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
typedef DefaultContextCreateResponse = BaseResponse<DefaultContextResponse>;
typedef DefaultContextGetResponse = BaseResponse<DefaultContextResponse>;
typedef DefaultContextListResponseDto
    = BaseResponse<DefaultContextListResponse>;
typedef DefaultContextUpdateResponse = BaseResponse<DefaultContextResponse>;
typedef DefaultContextDeleteResponse = BaseResponse<void>;
