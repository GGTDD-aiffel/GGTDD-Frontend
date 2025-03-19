import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_occupation_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/occupation_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class OccupationRepository {
  Future<OccupationCreateResponse> createOccupation(
      OccupationCreateRequest request) async {
    try {
      final occupationId =
          FirebaseFirestore.instance.collection('occupations').doc().id;
      final occupationData = request.toJson();
      await FirebaseUtils.writeDocument(
          'occupations', occupationId, occupationData);
      final data =
          await FirebaseUtils.fetchDocument('occupations', occupationId);
      if (data != null) {
        return OccupationCreateResponse(
          code: 200,
          status: 'success',
          message: '직업 생성 성공',
          data: Occupation.fromJson(data, docId: occupationId),
        );
      }
      throw Exception('생성된 직업을 조회하지 못했습니다.');
    } catch (e) {
      print('직업 생성 오류: $e');
      return OccupationCreateResponse(
        code: 500,
        status: 'error',
        message: '직업 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<OccupationListResponseDto> fetchOccupations() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('occupations').get();
      final occupations = snapshot.docs.map((doc) {
        return Occupation.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return OccupationListResponseDto(
        code: 200,
        status: 'success',
        message: '직업 리스트 조회 성공',
        data: OccupationListResponse(occupations: occupations),
      );
    } catch (e) {
      print('직업 리스트 조회 오류: $e');
      return OccupationListResponseDto(
        code: 500,
        status: 'error',
        message: '직업 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<OccupationResponseDto> fetchOccupation(String occupationId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('occupations', occupationId);
      if (data != null) {
        return OccupationResponseDto(
          code: 200,
          status: 'success',
          message: '직업 조회 성공',
          data: OccupationResponse(
              occupation: Occupation.fromJson(data, docId: occupationId)),
        );
      }
      return OccupationResponseDto(
        code: 404,
        status: 'not_found',
        message: '직업을 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('직업 조회 오류: $e');
      return OccupationResponseDto(
        code: 500,
        status: 'error',
        message: '직업 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<OccupationUpdateResponse> updateOccupation(
      String occupationId, OccupationUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'occupations', occupationId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('occupations', occupationId);
      if (data != null) {
        return OccupationUpdateResponse(
          code: 200,
          status: 'success',
          message: '직업 수정 성공',
          data: Occupation.fromJson(data, docId: occupationId),
        );
      }
      throw Exception('수정된 직업을 조회하지 못했습니다.');
    } catch (e) {
      print('직업 수정 오류: $e');
      return OccupationUpdateResponse(
        code: 500,
        status: 'error',
        message: '직업 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<OccupationDeleteResponse> deleteOccupation(String occupationId) async {
    try {
      await FirebaseUtils.deleteDocument('occupations', occupationId);
      return OccupationDeleteResponse(
        code: 200,
        status: 'success',
        message: '직업 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('직업 삭제 오류: $e');
      return OccupationDeleteResponse(
        code: 500,
        status: 'error',
        message: '직업 삭제 실패: $e',
        data: null,
      );
    }
  }
}
