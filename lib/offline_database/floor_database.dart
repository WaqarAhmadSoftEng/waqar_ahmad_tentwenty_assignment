import 'dart:async';
import 'package:floor/floor.dart';
import '../model/movie_list_model.dart';
import 'movie_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'floor_database.g.dart';


@Database(version: 1, entities: [Movie])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
}
