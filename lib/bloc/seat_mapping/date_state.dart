abstract class DateState {}

class DateSelected extends DateState {
  final int selectedDate;
  DateSelected(this.selectedDate);
}
