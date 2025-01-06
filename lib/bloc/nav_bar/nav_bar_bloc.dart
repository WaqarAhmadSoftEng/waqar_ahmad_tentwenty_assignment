import 'package:bloc/bloc.dart';
import 'nav_bar_event.dart';
import 'nav_bar_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<ChangeScreenIndex>((event, emit) {
      emit(state.copyWith(screenIndex: event.newIndex));
    });
  }
}
