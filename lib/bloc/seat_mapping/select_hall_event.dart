abstract class HallEvent {}

class SelectHallEvent extends HallEvent {
  final String hallName;
  final String time;
  final String price;
  final String bonus;

  SelectHallEvent({
    required this.hallName,
    required this.time,
    required this.price,
    required this.bonus,
  });
}
