import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';

// 생성 요청 DTO
class RecognitionCreateRequest {
  final String contentId;

  RecognitionCreateRequest({required this.contentId});

  Map<String, dynamic> toJson() {
    return {
      'content_id': contentId,
      'created_at': Timestamp.now(),
      'is_processed': false,
    };
  }
}

// 수정 요청 DTO
class RecognitionUpdateRequest {
  final bool? isProcessed;

  RecognitionUpdateRequest({this.isProcessed});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (isProcessed != null) data['is_processed'] = isProcessed;
    return data;
  }
}

// 기본 조회 응답 DTO
class RecognitionResponse {
  final String recognitionId;
  final String contentId;
  final DateTime createdAt;
  final bool isProcessed;

  RecognitionResponse({
    required this.recognitionId,
    required this.contentId,
    required this.createdAt,
    required this.isProcessed,
  });

  factory RecognitionResponse.fromJson(Map<String, dynamic> json) {
    return RecognitionResponse(
      recognitionId: json['recognition_id'] as String,
      contentId: json['content_id'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      isProcessed: json['is_processed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recognition_id': recognitionId,
      'content_id': contentId,
      'created_at': Timestamp.fromDate(createdAt),
      'is_processed': isProcessed,
    };
  }
}

// 리스트 조회 응답 DTO
class RecognitionListResponse {
  final List<RecognitionResponse> data;

  RecognitionListResponse({required this.data});

  factory RecognitionListResponse.fromJson(Map<String, dynamic> json) {
    return RecognitionListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => RecognitionResponse.fromJson(e as Map<String, dynamic>))
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
typedef RecognitionCreateResponse = BaseResponse<RecognitionResponse>;
typedef RecognitionGetResponse = BaseResponse<RecognitionResponse>;
typedef RecognitionListResponseDto = BaseResponse<RecognitionListResponse>;
typedef RecognitionUpdateResponse = BaseResponse<RecognitionResponse>;
typedef RecognitionDeleteResponse = BaseResponse<void>;
