import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/theme.dart';

class EmotionPicker extends StatelessWidget {
  final String selectedEmotion;
  final Function(String) onEmotionSelected;

  EmotionPicker({
    required this.selectedEmotion,
    required this.onEmotionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: emotions.length,
        itemBuilder: (context, index) {
          final emotion = emotions[index];
          final isSelected = emotion == selectedEmotion;
          
          return GestureDetector(
            onTap: () => onEmotionSelected(emotion),
            child: Container(
              width: 90,
              margin: EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor.withOpacity(0.1) : Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    emotionIcons[emotion] ?? '😐',
                    style: TextStyle(fontSize: 28),
                  ),
                  SizedBox(height: 8),
                  Text(
                    emotion,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? primaryColor : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}