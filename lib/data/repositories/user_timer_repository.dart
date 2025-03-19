import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_user_timer_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_timer_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class UserTimerRepository {
  // 유저 타이머 생성
  Future<UserTimer> createUserTimer(UserTimerCreateRequest request) async {
    try {
      final timerId =
          FirebaseFirestore.instance.collection('user_timers').doc().id;
      final timerData = request.toJson()..['user_timer_id'] = timerId;
      await FirebaseUtils.writeDocument('user_timers', timerId, timerData);
      final data = await FirebaseUtils.fetchDocument('user_timers', timerId);
      if (data != null) {
        return UserTimer.fromJson(data);
      }
      throw Exception('생성된 유저 타이머를 조회하지 못했습니다.');
    } catch (e) {
      print('유저 타이머 생성 오류: $e');
      rethrow;
    }
  }

  // 유저 타이머 조회
  Future<UserTimer?> fetchUserTimer(String timerId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('user_timers', timerId);
      if (data != null) {
        return UserTimer.fromJson(data);
      }
      return null;
    } catch (e) {
      print('유저 타이머 조회 오류: $e');
      return null;
    }
  }

  // 유저 타이머 리스트 조회
  Future<UserTimerListResponse> fetchUserTimers() async {
    try {
      final data =
          await FirebaseUtils.fetchCollection(collection: 'user_timers');
      final timers = data.map((item) => UserTimer.fromJson(item)).toList();
      return UserTimerListResponse(timers: timers);
    } catch (e) {
      print('유저 타이머 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 유저 타이머 수정
  Future<UserTimer> updateUserTimer(
      String timerId, UserTimerUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'user_timers', timerId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('user_timers', timerId);
      if (data != null) {
        return UserTimer.fromJson(data);
      }
      throw Exception('수정된 유저 타이머를 조회하지 못했습니다.');
    } catch (e) {
      print('유저 타이머 수정 오류: $e');
      rethrow;
    }
  }

  // 유저 타이머 삭제
  Future<void> deleteUserTimer(String timerId) async {
    try {
      await FirebaseUtils.deleteDocument('user_timers', timerId);
    } catch (e) {
      print('유저 타이머 삭제 오류: $e');
      rethrow;
    }
  }
}
