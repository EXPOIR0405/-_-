import 'package:flutter/material.dart';
import 'models/player.dart';

class EndingScreen extends StatelessWidget {
  final Player player;

  EndingScreen({required this.player});

  String _getEndingMessage() {
    String title = player.getTitle();
    double lossRate = player.illegalLossRate * 100;
    int totalIncome = player.totalIncome;

    if (title == '초보 작가') {
      return '당신은 꿈을 접고 웹툰 작가의 삶을 포기하게 되었습니다. 불법 웹툰 유통으로 인한 ${lossRate.toStringAsFixed(2)}%의 수익 손실로 생계를 유지할 수 없게 되었기 때문입니다. 이처럼 불법 웹툰으로 인해 누군가의 꿈이 산산조각 났군요. 당신의 재능은 어떻게 될까요?';
    } else if (title == '인기 작가') {
      return '당신은 인기 작가였지만, 불법 웹툰 유통으로 인해 ${lossRate.toStringAsFixed(2)}%의 수익을 잃었습니다. 결국 연재를 중단하고 다른 직업을 찾아 나섰습니다. 팬들은 실망했고, 당신의 이야기는 미완으로 남게 되었습니다. 불법 유통이 얼마나 많은 이야기를 중단시키는지 보여주는 안타까운 예시입니다.';
    } else {
      return '전설의 작가로 불렸던 당신도 결국 불법 웹툰 유통의 피해를 피해갈 수 없었습니다. ${lossRate.toStringAsFixed(2)}%의 수익 손실로 인해 작품의 퀄리티를 유지할 수 없게 되었고, 결국 은퇴를 선언했습니다. 한 시대를 풍미했던 작가의 붓이 꺾이는 순간, 우리는 불법 유통이 문화 산업에 얼마나 큰 타격을 주는지 목격하게 되었습니다.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('엔딩 화면'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('게임 종료!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text('당신의 최종 호칭: ${player.getTitle()}', style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),
                Text('최종 수익: ${player.totalIncome} 원', style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),
                Text(
                  _getEndingMessage(),
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('다시 시작하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}