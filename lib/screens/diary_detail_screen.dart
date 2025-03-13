import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/diary_model.dart';
import '../services/firebase_service.dart';
import '../utils/constants.dart';
import 'edit_diary_screen.dart';

class DiaryDetailScreen extends StatelessWidget {
  final DiaryModel diary;
  final FirebaseService _firebaseService = FirebaseService();

  DiaryDetailScreen({required this.diary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดไดอารี่'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditDiaryScreen(diary: diary),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _showDeleteConfirmation(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // หัวเรื่องและวันที่
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            diary.title,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            emotionIcons[diary.emotion] ?? '😐',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'อารมณ์: ${diary.emotion}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'บันทึกเมื่อ: ${DateFormat('dd/MM/yyyy HH:mm').format(diary.createdAt)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            // เนื้อหาไดอารี่
            Card(
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'รายละเอียด:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Text(
                        diary.description,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ยืนยันการลบ'),
        content: Text('คุณต้องการลบไดอารี่นี้ใช่หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // ปิด dialog
              
              try {
                await _firebaseService.deleteDiary(diary.id);
                Navigator.pop(context); // กลับไปหน้า list
                
                // แสดงข้อความยืนยันการลบ
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('ลบไดอารี่เรียบร้อยแล้ว')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
                );
              }
            },
            child: Text(
              'ลบ',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}