import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repo/movies_repository.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository _movieRepository;

  MovieDetailBloc(this._movieRepository) : super(MovieDetailInitial()) {
    on<FetchMovieDetails>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        final movieDetail = await _movieRepository.fetchMovieDetails(event.movieId);
        final trailer = await _movieRepository.fetchMovieTrailers(event.movieId);
        emit(MovieDetailLoaded(movieDetail, trailer));
      } catch (e) {
        emit(MovieDetailError(e.toString()));
      }
    });
  }
}
