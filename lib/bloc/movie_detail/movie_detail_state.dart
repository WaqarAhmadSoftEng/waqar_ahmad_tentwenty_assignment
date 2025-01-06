import 'package:equatable/equatable.dart';
import '../../model/movie_detail_model.dart';
import '../../model/trailer_model.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  final List<Trailer> trailers;
  const MovieDetailLoaded(this.movieDetail, this.trailers);

  @override
  List<Object?> get props => [movieDetail];
}

class MovieDetailError extends MovieDetailState {
  final String errorMessage;
  const MovieDetailError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}