import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtils {
  static final _firestore = FirebaseFirestore.instance;

  // 컬렉션 조회 (쿼리 지원 추가)
  static Future<List<Map<String, dynamic>>> fetchCollection({
    required String collection,
    Map<String, dynamic>? whereConditions,
    int? limit,
    String? orderBy,
    bool descending = false,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection(collection);

      // Where 조건 적용
      if (whereConditions != null) {
        whereConditions.forEach((key, value) {
          query = query.where(key, isEqualTo: value);
        });
      }

      // Limit 적용
      if (limit != null) {
        query = query.limit(limit);
      }

      // OrderBy 적용
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('컬렉션 조회 오류: $e');
      return [];
    }
  }

  // 기존 메서드 유지
  static Future<Map<String, dynamic>?> fetchDocument(
      String collection, String docId) async {
    try {
      final doc = await _firestore.collection(collection).doc(docId).get();
      return doc.exists ? doc.data() : null;
    } catch (e) {
      print('문서 조회 오류: $e');
      return null;
    }
  }

  static Future<bool> writeDocument(
      String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(docId).set(data);
      return true;
    } catch (e) {
      print('문서 쓰기 오류: $e');
      return false;
    }
  }

  static Future<bool> updateDocument(
      String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
      return true;
    } catch (e) {
      print('문서 수정 오류: $e');
      return false;
    }
  }

  static Future<bool> deleteDocument(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
      return true;
    } catch (e) {
      print('문서 삭제 오류: $e');
      return false;
    }
  }
}
