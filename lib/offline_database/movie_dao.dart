import 'package:floor/floor.dart';
import '../model/movie_list_model.dart';

@dao
abstract class MovieDao {
  // Insert a movie or replace it if the id already exists
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovie(Movie movie);

  // Fetch all movies
  @Query('SELECT * FROM movies')
  Future<List<Movie>> getAllMovies();

  // Search for movies by title
  @Query('SELECT * FROM movies WHERE title LIKE :query')
  Future<List<Movie>> searchMovies(String query);

  // Delete a movie
  @delete
  Future<void> deleteMovie(Movie movie);

}
