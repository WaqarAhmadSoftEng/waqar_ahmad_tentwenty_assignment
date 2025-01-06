
import 'package:equatable/equatable.dart';

abstract class SearchBarEvent extends Equatable {
  const SearchBarEvent();

  @override
  List<Object> get props => [];
}

class ToggleSearch extends SearchBarEvent {}
