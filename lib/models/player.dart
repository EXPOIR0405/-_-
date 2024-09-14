import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Player {
  int income = 800000; // 한화당 수익
  double illegalLossRate = 0.03; // 초기 감소율 3%
  int totalIncome = 0;
  int popularity = 0; // 인기도
  int monthsPassed = 0;
  late AudioPlayer backgroundMusicPlayer;

  Player() {
    _initBackgroundMusic();
  }

  void _initBackgroundMusic() async {
    backgroundMusicPlayer = AudioPlayer();
    await backgroundMusicPlayer.setSource(AssetSource('assets/background_music.mp3'));
    await backgroundMusicPlayer.setReleaseMode(ReleaseMode.loop);
    await backgroundMusicPlayer.resume();
  }

  void calculateIncome(BuildContext context) {
    double baseIncome = 800000 * (1 + popularity * 0.1); // 인기도에 따라 수익 증가
    int lostIncome = (baseIncome * illegalLossRate).round();
    income = (baseIncome - lostIncome).round();
    totalIncome += income;
    
    // 불법 웹툰으로 인한 수익 감소 알림
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('불법 웹툰 때문에 수익이 $lostIncome원 만큼 줄었습니다')),
    );

    monthsPassed++;
    if (monthsPassed % 4 == 0) {
      payMonthlyExpenses(context);
    }
  }

  void payMonthlyExpenses(BuildContext context) {
    totalIncome -= 800000;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('월세와 생활비'),
          content: Text('월세와 생활비로 80만원이 지출되었습니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void drawFrame() {
    popularity += 1; // 인기도 상승
  }

  String getTitle() {
    // 인기도에 따라 호칭 변경
    if (popularity < 10) {
      return '초보 작가';
    } else if (popularity < 50) {
      return '인기 작가';
    } else {
      return '전설의 작가';
    }
  }

  void dispose() {
    backgroundMusicPlayer.dispose();
  }
}