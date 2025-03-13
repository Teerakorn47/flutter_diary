import 'package:flutter/material.dart';
import '../models/diary_model.dart';
import '../services/firebase_service.dart';
import '../widgets/diary_card.dart';
import 'add_diary_screen.dart';
import 'diary_detail_screen.dart';

class DiaryListScreen extends StatefulWidget {
  @override
  _DiaryListScreenState createState() => _DiaryListScreenState();
}

class _DiaryListScreenState extends State<DiaryListScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บันทึกไดอารี่ประจำวัน'),
      ),
      body: StreamBuilder<List<DiaryModel>>(
        stream: _firebaseService.getDiaries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('ไม่พบข้อมูลไดอารี่'));
          }
          
          List<DiaryModel> diaries = snapshot.data!;
          
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: diaries.length,
            itemBuilder: (context, index) {
              DiaryModel diary = diaries[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: DiaryCard(
                  diary: diary,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiaryDetailScreen(diary: diary),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDiaryScreen()),
          );
        },
      ),
    );
  }
}