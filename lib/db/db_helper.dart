import 'package:explore_city/model/model_city.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static const _databaseName = 'city.db';
  static const _cityTable = 'city_table';
  static const _databaseVersion = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $_cityTable('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, cityName STRING, cityDiscription TEXT, imageUrl STRING, stateName STRING'
        ')');
  }

  Future<int> insertTask(City city) async {
    Database? db = await DBHelper._database;
    return await db!.insert(_cityTable, {
      'cityName': city.cityName,
      'imageUrl': city.imageUrl ?? '',
      'stateName': city.stateName,
      'cityDiscription': city.cityDiscription,
    });
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await DBHelper._database;
    return await db!.query(_cityTable);
  }

  Future<int> delete(int id) async {
    Database? db = await DBHelper._database;
    return await db!.delete(_cityTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateAllFields(City city) async {
    return await _database!.rawUpdate('''
    UPDATE $_cityTable
    SET cityName = ?, cityDiscription = ?, imageUrl = ?, stateName = ?
    WHERE id = ?
    ''', [
      city.cityName,
      city.cityDiscription,
      city.imageUrl,
      city.stateName,
      city.id
    ]);
  }

  Future<int> update(int id) async {
    return await _database!.rawUpdate('''
    UPDATE $_cityTable
    SET isCompleted = ?, color = ?
    WHERE id = ?
    ''', [1, 1, id]);
  }
}
