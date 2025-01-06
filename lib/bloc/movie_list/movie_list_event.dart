import 'package:equatable/equatable.dart';

abstract class WatchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUpcomingMovies extends WatchEvent {}

class SearchMovies extends WatchEvent {
  final String query;

  SearchMovies(this.query);

  @override
  List<Object> get props => [query];
}