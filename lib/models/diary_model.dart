// ต้องเพิ่ม import ของ Timestamp
import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryModel {
  String id;
  String title;
  String description;
  String emotion;
  DateTime createdAt;

  DiaryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.emotion,
    required this.createdAt,
  });

  // แปลงข้อมูลจาก Firestore มาเป็น DiaryModel
  factory DiaryModel.fromMap(Map<String, dynamic> map, String documentId) {
    return DiaryModel(
      id: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      emotion: map['emotion'] ?? 'ปกติ',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // แปลงข้อมูลจาก DiaryModel เป็น Map เพื่อเก็บใน Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'emotion': emotion,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}