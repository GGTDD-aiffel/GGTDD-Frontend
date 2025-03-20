import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/recognition_model.dart';

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
  final Recognition recognition;

  RecognitionResponse({required this.recognition});

  factory RecognitionResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return RecognitionResponse(
      recognition: Recognition.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return recognition.toJson();
  }
}

// 리스트 조회 응답 DTO
class RecognitionListResponse {
  final List<Recognition> recognitions;

  RecognitionListResponse({required this.recognitions});

  factory RecognitionListResponse.fromJson(Map<String, dynamic> json) {
    return RecognitionListResponse(
      recognitions: (json['data'] as List<dynamic>)
          .map((e) => Recognition.fromJson(e as Map<String, dynamic>,
              docId: e['recognition_id'] ?? ''))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': recognitions.map((r) => r.toJson()).toList(),
    };
  }
}

// BaseResponse 적용
typedef RecognitionCreateResponse = BaseResponse<RecognitionResponse>;
typedef RecognitionGetResponse = BaseResponse<RecognitionResponse>;
typedef RecognitionListResponseDto = BaseResponse<RecognitionListResponse>;
typedef RecognitionUpdateResponse = BaseResponse<RecognitionResponse>;
typedef RecognitionDeleteResponse = BaseResponse<void>;
