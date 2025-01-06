abstract class HallState {}

class HallSelected extends HallState {
  final String selectedHall;
  final String time;
  final String price;
  final String bonus;

  HallSelected({
    required this.selectedHall,
    required this.time,
    required this.price,
    required this.bonus,
  });
}
