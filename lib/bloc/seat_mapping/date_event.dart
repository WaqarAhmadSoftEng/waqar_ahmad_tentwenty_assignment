abstract class DateEvent {}

class SelectDateEvent extends DateEvent {
  final int date;

  SelectDateEvent(this.date);
}