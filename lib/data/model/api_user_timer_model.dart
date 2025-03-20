import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_timer_model.dart';

// 유저 타이머 단일 조회 응답 DTO (추가)
class UserTimerResponse {
  final UserTimer timer;

  UserTimerResponse({required this.timer});

  factory UserTimerResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return UserTimerResponse(
      timer: UserTimer.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return timer.toJson();
  }
}

// 유저 타이머 생성 요청 DTO
class UserTimerCreateRequest {
  final String userId;
  final String? defaultTimerId;
  final String timerName;
  final int? focusTime;
  final int? breakTime;

  UserTimerCreateRequest({
    required this.userId,
    this.defaultTimerId,
    required this.timerName,
    this.focusTime,
    this.breakTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'default_timer_id': defaultTimerId,
      'timer_name': timerName,
      'focus_time': focusTime,
      'break_time': breakTime,
      'created_at': Timestamp.now(),
      'updated_at': null,
    };
  }
}

// 유저 타이머 수정 요청 DTO
class UserTimerUpdateRequest {
  final int? focusTime;
  final int? breakTime;
  final DateTime? updatedAt;

  UserTimerUpdateRequest({
    this.focusTime,
    this.breakTime,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (focusTime != null) data['focus_time'] = focusTime;
    if (breakTime != null) data['break_time'] = breakTime;
    if (updatedAt != null) data['updated_at'] = Timestamp.fromDate(updatedAt!);
    return data;
  }
}

// 유저 타이머 리스트 조회 응답 DTO
class UserTimerListResponse {
  final List<UserTimer> timers;

  UserTimerListResponse({required this.timers});

  factory UserTimerListResponse.fromJson(Map<String, dynamic> json) {
    return UserTimerListResponse(
      timers: (json['timers'] as List<dynamic>)
          .map((e) => UserTimer.fromJson(e as Map<String, dynamic>,
              docId: e['user_timer_id'] ?? ''))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timers': timers.map((t) => t.toJson()).toList(),
    };
  }
}

// BaseResponse 적용
typedef UserTimerResponseDto = BaseResponse<UserTimerResponse>;
typedef UserTimerCreateResponse = BaseResponse<UserTimer>;
typedef UserTimerUpdateResponse = BaseResponse<UserTimer>;
typedef UserTimerDeleteResponse = BaseResponse<void>;
typedef UserTimerListResponseDto = BaseResponse<UserTimerListResponse>;
