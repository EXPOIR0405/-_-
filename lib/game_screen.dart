import 'package:flutter/material.dart';
import 'models/player.dart';
import 'package:intl/intl.dart'; // 날짜 포맷
import 'package:intl/date_symbol_data_local.dart'; // 추가
import 'ending_screen.dart'; // 엔딩 화면으로 이동하기 위한 import


class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Player player = Player(); // 플레이어 정보
  int touchCount = 0;
  int requiredTouches = 80;
  double pencilPosition = 0.0; // 연필의 위치를 조정하기 위한 변수
  double opacity = 0.0; // 이미지 서서히 나타나게 하기 위한 변수

  List<String> imagePaths = [
    'assets/webtoon_drawing1.png', // 그림 파일 경로
    'assets/webtoon_drawing2.png',
    'assets/webtoon_drawing3.png',
    'assets/webtoon_drawing4.png',
    'assets/webtoon_drawing5.png',
    'assets/webtoon_drawing6.png',
    'assets/webtoon_drawing7.png',
    'assets/webtoon_drawing8.png',
    'assets/webtoon_drawing9.png',
    'assets/webtoon_drawing10.png',
    'assets/webtoon_drawing11.png',
    'assets/webtoon_drawing12.png',
    'assets/webtoon_drawing13.png',
    'assets/webtoon_drawing14.png',
    // 추가 그림 경로...
  ];

  void _onPencilTap() {
    setState(() {
      if (touchCount < requiredTouches) {
        touchCount++;
        pencilPosition += 10.0; // 연필의 위치를 변화시켜 움직이는 효과
        opacity += 1.0 / imagePaths.length; // 클릭할 때마다 이미지가 서서히 나타남
        player.drawFrame(); // 수익 및 인기도 갱신
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ko_KR', null); // 추가
  }

  String getCurrentMonth() {
    final now = DateTime.now();
    return DateFormat.MMMM('ko_KR').format(now); // 현재 월을 반환
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('웹툰작가로 살아남기'),
      ),
      body: Column(
        children: [
          // 현재 달 표시
          Text('현재 달: ${getCurrentMonth()}', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),

          // 연필 클릭 애니메이션
          GestureDetector(
            onTap: _onPencilTap,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              transform: Matrix4.translationValues(pencilPosition, 0, 0),
              child: Image.asset(
                'assets/pencil.png', // 연필 이미지
                width: 100,
                height: 100,
              ),
            ),
          ),
          SizedBox(height: 20),

          // 도화지 위에 이미지가 서서히 나타나는 부분
          Expanded(
            child: Center(
              child: Opacity(
                opacity: opacity,
                child: Image.asset(imagePaths[touchCount % imagePaths.length]),
              ),
            ),
          ),

          // 버튼 밑에 수익, 불법웹툰 감소율, 총 수입 표시
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('이번화 수익: ${player.income} 원', style: TextStyle(fontSize: 20)),
                Text('불법 웹툰으로 인한 수익 감소율: ${(player.illegalLossRate * 100).toStringAsFixed(2)} %', style: TextStyle(fontSize: 20)),
                Text('총 수입: ${player.totalIncome} 원', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
// 게임 종료하기 버튼
          ElevatedButton(
            onPressed: () {
              // 게임 종료 후 엔딩 화면으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EndingScreen(player: player)),
              );
            },
            child: Text('게임 종료하기'),
          ),

        ],
      ),
    );
  }
}