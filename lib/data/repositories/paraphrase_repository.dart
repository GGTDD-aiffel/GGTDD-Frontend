import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggtdd_frontend/data/model/api_paraphrase_model.dart';
import 'package:ggtdd_frontend/ui/domain/models/paraphrase_model.dart';
import 'package:ggtdd_frontend/utils/firebase_utils.dart';

class ParaphraseRepository {
  Future<ParaphraseCreateResponse> createParaphrase(
      ParaphraseCreateRequest request) async {
    try {
      final paraphraseId =
          FirebaseFirestore.instance.collection('paraphrases').doc().id;
      final paraphraseData = request.toJson();
      await FirebaseUtils.writeDocument(
          'paraphrases', paraphraseId, paraphraseData);
      final data =
          await FirebaseUtils.fetchDocument('paraphrases', paraphraseId);
      if (data != null) {
        return ParaphraseCreateResponse(
          code: 200,
          status: 'success',
          message: '재구성 생성 성공',
          data: ParaphraseResponse.fromJson(data, docId: paraphraseId),
        );
      }
      throw Exception('생성된 재구성을 조회하지 못했습니다.');
    } catch (e) {
      print('재구성 생성 오류: $e');
      return ParaphraseCreateResponse(
        code: 500,
        status: 'error',
        message: '재구성 생성 실패: $e',
        data: null,
      );
    }
  }

  Future<ParaphraseGetResponse> fetchParaphrase(String paraphraseId) async {
    try {
      final data =
          await FirebaseUtils.fetchDocument('paraphrases', paraphraseId);
      if (data != null) {
        return ParaphraseGetResponse(
          code: 200,
          status: 'success',
          message: '재구성 조회 성공',
          data: ParaphraseResponse.fromJson(data, docId: paraphraseId),
        );
      }
      return ParaphraseGetResponse(
        code: 404,
        status: 'not_found',
        message: '재구성을 찾을 수 없습니다.',
        data: null,
      );
    } catch (e) {
      print('재구성 조회 오류: $e');
      return ParaphraseGetResponse(
        code: 500,
        status: 'error',
        message: '재구성 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<ParaphraseListResponseDto> fetchParaphrases() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('paraphrases').get();
      final paraphrases = snapshot.docs.map((doc) {
        return Paraphrase.fromJson(doc.data(), docId: doc.id);
      }).toList();
      return ParaphraseListResponseDto(
        code: 200,
        status: 'success',
        message: '재구성 리스트 조회 성공',
        data: ParaphraseListResponse(paraphrases: paraphrases),
      );
    } catch (e) {
      print('재구성 리스트 조회 오류: $e');
      return ParaphraseListResponseDto(
        code: 500,
        status: 'error',
        message: '재구성 리스트 조회 실패: $e',
        data: null,
      );
    }
  }

  Future<ParaphraseUpdateResponse> updateParaphrase(
      String paraphraseId, ParaphraseUpdateRequest request) async {
    try {
      await FirebaseUtils.updateDocument(
          'paraphrases', paraphraseId, request.toJson());
      final data =
          await FirebaseUtils.fetchDocument('paraphrases', paraphraseId);
      if (data != null) {
        return ParaphraseUpdateResponse(
          code: 200,
          status: 'success',
          message: '재구성 수정 성공',
          data: ParaphraseResponse.fromJson(data, docId: paraphraseId),
        );
      }
      throw Exception('수정된 재구성을 조회하지 못했습니다.');
    } catch (e) {
      print('재구성 수정 오류: $e');
      return ParaphraseUpdateResponse(
        code: 500,
        status: 'error',
        message: '재구성 수정 실패: $e',
        data: null,
      );
    }
  }

  Future<ParaphraseDeleteResponse> deleteParaphrase(String paraphraseId) async {
    try {
      await FirebaseUtils.deleteDocument('paraphrases', paraphraseId);
      return ParaphraseDeleteResponse(
        code: 200,
        status: 'success',
        message: '재구성 삭제 성공',
        data: null,
      );
    } catch (e) {
      print('재구성 삭제 오류: $e');
      return ParaphraseDeleteResponse(
        code: 500,
        status: 'error',
        message: '재구성 삭제 실패: $e',
        data: null,
      );
    }
  }
}
