class DefaultTimer {
  final String defaultTimerId;
  final String timerName;
  final int focusTime;
  final int? breakTime;

  DefaultTimer({
    required this.defaultTimerId,
    required this.timerName,
    required this.focusTime,
    this.breakTime,
  });

  factory DefaultTimer.fromJson(Map<String, dynamic> json,
      {required String docId}) {
    return DefaultTimer(
      defaultTimerId: docId,
      timerName: json['timer_name'] as String,
      focusTime: json['focus_time'] as int,
      breakTime: json['break_time'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timer_name': timerName,
      'focus_time': focusTime,
      'break_time': breakTime,
    };
  }
}
