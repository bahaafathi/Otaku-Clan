import 'dart:async';
import 'dart:io';

import 'package:myanime/models/favorite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBasefavorite {
  final String table = "favorite";
  final String id = "id";
  final String name = "name";

  final String imageUrl = "imageUrl";
  static final DataBasefavorite _instance = DataBasefavorite.internal();
  factory DataBasefavorite() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DataBasefavorite.internal();

  initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    var ourdb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourdb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table($id INTEGER , $name TEXT, $imageUrl TEXT)');
  }

  Future<int> savefavorite(FavoriteModel favorite) async {
    var dbfavorite = await db;

    int res = await dbfavorite.insert(table, favorite.tojson(),
        conflictAlgorithm: ConflictAlgorithm.fail);
    print(res);
    return res;
  }

  void deletfavorite(FavoriteModel favorite) async {
    var dbfavorite = await db;

    int res = await dbfavorite
        .delete(table, where: "$id=?", whereArgs: [favorite.id]);
    print(res);
  }

  Future<List<FavoriteModel>> getAllUsers() async {
    var dbfavorite = await db;
    List<Map<String, dynamic>> x = await dbfavorite.query(table);

    List<FavoriteModel> noteList = [];
    for (int i = 0; i < x.length; i++) {
      noteList.add(FavoriteModel.fromJson(x[i]));
    }
    if (noteList == null) {
      return null;
    } else
      return noteList;
  }
}
