import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_base_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_timer_model.dart';

// 기본 타이머 단일 조회 응답 DTO (추가)
class DefaultTimerResponse {
  final DefaultTimer timer;

  DefaultTimerResponse({required this.timer});

  factory DefaultTimerResponse.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return DefaultTimerResponse(
      timer: DefaultTimer.fromJson(json, docId: docId),
    );
  }

  Map<String, dynamic> toJson() {
    return timer.toJson();
  }
}

// 기본 타이머 생성 요청 DTO
class DefaultTimerCreateRequest {
  final String timerName;
  final int focusTime;
  final int? breakTime;

  DefaultTimerCreateRequest({
    required this.timerName,
    required this.focusTime,
    this.breakTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'timer_name': timerName,
      'focus_time': focusTime,
      'break_time': breakTime,
      'created_at': Timestamp.now(),
    };
  }
}

// 기본 타이머 수정 요청 DTO
class DefaultTimerUpdateRequest {
  final String? timerName;
  final int? focusTime;
  final int? breakTime;

  DefaultTimerUpdateRequest({
    this.timerName,
    this.focusTime,
    this.breakTime,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (timerName != null) data['timer_name'] = timerName;
    if (focusTime != null) data['focus_time'] = focusTime;
    if (breakTime != null) data['break_time'] = breakTime;
    return data;
  }
}

// 기본 타이머 리스트 조회 응답 DTO
class DefaultTimerListResponse {
  final List<DefaultTimer> timers;

  DefaultTimerListResponse({required this.timers});

  factory DefaultTimerListResponse.fromJson(Map<String, dynamic> json) {
    return DefaultTimerListResponse(
      timers: (json['timers'] as List<dynamic>)
          .map((e) => DefaultTimer.fromJson(e as Map<String, dynamic>,
              docId: e['default_timer_id'] ?? ''))
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
typedef DefaultTimerResponseDto = BaseResponse<DefaultTimerResponse>;
typedef DefaultTimerCreateResponse = BaseResponse<DefaultTimer>;
typedef DefaultTimerUpdateResponse = BaseResponse<DefaultTimer>;
typedef DefaultTimerDeleteResponse = BaseResponse<void>;
typedef DefaultTimerListResponseDto = BaseResponse<DefaultTimerListResponse>;
