import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/diary_model.dart';
import '../services/firebase_service.dart';
import '../utils/constants.dart';
import '../widgets/emotion_picker.dart';

class AddDiaryScreen extends StatefulWidget {
  @override
  _AddDiaryScreenState createState() => _AddDiaryScreenState();
}

class _AddDiaryScreenState extends State<AddDiaryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedEmotion = 'ปกติ';
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveDiary() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        var uuid = Uuid();
        DiaryModel newDiary = DiaryModel(
          id: uuid.v4(),
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          emotion: _selectedEmotion,
          createdAt: DateTime.now(),
        );
        
        await _firebaseService.addDiary(newDiary);
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
        title: Text('เพิ่มไดอารี่ใหม่'),
      ),
      body: _isLoading 
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'หัวเรื่อง',
                        hintText: 'ใส่หัวเรื่องของไดอารี่',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่หัวเรื่อง';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'คำอธิบาย',
                        hintText: 'บันทึกความรู้สึกของคุณวันนี้...',
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
                      onPressed: _saveDiary,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'บันทึกไดอารี่',
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