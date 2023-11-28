import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../class/user.dart';

class DatabaseHelper {
  static late Database _database;

  static Future<void> initializeDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();

    _database = await openDatabase(
      join(await getDatabasesPath(), 'sport.db'),
      onCreate: (db, version) {
        return db.execute('''
           CREATE TABLE Users(id INTEGER PRIMARY KEY, name TEXT, lastname TEXT, age INTEGER, phone TEXT)
        ''');
      },
      version: 1,
    );
  }

  static Database get database => _database;

  static Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'Users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Users');
    return List.generate(maps.length, (index) {
      return User(
        id: maps[index]['id'],
        name: maps[index]['name'],
        lastname: maps[index]['lastname'],
        age: maps[index]['age'],
        phone: maps[index]['phone'],
      );
    });
  }

  static Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      'Users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<void> deleteUser(int? id) async {
    final db = await database;
    await db.delete(
      'Users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}