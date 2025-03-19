import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_default_timer_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_timer_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class DefaultTimerRepository {
  // 기본 타이머 생성
  Future<DefaultTimer> createDefaultTimer(
      DefaultTimerCreateRequest request) async {
    try {
      final timerId =
          FirebaseFirestore.instance.collection('default_timers').doc().id;
      final timerData = request.toJson()..['default_timer_id'] = timerId;
      await FirebaseUtils.writeDocument('default_timers', timerId, timerData);
      final data = await FirebaseUtils.fetchDocument('default_timers', timerId);
      if (data != null) {
        return DefaultTimer.fromJson(data);
      }
      throw Exception('생성된 기본 타이머를 조회하지 못했습니다.');
    } catch (e) {
      print('기본 타이머 생성 오류: $e');
      rethrow;
    }
  }

  // 기본 타이머 조회
  Future<DefaultTimer?> fetchDefaultTimer(String timerId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('default_timers', timerId);
      if (data != null) {
        return DefaultTimer.fromJson(data);
      }
      return null;
    } catch (e) {
      print('기본 타이머 조회 오류: $e');
      return null;
    }
  }

  // 기본 타이머 리스트 조회
  Future<DefaultTimerListResponse> fetchDefaultTimers() async {
    try {
      final data =
          await FirebaseUtils.fetchCollection(collection: 'default_timers');
      final timers = data.map((item) => DefaultTimer.fromJson(item)).toList();
      return DefaultTimerListResponse(timers: timers);
    } catch (e) {
      print('기본 타이머 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 기본 타이머 수정
  Future<DefaultTimer> updateDefaultTimer(
      String timerId, DefaultTimerUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'default_timers', timerId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('default_timers', timerId);
      if (data != null) {
        return DefaultTimer.fromJson(data);
      }
      throw Exception('수정된 기본 타이머를 조회하지 못했습니다.');
    } catch (e) {
      print('기본 타이머 수정 오류: $e');
      rethrow;
    }
  }

  // 기본 타이머 삭제
  Future<void> deleteDefaultTimer(String timerId) async {
    try {
      await FirebaseUtils.deleteDocument('default_timers', timerId);
    } catch (e) {
      print('기본 타이머 삭제 오류: $e');
      rethrow;
    }
  }
}
