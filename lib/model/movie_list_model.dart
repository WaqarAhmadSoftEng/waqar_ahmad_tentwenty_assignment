import 'package:floor/floor.dart';

@Entity(tableName: 'movies')
class Movie {
  @PrimaryKey(autoGenerate: false)
  final int id;

  final String? title;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;

  Movie({
    required this.id,
    this.title,
    this.overview,
    this.posterPath,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: int.tryParse(json['id'].toString()) ?? 0,
    title: json['title'],
    overview: json['overview'],
    posterPath: json['poster_path'],
    releaseDate: json['release_date'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'release_date': releaseDate,
    };
  }
}
