import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_context_model.dart';

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
  final DefaultContext context;

  DefaultContextResponse({required this.context});

  factory DefaultContextResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return DefaultContextResponse(
      context: DefaultContext.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return context.toJson();
  }
}

// 리스트 조회 응답 DTO
class DefaultContextListResponse {
  final List<DefaultContext> contexts;

  DefaultContextListResponse({required this.contexts});

  factory DefaultContextListResponse.fromJson(Map<String, dynamic> json) {
    return DefaultContextListResponse(
      contexts: (json['data'] as List<dynamic>)
          .map((e) => DefaultContext.fromJson(e as Map<String, dynamic>,
              docId: e['default_context_id'] ?? ''))
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
typedef DefaultContextCreateResponse = BaseResponse<DefaultContextResponse>;
typedef DefaultContextGetResponse = BaseResponse<DefaultContextResponse>;
typedef DefaultContextListResponseDto
    = BaseResponse<DefaultContextListResponse>;
typedef DefaultContextUpdateResponse = BaseResponse<DefaultContextResponse>;
typedef DefaultContextDeleteResponse = BaseResponse<void>;
