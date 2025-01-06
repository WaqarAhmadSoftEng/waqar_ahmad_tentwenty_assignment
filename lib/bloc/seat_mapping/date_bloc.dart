import 'package:flutter_bloc/flutter_bloc.dart';
import 'date_event.dart';
import 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc() : super(DateSelected(1)) {
    on<SelectDateEvent>((event, emit) {
      emit(DateSelected(event.date));
    });
  }
}
