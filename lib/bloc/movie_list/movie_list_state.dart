import 'package:equatable/equatable.dart';
import '../../model/movie_list_model.dart';

abstract class WatchState extends Equatable {
  @override
  List<Object> get props => [];
}

class WatchLoading extends WatchState {}

class WatchLoaded extends WatchState {
  final List<Movie> upcomingMovies;

  WatchLoaded(this.upcomingMovies);

  @override
  List<Object> get props => [upcomingMovies];
}

class WatchError extends WatchState {
  final String error;

  WatchError(this.error);

  @override
  List<Object> get props => [error];
}
