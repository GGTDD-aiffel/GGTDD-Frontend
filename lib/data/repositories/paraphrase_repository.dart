import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_paraphrase_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class ParaphraseRepository {
  // 재구성 생성
  Future<ParaphraseResponse> createParaphrase(
      ParaphraseCreateRequest request) async {
    try {
      final paraphraseId =
          FirebaseFirestore.instance.collection('paraphrases').doc().id;
      final paraphraseData = request.toJson()..['paraphrase_id'] = paraphraseId;
      await FirebaseUtils.writeDocument(
          'paraphrases', paraphraseId, paraphraseData);
      final data =
          await FirebaseUtils.fetchDocument('paraphrases', paraphraseId);
      if (data != null) {
        return ParaphraseResponse.fromJson(data);
      }
      throw Exception('생성된 재구성을 조회하지 못했습니다.');
    } catch (e) {
      print('재구성 생성 오류: $e');
      rethrow;
    }
  }

  // 재구성 조회
  Future<ParaphraseResponse?> fetchParaphrase(String paraphraseId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('paraphrases', paraphraseId);
      if (data != null) {
        return ParaphraseResponse.fromJson(data);
      }
      return null;
    } catch (e) {
      print('재구성 조회 오류: $e');
      return null;
    }
  }

  // 재구성 리스트 조회
  Future<ParaphraseListResponse> fetchParaphrases() async {
    try {
      final data =
          await FirebaseUtils.fetchCollection(collection: 'paraphrases');
      final paraphrases =
          data.map((item) => ParaphraseResponse.fromJson(item)).toList();
      return ParaphraseListResponse(data: paraphrases);
    } catch (e) {
      print('재구성 리스트 조회 오류: $e');
      rethrow;
    }
  }

  // 재구성 수정
  Future<ParaphraseResponse> updateParaphrase(
      String paraphraseId, ParaphraseUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'paraphrases', paraphraseId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('paraphrases', paraphraseId);
      if (data != null) {
        return ParaphraseResponse.fromJson(data);
      }
      throw Exception('수정된 재구성을 조회하지 못했습니다.');
    } catch (e) {
      print('재구성 수정 오류: $e');
      rethrow;
    }
  }

  // 재구성 삭제
  Future<void> deleteParaphrase(String paraphraseId) async {
    try {
      await FirebaseUtils.deleteDocument('paraphrases', paraphraseId);
    } catch (e) {
      print('재구성 삭제 오류: $e');
      rethrow;
    }
  }
}
