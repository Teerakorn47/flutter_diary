import 'package:flutter/material.dart';
import '../models/diary_model.dart';
import '../services/firebase_service.dart';
import '../widgets/emotion_picker.dart';

class EditDiaryScreen extends StatefulWidget {
  final DiaryModel diary;

  EditDiaryScreen({required this.diary});

  @override
  _EditDiaryScreenState createState() => _EditDiaryScreenState();
}

class _EditDiaryScreenState extends State<EditDiaryScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descriptionController;
  late String _selectedEmotion;
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.diary.description);
    _selectedEmotion = widget.diary.emotion;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _updateDiary() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // สร้าง DiaryModel ใหม่ที่มีข้อมูลเดิม แต่อัปเดตเฉพาะ description และ emotion
        DiaryModel updatedDiary = DiaryModel(
          id: widget.diary.id,
          title: widget.diary.title, // title คงเดิม
          description: _descriptionController.text.trim(),
          emotion: _selectedEmotion,
          createdAt: widget.diary.createdAt, // createdAt คงเดิม
        );
        
        await _firebaseService.updateDiary(updatedDiary);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขไดอารี่'),
      ),
      body: _isLoading 
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // แสดงหัวเรื่องแต่ไม่ให้แก้ไข
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'หัวเรื่อง:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.diary.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'คำอธิบาย',
                        hintText: 'แก้ไขความรู้สึกของคุณ...',
                        alignLabelWithHint: true,
                      ),
                      maxLines: 8,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่คำอธิบาย';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      'อารมณ์ของคุณ:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    EmotionPicker(
                      selectedEmotion: _selectedEmotion,
                      onEmotionSelected: (emotion) {
                        setState(() {
                          _selectedEmotion = emotion;
                        });
                      },
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _updateDiary,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'บันทึกการแก้ไข',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}