import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_user_timer_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/user_timer_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class UserTimerRepository {
  Future<UserTimerCreateResponse> createUserTimer(
      UserTimerCreateRequest request) async {
    try {
      final timerId =
          FirebaseFirestore.instance.collection('user_timers').doc().id;
      final timerData = request.toJson();
      await FirebaseUtils.writeDocument('user_timers', timerId, timerData);
      final data = await FirebaseUtils.fetchDocument('user_timers', timerId);
      if (data != null) {
        return UserTimerCreateResponse(
          code: 200,
          status: 'success',
          message: '유저 타이머 생성 성공',
          data: UserTimer.fromJson(data, docId: timerId),
        );
      }
      throw Exception('생성된 유저 타이머를 조회하지 못했습니다.');
    } catch (e) {
      print('유저 타이머 생성 오류: $e');
      return UserTimerCreateResponse(
        code: 500,
        status: 'error',
        message: '유저 타이머 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<UserTimerResponseDto> fetchUserTimer(String timerId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('user_timers', timerId);
      if (data != null) {
        return UserTimerResponseDto(
          code: 200,
          status: 'success',
          message: '유저 타이머 조회 성공',
          data: UserTimerResponse(
              timer: UserTimer.fromJson(data, docId: timerId)),
        );
      }
      return UserTimerResponseDto(
        code: 404,
        status: 'not_found',
        message: '유저 타이머를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('유저 타이머 조회 오류: $e');
      return UserTimerResponseDto(
        code: 500,
        status: 'error',
        message: '유저 타이머 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<UserTimerListResponseDto> fetchUserTimers() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('user_timers').get();
      final timers = snapshot.docs.map((doc) {
        return UserTimer.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return UserTimerListResponseDto(
        code: 200,
        status: 'success',
        message: '유저 타이머 리스트 조회 성공',
        data: UserTimerListResponse(timers: timers),
      );
    } catch (e) {
      print('유저 타이머 리스트 조회 오류: $e');
      return UserTimerListResponseDto(
        code: 500,
        status: 'error',
        message: '유저 타이머 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<UserTimerUpdateResponse> updateUserTimer(
      String timerId, UserTimerUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'user_timers', timerId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('user_timers', timerId);
      if (data != null) {
        return UserTimerUpdateResponse(
          code: 200,
          status: 'success',
          message: '유저 타이머 수정 성공',
          data: UserTimer.fromJson(data, docId: timerId),
        );
      }
      throw Exception('수정된 유저 타이머를 조회하지 못했습니다.');
    } catch (e) {
      print('유저 타이머 수정 오류: $e');
      return UserTimerUpdateResponse(
        code: 500,
        status: 'error',
        message: '유저 타이머 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<UserTimerDeleteResponse> deleteUserTimer(String timerId) async {
    try {
      await FirebaseUtils.deleteDocument('user_timers', timerId);
      return UserTimerDeleteResponse(
        code: 200,
        status: 'success',
        message: '유저 타이머 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('유저 타이머 삭제 오류: $e');
      return UserTimerDeleteResponse(
        code: 500,
        status: 'error',
        message: '유저 타이머 삭제 실패: $e',
        data: null,
      );
    }
  }
}
