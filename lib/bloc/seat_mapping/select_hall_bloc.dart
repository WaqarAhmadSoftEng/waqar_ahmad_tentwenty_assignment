import 'package:flutter_bloc/flutter_bloc.dart';
import 'select_hall_event.dart';
import 'select_hall_state.dart';

class HallBloc extends Bloc<HallEvent, HallSelected> {
  HallBloc()
      : super(
          HallSelected(
            selectedHall: "Cinetech + hall 1",
            time: "12:30",
            price: "50",
            bonus: "2500",
          ),
        ) {
    on<SelectHallEvent>((event, emit) {
      emit(
        HallSelected(
          selectedHall: event.hallName,
          time: event.time,
          price: event.price,
          bonus: event.bonus,
        ),
      );
    });
  }
}
