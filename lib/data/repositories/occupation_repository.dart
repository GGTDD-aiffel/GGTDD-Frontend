import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_occupation_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/occupation_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class OccupationRepository {
  // 직업 생성
  Future<Occupation> createOccupation(OccupationCreateRequest request) async {
    try {
      final occupationId =
          FirebaseFirestore.instance.collection('occupations').doc().id;
      final occupationData = request.toJson()..['occupation_id'] = occupationId;
      await FirebaseUtils.writeDocument(
          'occupations', occupationId, occupationData);
      final data =
          await FirebaseUtils.fetchDocument('occupations', occupationId);
      if (data != null) {
        return Occupation.fromJson(data);
      }
      throw Exception('생성된 직업을 조회하지 못했습니다.');
    } catch (e) {
      print('직업 생성 오류: $e');
      rethrow;
    }
  }

  // 직업 조회
  Future<Occupation?> fetchOccupation(String occupationId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('occupations', occupationId);
      if (data != null) {
        return Occupation.fromJson(data);
      }
      return null;
    } catch (e) {
      print('직업 조회 오류: $e');
      return null;
    }
  }

  // 직업 리스트 조회
  Future<OccupationListResponse> fetchOccupations() async {
    try {
      final data =
          await FirebaseUtils.fetchCollection(collection: 'occupations');
      final occupations =
          data.map((item) => Occupation.fromJson(item)).toList();
      return OccupationListResponse(occupations: occupations);
    } catch (e) {
      print('직업 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 직업 수정
  Future<Occupation> updateOccupation(
      String occupationId, OccupationUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'occupations', occupationId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('occupations', occupationId);
      if (data != null) {
        return Occupation.fromJson(data);
      }
      throw Exception('수정된 직업을 조회하지 못했습니다.');
    } catch (e) {
      print('직업 수정 오류: $e');
      rethrow;
    }
  }

  // 직업 삭제
  Future<void> deleteOccupation(String occupationId) async {
    try {
      await FirebaseUtils.deleteDocument('occupations', occupationId);
    } catch (e) {
      print('직업 삭제 오류: $e');
      rethrow;
    }
  }
}
