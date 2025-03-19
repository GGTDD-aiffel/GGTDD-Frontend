import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtils {
  static final _firestore = FirebaseFirestore.instance;

  // 컬렉션 조회
  static Future<List<Map<String, dynamic>>> fetchCollection(
      String collection) async {
    try {
      final snapshot = await _firestore.collection(collection).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching collection: $e');
      return [];
    }
  }

  // 단일 문서 조회
  static Future<Map<String, dynamic>?> fetchDocument(
      String collection, String docId) async {
    try {
      final doc = await _firestore.collection(collection).doc(docId).get();
      return doc.exists ? doc.data() : null;
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }

  // 문서 쓰기
  static Future<bool> writeDocument(
      String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(docId).set(data);
      return true;
    } catch (e) {
      print('Error writing document: $e');
      return false;
    }
  }

  // 문서 수정
  static Future<bool> updateDocument(
      String collection, String docId, Map<String, dynamic> fields) async {
    try {
      await _firestore.collection(collection).doc(docId).update(fields);
      return true;
    } catch (e) {
      print('Error updating document: $e');
      return false;
    }
  }

  // 문서 삭제
  static Future<bool> deleteDocument(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
      return true;
    } catch (e) {
      print('Error deleting document: $e');
      return false;
    }
  }
}
