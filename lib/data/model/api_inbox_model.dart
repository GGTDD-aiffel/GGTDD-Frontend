import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/data/model/api_pagination_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/inbox_model.dart';

// 인박스 생성 요청 DTO
class InboxCreateRequest {
  final String userId;
  final String content;

  InboxCreateRequest({
    required this.userId,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'content': content,
      'created_at': Timestamp.now(),
      'updated_at': null,
      'is_clarified': false,
      'is_sent_to_recognition': false,
    };
  }
}

// 인박스 단일 조회 응답 DTO (추가)
class InboxResponse {
  final Inbox inbox;

  InboxResponse({required this.inbox});

  factory InboxResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return InboxResponse(
      inbox: Inbox.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return inbox.toJson();
  }
}

// 인박스 리스트 조회 응답 DTO (페이지네이션 포함)
class InboxListResponse {
  final List<Inbox> data;
  final PaginationMeta meta;

  InboxListResponse({
    required this.data,
    required this.meta,
  });

  factory InboxListResponse.fromJson(Map<String, dynamic> json) {
    return InboxListResponse(
      data: (json['data'] as List<dynamic>)
          .map((item) => Inbox.fromJson(item as Map<String, dynamic>,
              docId: item['content_id'] ?? ''))
          .toList(),
      meta: PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((i) => i.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

// 인박스 수정 요청 DTO
class InboxUpdateRequest {
  final String? content;
  final DateTime? updatedAt;
  final bool? isClarified;
  final bool? isSentToRecognition;

  InboxUpdateRequest({
    this.content,
    this.updatedAt,
    this.isClarified,
    this.isSentToRecognition,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (content != null) data['content'] = content;
    if (updatedAt != null) data['updated_at'] = Timestamp.fromDate(updatedAt!);
    if (isClarified != null) data['is_clarified'] = isClarified;
    if (isSentToRecognition != null)
      data['is_sent_to_recognition'] = isSentToRecognition;
    return data;
  }
}

// BaseResponse 적용
typedef InboxCreateResponse = BaseResponse<InboxResponse>;
typedef InboxGetResponse = BaseResponse<InboxResponse>;
typedef InboxListResponseDto = BaseResponse<InboxListResponse>;
typedef InboxUpdateResponse = BaseResponse<InboxResponse>;
typedef InboxDeleteResponse = BaseResponse<void>;
