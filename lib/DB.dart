import 'dart:async';
import 'dart:core';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'Objects/user.dart';

class DB {
  static DB _db; //Singleton
  static Database _database;

  String userTable = "tblUser";
  String email = "fldEmail";
  String name = "fldName";
  String password = "fldPassword";
  String saltKey = "fldSaltKey";

  DB._createInstance();

  factory DB() {
    if (_db == null) {
      _db = DB._createInstance();
    }

    return _db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'users.db';

    // Open/create database at the following path
    var userDatabase =
        await openDatabase(path, version: 1, onCreate: _createDB);
    return userDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $userTable($email TEXT PRIMARY KEY, $name TEXT, $password TEXT, $saltKey)');
  }

  //Fetch operation: Get all users from DB.
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM $userTable');
    return result;
  }

  Future<int> insertNewUser(User user) async{
    Database db = await this.database;

    var result = await db.insert(userTable,user.toMap());
    return result;
  }

  Future<int> updateUser(User user) async{
    Database db = await this.database;

    var result = await db.update(userTable,user.toMap(), where: email = '?', whereArgs: [user.email]);
    return result;
  }

  Future<int> deleteUser(User userEmail) async{
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM tblUsers WHERE $email = $userEmail');
    return result;
  }

}
