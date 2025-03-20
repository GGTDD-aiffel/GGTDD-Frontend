import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_tag_model.dart';

// 생성 요청 DTO
class DefaultTagCreateRequest {
  final String tagName;
  final String type;
  final String? category;
  final String? timeRange;

  DefaultTagCreateRequest({
    required this.tagName,
    required this.type,
    this.category,
    this.timeRange,
  });

  Map<String, dynamic> toJson() {
    return {
      'tag_name': tagName,
      'type': type,
      'category': category,
      'time_range': timeRange,
      'created_at': Timestamp.now(),
      'updated_at': null,
    };
  }
}

// 수정 요청 DTO
class DefaultTagUpdateRequest {
  final String? tagName;
  final String? type;
  final String? category;
  final String? timeRange;
  final DateTime? updatedAt;

  DefaultTagUpdateRequest({
    this.tagName,
    this.type,
    this.category,
    this.timeRange,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (tagName != null) data['tag_name'] = tagName;
    if (type != null) data['type'] = type;
    if (category != null) data['category'] = category;
    if (timeRange != null) data['time_range'] = timeRange;
    if (updatedAt != null) data['updated_at'] = Timestamp.fromDate(updatedAt!);
    return data;
  }
}

// 기본 조회 응답 DTO
class DefaultTagResponse {
  final DefaultTag tag;

  DefaultTagResponse({required this.tag});

  factory DefaultTagResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return DefaultTagResponse(
      tag: DefaultTag.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return tag.toJson();
  }
}

// 리스트 조회 응답 DTO
class DefaultTagListResponse {
  final List<DefaultTag> tags;

  DefaultTagListResponse({required this.tags});

  factory DefaultTagListResponse.fromJson(Map<String, dynamic> json) {
    return DefaultTagListResponse(
      tags: (json['data'] as List<dynamic>)
          .map((e) => DefaultTag.fromJson(e as Map<String, dynamic>,
              docId: e['default_tag_id'] ?? ''))
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
typedef DefaultTagCreateResponse = BaseResponse<DefaultTagResponse>;
typedef DefaultTagGetResponse = BaseResponse<DefaultTagResponse>;
typedef DefaultTagListResponseDto = BaseResponse<DefaultTagListResponse>;
typedef DefaultTagUpdateResponse = BaseResponse<DefaultTagResponse>;
typedef DefaultTagDeleteResponse = BaseResponse<void>;
