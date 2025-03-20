import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_default_timer_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/default_timer_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class DefaultTimerRepository {
  Future<DefaultTimerCreateResponse> createDefaultTimer(
      DefaultTimerCreateRequest request) async {
    try {
      final timerId =
          FirebaseFirestore.instance.collection('default_timers').doc().id;
      final timerData = request.toJson();
      await FirebaseUtils.writeDocument('default_timers', timerId, timerData);
      final data = await FirebaseUtils.fetchDocument('default_timers', timerId);
      if (data != null) {
        return DefaultTimerCreateResponse(
          code: 200,
          status: 'success',
          message: '기본 타이머 생성 성공',
          data: DefaultTimer.fromJson(data, docId: timerId),
        );
      }
      throw Exception('생성된 기본 타이머를 조회하지 못했습니다.');
    } catch (e) {
      print('기본 타이머 생성 오류: $e');
      return DefaultTimerCreateResponse(
        code: 500,
        status: 'error',
        message: '기본 타이머 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultTimerResponseDto> fetchDefaultTimer(String timerId) async {
    try {
      final data = await FirebaseUtils.fetchDocument('default_timers', timerId);
      if (data != null) {
        return DefaultTimerResponseDto(
          code: 200,
          status: 'success',
          message: '기본 타이머 조회 성공',
          data: DefaultTimerResponse(
              timer: DefaultTimer.fromJson(data, docId: timerId)),
        );
      }
      return DefaultTimerResponseDto(
        code: 404,
        status: 'not_found',
        message: '기본 타이머를 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('기본 타이머 조회 오류: $e');
      return DefaultTimerResponseDto(
        code: 500,
        status: 'error',
        message: '기본 타이머 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultTimerListResponseDto> fetchDefaultTimers() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('default_timers').get();
      final timers = snapshot.docs.map((doc) {
        return DefaultTimer.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return DefaultTimerListResponseDto(
        code: 200,
        status: 'success',
        message: '기본 타이머 리스트 조회 성공',
        data: DefaultTimerListResponse(timers: timers),
      );
    } catch (e) {
      print('기본 타이머 리스트 조회 오류: $e');
      return DefaultTimerListResponseDto(
        code: 500,
        status: 'error',
        message: '기본 타이머 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultTimerUpdateResponse> updateDefaultTimer(
      String timerId, DefaultTimerUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'default_timers', timerId, request.toJson());
      final data = await FirebaseUtils.fetchDocument('default_timers', timerId);
      if (data != null) {
        return DefaultTimerUpdateResponse(
          code: 200,
          status: 'success',
          message: '기본 타이머 수정 성공',
          data: DefaultTimer.fromJson(data, docId: timerId),
        );
      }
      throw Exception('수정된 기본 타이머를 조회하지 못했습니다.');
    } catch (e) {
      print('기본 타이머 수정 오류: $e');
      return DefaultTimerUpdateResponse(
        code: 500,
        status: 'error',
        message: '기본 타이머 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<DefaultTimerDeleteResponse> deleteDefaultTimer(String timerId) async {
    try {
      await FirebaseUtils.deleteDocument('default_timers', timerId);
      return DefaultTimerDeleteResponse(
        code: 200,
        status: 'success',
        message: '기본 타이머 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('기본 타이머 삭제 오류: $e');
      return DefaultTimerDeleteResponse(
        code: 500,
        status: 'error',
        message: '기본 타이머 삭제 실패: $e',
        data: null,
      );
    }
  }
}
