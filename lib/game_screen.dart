import 'package:flutter/material.dart';
import 'models/player.dart';
import 'package:intl/intl.dart'; // 날짜 포맷
import 'package:intl/date_symbol_data_local.dart'; // 추가
import 'ending_screen.dart'; // 엔딩 화면으로 이동하기 위한 import

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  Player player = Player(); // 플레이어 정보
  int touchCount = 0;
  int requiredTouches = 80;
  double opacity = 0.0; // 이미지 서서히 나타나게 하기 위한 변수
  late AnimationController _controller;
  late Animation<double> _animation;
  String currentImage = 'assets/webtoon_drawing1.png'; // 현재 그리는 이미지
  DateTime currentDate = DateTime(DateTime.now().year, 1, 1); // 1월 1일부터 시작
  int weeksPassed = 0;

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
        _controller.forward(from: 0.0);
      }
      if (touchCount == requiredTouches) {
        // 한 화가 완성되면 수익 계산 및 상태 업데이트
        player.calculateIncome();
        player.popularity += 1;
        player.illegalLossRate += 0.03;
        currentImage = imagePaths[imagePaths.indexOf(currentImage) + 1 % imagePaths.length];
        touchCount = 0;
        weeksPassed++;
        currentDate = currentDate.add(Duration(days: 7));
      }
    });
  }

  void _resetGame() {
    setState(() {
      player = Player();
      touchCount = 0;
      weeksPassed = 0;
      currentDate = DateTime(DateTime.now().year, 1, 1);
      currentImage = imagePaths[0];
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ko_KR', null);
    player.income = 800000; // 기본 수입 설정
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -0.2, end: 0.2).animate(_controller) // 회전 각도 변경
      ..addListener(() {
        setState(() {});
      });
  }

  String getCurrentDate() {
    return DateFormat('yyyy년 MM월 dd일', 'ko_KR').format(currentDate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetGame,
            tooltip: '게임 초기화',
          ),
        ],
      ),
      body: Column(
        children: [
          Text('현재 날짜: ${getCurrentDate()}', style: TextStyle(fontSize: 20)),
          Text('지난 주: $weeksPassed', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),

          GestureDetector(
            onTap: _onPencilTap,
            child: Transform.rotate(
              angle: _animation.value,
              child: Container(
                width: 100,
                height: 100,
                child: Image.asset('assets/pencil.png'),
              ),
            ),
          ),
          SizedBox(height: 20),

          Text('남은 터치 횟수: ${requiredTouches - touchCount}', 
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('연필을 클릭해주세요', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),

          // 도화지 위에 이미지가 아래에서부터 나타나는 부분
          Expanded(
            child: Center(
              child: ClipRect(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: touchCount / requiredTouches,
                  child: Image.asset(
                    currentImage,
                    width: MediaQuery.of(context).size.width * 0.5, // 화면 너비의 50%로 설정
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // 버튼 밑에 수익, 불법웹툰 감소율, 총 수입 표시
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('인기도: ${player.popularity}', style: TextStyle(fontSize: 20)),
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

// PencilPainter 클래스는 더 이상 필요하지 않으므로 삭제할 수 있습니다.