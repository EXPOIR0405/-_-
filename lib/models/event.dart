import 'dart:math';
import 'player.dart'; // Player 클래스를 가져옵니다.

class Event {
  final String title;
  final String description;
  final Function(Player) effect;

  Event(this.title, this.description, this.effect);
}

class EventManager {
  static final List<Event> events = [
    Event(
      '팬아트 이벤트',
      '팬들이 당신의 웹툰 캐릭터의 팬아트를 그려 SNS에 공유했습니다.',
      (Player player) {
        player.popularity += 2;
        player.income += 100000;
      },
    ),
    Event(
      '불법 웹툰 유통',
      '당신의 웹툰이 불법 사이트에 유출되었습니다.',
      (Player player) {
        player.illegalLossRate += 0.05;
        if (player.illegalLossRate > 0.3) player.illegalLossRate = 0.3;
      },
    ),
    Event(
      '웹툰 공모전 수상',
      '당신의 웹툰이 유명 공모전에서 수상했습니다!',
      (Player player) {
        player.popularity += 5;
        player.income += 500000;
      },
    ),
    Event(
      '작가 사인회',
      '팬들과 직접 만나는 사인회를 개최했습니다.',
      (Player player) {
        player.popularity += 3;
      },
    ),
    Event(
      '웹툰 드라마화',
      '당신의 웹툰이 드라마로 제작되기로 결정되었습니다!',
      (Player player) {
        player.popularity += 10;
        player.income *= 2;
      },
    ),
    Event(
      '작업 지연',
      '건강 악화로 인해 연재가 지연되었습니다.',
      (Player player) {
        player.popularity -= 2;
        if (player.popularity < 0) player.popularity = 0;
      },
    ),
  ];

  static Event getRandomEvent() {
    final random = Random();
    return events[random.nextInt(events.length)];
  }
}
