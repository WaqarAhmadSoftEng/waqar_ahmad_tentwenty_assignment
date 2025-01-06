import 'floor_database.dart';

class MovieDatabase {
  static AppDatabase? _database;

  static Future<AppDatabase> getDatabase() async {
    if (_database == null) {
      _database = await $FloorAppDatabase.databaseBuilder('movie_database.db').build();
    }
    return _database!;
  }
}
