import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_model.dart';

// 유저 생성 요청 DTO
class UserCreateRequest {
  final String uid;
  final String email;
  final String name;

  UserCreateRequest({
    required this.uid,
    required this.email,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'birth_date': null,
      'residence': null,
      'mbti': null,
      'is_admin': false,
      'created_at': Timestamp.now(),
      'updated_at': null,
      'deleted_at': null,
      'status': 'active',
      'is_premium': false,
    };
  }
}

// 유저 조회 응답 DTO
class UserGetResponse {
  final User user;

  UserGetResponse({required this.user});

  factory UserGetResponse.fromJson(Map<String, dynamic> json) {
    return UserGetResponse(
      user: User.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return user.toJson();
  }
}

// 유저 수정 요청 DTO
class UserUpdateRequest {
  final String? occupationId;
  final String? residence;
  final String? mbti;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? status;
  final bool? isPremium;

  UserUpdateRequest({
    this.occupationId,
    this.residence,
    this.mbti,
    this.updatedAt,
    this.deletedAt,
    this.status,
    this.isPremium,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (occupationId != null) data['occupation_id'] = occupationId;
    if (residence != null) data['residence'] = residence;
    if (mbti != null) data['mbti'] = mbti;
    if (updatedAt != null) data['updated_at'] = Timestamp.fromDate(updatedAt!);
    if (deletedAt != null) data['deleted_at'] = Timestamp.fromDate(deletedAt!);
    if (status != null) data['status'] = status;
    if (isPremium != null) data['is_premium'] = isPremium;
    return data;
  }
}

class UserLoginData {
  final String userId;
  final String email;
  final String name;
  final String token;

  UserLoginData({
    required this.userId,
    required this.email,
    required this.name,
    required this.token,
  });

  factory UserLoginData.fromJson(Map<String, dynamic> json) {
    return UserLoginData(
      userId: json['user_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'name': name,
      'token': token,
    };
  }
}

// BaseResponse 적용 예시
typedef UserResponse = BaseResponse<UserGetResponse>;
typedef UserCreateResponse = BaseResponse<UserGetResponse>;
typedef UserUpdateResponse = BaseResponse<UserGetResponse>;
typedef UserDeleteResponse = BaseResponse<void>;
typedef UserLogoutResponse = BaseResponse<void>;
typedef UserLoginResponse = BaseResponse<UserLoginData>;
