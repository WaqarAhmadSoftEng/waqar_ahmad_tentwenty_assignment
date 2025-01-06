import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwenty_assignment/bloc/search/search_event.dart';
import 'package:tentwenty_assignment/bloc/search/search_state.dart';

class SearchBarBloc extends Bloc<SearchBarEvent, SearchBarState> {
  SearchBarBloc() : super(const SearchBarState(isSearching: false)) {
    on<ToggleSearch>((event, emit) {
      emit(state.copyWith(isSearching: !state.isSearching));
    });
  }
}