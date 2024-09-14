class Player {
  int income = 800000; // 한화당 수익
  double illegalLossRate = 0.03; // 불법 웹툰으로 인한 수익 감소율
  int totalIncome = 0;
  int popularity = 0; // 인기도

  void drawFrame() {
    int currentIncome = income - (income * illegalLossRate).toInt();
    totalIncome += currentIncome;
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
}