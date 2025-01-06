import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repo/movies_repository.dart';
import 'movie_list_event.dart';
import 'movie_list_state.dart';

class MovieListBloc extends Bloc<WatchEvent, WatchState> {
  final MovieRepository _movieRepository;

  MovieListBloc(this._movieRepository) : super(WatchLoading()) {
    on<FetchUpcomingMovies>((event, emit) async {
      try {
        emit(WatchLoading());

        final movies = await _movieRepository.getUpcomingMovies();
        emit(WatchLoaded(movies));
      } catch (_) {
        final localMovies = await _movieRepository.getLocalMovies();
        if (localMovies.isNotEmpty) {
          emit(WatchLoaded(localMovies));
        } else {
          print('No internet and no cached data');
          emit(WatchError('Failed to load movies. No internet connection and no cached data.'));
        }
      }
    });

    on<SearchMovies>((event, emit) async {
      try {
        emit(WatchLoading());
        final movies = await _movieRepository.searchMovies(event.query);
        emit(WatchLoaded(movies));
      } catch (e) {
        emit(WatchError('Error searching movies: $e'));
      }
    });
  }
}