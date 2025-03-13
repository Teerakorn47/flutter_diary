import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/diary_model.dart';
import '../utils/constants.dart';

class DiaryCard extends StatelessWidget {
  final DiaryModel diary;
  final VoidCallback onTap;

  DiaryCard({required this.diary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'อารมณ์: ${diary.emotion}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(diary.createdAt),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}