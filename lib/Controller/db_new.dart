// ignore_for_file: depend_on_referenced_packages

import 'package:easflow_v1/Model/user_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  late Future<Database> _databaseFuture;

  DatabaseHelper.internal() {
    _databaseFuture = initDatabase();
  }

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }

    _db = await _databaseFuture;
    return _db!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'Agendium.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE User ( user_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, profil_img TEXT , email TEXT , password TEXT, access_code TEXT )");
      },
      version: 1,
    );
  }

  //USER
  Future<List<User>> getAllUsers() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('User');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['user_id'],
        username: maps[i]['name'],
        image: maps[i]['profil_img'],
        emailaddress: maps[i]['email'],
        password: maps[i]['password'],
        role: maps[i]['role'],
      );
    });
  }

  Future<User> getUser(int userId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.transaction((txn) async {
      return await txn.query(
        'User',
        where: 'user_id = ?',
        whereArgs: [userId],
        limit: 1,
      );
    });
    return User(
      id: maps.first['user_id'],
      username: maps.first['name'],
      image: maps.first['profil_img'],
      emailaddress: maps.first['email'],
      password: maps.first['password'],
      role: maps.first['role'],
    );
  }

  Future<String> getImage(int userId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.transaction((txn) async {
      return await txn.query(
        'User',
        where: 'user_id = ?',
        whereArgs: [userId],
        limit: 1,
      );
    });
    return maps.first['profil_img'];
  }

  Future<int> addUser(User user) async {
    final Database db = await database;
    int insertedId = await db.insert('User', user.toMap());

    return insertedId;
  }

  Future updateUser(User user) async {
    final Database db = await database;
    var batch = db.batch();
    batch.update('User', user.toMap(),
        where: 'user_id = ?', whereArgs: [user.id]);
    await batch.commit(noResult: true);
  }

  Future editUser(int userId, String name, String image) async {
    final Database db = await database;
    var batch = db.batch();
    batch.rawUpdate(
      'UPDATE User SET name = ?, profil_img = ? WHERE user_id = ?',
      [name, image, userId],
    );
    await batch.commit(noResult: true);
  }

  Future deleteUser(int id) async {
    final Database db = await database;
    var batch = db.batch();
    batch.delete('User', where: 'user_id = ?', whereArgs: [id]);
    await batch.commit(noResult: true);
  }
}
