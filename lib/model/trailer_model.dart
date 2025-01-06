import 'package:equatable/equatable.dart';

class Trailer extends Equatable {
  final String key;
  final String name;

  Trailer({
    required this.key,
    required this.name,
  });

  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(
      key: json['key'] ?? '',
      name: json['name'] ?? '',
    );
  }

  @override
  List<Object> get props => [key, name];
}
