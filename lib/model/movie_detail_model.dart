import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable{
  final String title;
  final String overview;
  final String posterPath;

  MovieDetail({
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
    );
  }

  @override
  List<Object?> get props => [title, overview, posterPath];
}
