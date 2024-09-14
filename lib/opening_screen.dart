import 'package:flutter/material.dart';
import 'game_screen.dart';

class OpeningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '웹툰작가로 살아남기',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // 버튼을 누르면 게임 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              child: Text('게임 시작하기', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}