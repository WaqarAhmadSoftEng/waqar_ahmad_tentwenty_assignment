import 'package:dio/dio.dart';
import '../model/movie_detail_model.dart';
import '../model/movie_list_model.dart';
import '../model/trailer_model.dart';
import '../offline_database/movie_database.dart';

class MovieRepository {
  final String _apiKey = 'c629ce5f72740933b731d5fcebc1e89b';
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.themoviedb.org/3';

  // Fetch upcoming movies from the API
  Future<List<Movie>> getUpcomingMovies() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/movie/upcoming',
        queryParameters: {'api_key': _apiKey},
      );

      if (response.statusCode == 200) {
        final results = (response.data['results'] as List?) ?? [];
        final movies = results.map((movie) => Movie.fromJson(movie)).toList();

        // Save movies to the local database
        final db = await MovieDatabase.getDatabase();
        final movieDao = db.movieDao;
        for (var movie in movies) {
          await movieDao.insertMovie(movie);
        }

        return movies;
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw Exception('Error fetching movies: ${e.message}');
    }
  }


  // Fetch movies from the local database
  Future<List<Movie>> getLocalMovies() async {
    final db = await MovieDatabase.getDatabase();
    final movieDao = db.movieDao;
    return await movieDao.getAllMovies();
  }


  // Search for movies
  Future<List<Movie>> searchMovies(String query) async {
    final db = await MovieDatabase.getDatabase();
    final localMovies = await db.movieDao.searchMovies(query);



    if (localMovies.isNotEmpty) {
      return localMovies;
    }

    try {
      final response = await _dio.get(
        '$_baseUrl/search/movie',
        queryParameters: {'api_key': _apiKey, 'query': query},
      );

      if (response.statusCode == 200) {
        final results = (response.data['results'] as List?) ?? [];
        return results.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception('Failed to search movies: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw Exception('Error searching movies: ${e.message}');
    }
  }

  // Fetch movie details
  Future<MovieDetail> fetchMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/movie/$movieId',
        queryParameters: {'api_key': _apiKey},
      );

      if (response.statusCode == 200) {
        return MovieDetail.fromJson(response.data);
      } else {
        throw Exception('Failed to load movie details: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw Exception('Error fetching movie details: ${e.message}');
    }
  }

  // Fetch movie trailers
  Future<List<Trailer>> fetchMovieTrailers(int movieId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/movie/$movieId/videos',
        queryParameters: {'api_key': _apiKey},
      );

      if (response.statusCode == 200) {
        final results = (response.data['results'] as List?) ?? [];
        return results.map((json) => Trailer.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movie trailers: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw Exception('Error fetching movie trailers: ${e.message}');
    }
  }
}
