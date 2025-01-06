import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchMovieDetails extends MovieDetailEvent {
  final int movieId;
  const FetchMovieDetails(this.movieId);
  @override
  List<Object?> get props => [movieId];
}

class FetchMovieTrailers extends MovieDetailEvent {
  final int movieId;
  const FetchMovieTrailers(this.movieId);
  @override
  List<Object?> get props => [movieId];
}