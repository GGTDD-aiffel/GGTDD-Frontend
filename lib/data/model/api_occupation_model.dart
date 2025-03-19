import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/occupation_model.dart';

// 직업 리스트 조회 응답 DTO
class OccupationListResponse {
  final List<Occupation> occupations;

  OccupationListResponse({required this.occupations});

  factory OccupationListResponse.fromJson(Map<String, dynamic> json) {
    return OccupationListResponse(
      occupations: (json['occupations'] as List<dynamic>)
          .map((e) => Occupation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'occupations': occupations.map((o) => o.toJson()).toList(),
    };
  }
}

// 직업 생성 요청 DTO
class OccupationCreateRequest {
  final String occupationName;

  OccupationCreateRequest({required this.occupationName});

  Map<String, dynamic> toJson() {
    return {
      'occupation_name': occupationName,
      'created_at': Timestamp.now(),
    };
  }
}

// 직업 수정 요청 DTO
class OccupationUpdateRequest {
  final String? occupationName;

  OccupationUpdateRequest({this.occupationName});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (occupationName != null) data['occupation_name'] = occupationName;
    return data;
  }
}

// BaseResponse 적용
typedef OccupationListResponseDto = BaseResponse<OccupationListResponse>;
typedef OccupationCreateResponse = BaseResponse<Occupation>;
typedef OccupationUpdateResponse = BaseResponse<Occupation>;
typedef OccupationDeleteResponse = BaseResponse<void>;
