import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';

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
  final String defaultTagId;
  final String tagName;
  final String type;
  final String? category;
  final String? timeRange;
  final DateTime createdAt;
  final DateTime? updatedAt;

  DefaultTagResponse({
    required this.defaultTagId,
    required this.tagName,
    required this.type,
    this.category,
    this.timeRange,
    required this.createdAt,
    this.updatedAt,
  });

  factory DefaultTagResponse.fromJson(Map<String, dynamic> json) {
    return DefaultTagResponse(
      defaultTagId: json['default_tag_id'] as String,
      tagName: json['tag_name'] as String,
      type: json['type'] as String,
      category: json['category'] as String?,
      timeRange: json['time_range'] as String?,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'default_tag_id': defaultTagId,
      'tag_name': tagName,
      'type': type,
      'category': category,
      'time_range': timeRange,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}

// 리스트 조회 응답 DTO
class DefaultTagListResponse {
  final List<DefaultTagResponse> data;

  DefaultTagListResponse({required this.data});

  factory DefaultTagListResponse.fromJson(Map<String, dynamic> json) {
    return DefaultTagListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => DefaultTagResponse.fromJson(e as Map<String, dynamic>))
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
typedef DefaultTagCreateResponse = BaseResponse<DefaultTagResponse>;
typedef DefaultTagGetResponse = BaseResponse<DefaultTagResponse>;
typedef DefaultTagListResponseDto = BaseResponse<DefaultTagListResponse>;
typedef DefaultTagUpdateResponse = BaseResponse<DefaultTagResponse>;
typedef DefaultTagDeleteResponse = BaseResponse<void>;
