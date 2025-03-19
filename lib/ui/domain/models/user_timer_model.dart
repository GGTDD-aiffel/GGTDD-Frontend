import 'package:cloud_firestore/cloud_firestore.dart';

class UserTimer {
  final String userTimerId;
  final String userId;
  final String? defaultTimerId;
  final String timerName;
  final int focusTime;
  final int? breakTime;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserTimer({
    required this.userTimerId,
    required this.userId,
    this.defaultTimerId,
    required this.timerName,
    required this.focusTime,
    this.breakTime,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserTimer.fromJson(Map<String, dynamic> json) {
    return UserTimer(
      userTimerId: json['user_timer_id'] as String,
      userId: json['user_id'] as String,
      defaultTimerId: json['default_timer_id'] as String?,
      timerName: json['timer_name'] as String,
      focusTime: json['focus_time'] as int,
      breakTime: json['break_time'] as int?,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: json['updated_at'] != null
          ? (json['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_timer_id': userTimerId,
      'user_id': userId,
      'default_timer_id': defaultTimerId,
      'timer_name': timerName,
      'focus_time': focusTime,
      'break_time': breakTime,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
