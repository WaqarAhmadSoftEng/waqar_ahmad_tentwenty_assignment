import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_assignment/bloc/seat_mapping/select_seat_event.dart';
import 'package:tentwenty_assignment/bloc/seat_mapping/select_seat_state.dart';

class SeatSelectionBloc extends Bloc<SeatSelectionEvent, SeatSelectionState> {
  SeatSelectionBloc() : super(const SeatSelectionState()) {
    on<SelectSeat>((event, emit) {
      emit(state.copyWith(
        selectedSeat: event.seat,
        selectedRow: event.row,
        totalPrice: event.price,
      ));
    });

    on<ZoomIn>((event, emit) {
      emit(state.copyWith(
        zoomLevel: (state.zoomLevel + 0.1).clamp(0.5, 3.0),
      ));
    });

    on<ZoomOut>((event, emit) {
      emit(state.copyWith(
        zoomLevel: (state.zoomLevel - 0.1).clamp(0.5, 3.0),
      ));
    });

    on<ResetSelection>((event, emit) {
      emit(const SeatSelectionState());
    });
  }
}
