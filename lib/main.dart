import 'package:flutter/material.dart';
import 'opening_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '웹툰작가로 살아남기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OpeningScreen(), // 처음에 오프닝 화면으로 시작
    );
  }
}