
import 'package:equatable/equatable.dart';

class SearchBarState extends Equatable {
  final bool isSearching;

  const SearchBarState({required this.isSearching});

  SearchBarState copyWith({
    bool? isSearching,
  }) {
    return SearchBarState(
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object> get props => [isSearching];
}