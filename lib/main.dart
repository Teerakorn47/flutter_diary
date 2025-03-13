import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/diary_list_screen.dart';
import 'utils/theme.dart';
import 'package:diary/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'บันทึกไดอารี่ประจำวัน',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: DiaryListScreen(),
    );
  }
}