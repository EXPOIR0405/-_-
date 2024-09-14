import 'package:flutter/material.dart';
import 'models/player.dart';

class EndingScreen extends StatelessWidget {
  final Player player;

  EndingScreen({required this.player});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('엔딩 화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('게임 종료!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('당신의 호칭: ${player.getTitle()}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('최종 수익: ${player.totalIncome} 원', style: TextStyle(fontSize: 24)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // 다시 시작하기 버튼을 누르면 게임 화면으로 돌아감
                Navigator.pop(context);
              },
              child: Text('다시 시작하기'),
            ),
          ],
        ),
      ),
    );
  }
}