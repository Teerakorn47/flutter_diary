import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/diary_model.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  final CollectionReference diaryCollection = 
      FirebaseFirestore.instance.collection('Diary');
  
  // ดึงข้อมูลไดอารี่ทั้งหมด
  Stream<List<DiaryModel>> getDiaries() {
    return diaryCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return DiaryModel.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
  
  // เพิ่มไดอารี่ใหม่
  Future<void> addDiary(DiaryModel diary) async {
    await diaryCollection.doc(diary.id).set(diary.toMap());
  }
  
  // อัปเดตไดอารี่
  Future<void> updateDiary(DiaryModel diary) async {
    await diaryCollection.doc(diary.id).update({
      'description': diary.description,
      'emotion': diary.emotion,
    });
  }
  
  // ลบไดอารี่
  Future<void> deleteDiary(String id) async {
    await diaryCollection.doc(id).delete();
  }
}