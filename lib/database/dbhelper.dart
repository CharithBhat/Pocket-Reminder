import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

import 'package:todo_application/models/todo.dart';

class DatabaseHelper {
  // database name
  static final _databasename = "todo.db";
  static final _databaseversion = 1;

  // the table name
  static final table = "my_table";

  // a database
  static Database _database;

  // privateconstructor
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // asking for a database
  Future<Database> get databse async {
    if (_database != null) return _database;

    // create a database if one doesn't exist
    _database = await _initDatabase();
    return _database;
  }

  // function to return a database
  _initDatabase() async {
    Directory documentdirecoty = await getApplicationDocumentsDirectory();
    String path = join(documentdirecoty.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  // create a database since it doesn't exist
  Future _onCreate(Database db, int version) async {
    // sql code
    await db.execute('''
      CREATE TABLE $table (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        completed INTEGER,
        date TEXT NOT NULL
      )
      ''');
  }

  // functions to insert data
  Future<void> insertTodo(Todo todo) async {
    Database db = await instance.databse;
    return await db.insert(
      table,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // function to query all the rows
  Future<List<Todo>> queryall() async {
    Database db = await instance.databse;
    final List<Map<String, dynamic>> maps = await db.query(table);
    print(maps);
    print('thats all');
    return List.generate(
      maps.length,
      (index) {
        return Todo(
          id: maps[index]['id'],
          title: maps[index]['title'],
          description: maps[index]['description'],
          completed: maps[index]['completed'],
          date: maps[index]['date'],
        );
      },
    );
  }

  // function to delete some data
  Future<void> deleteTodo(String id) async {
    Database db = await instance.databse;
    await db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await instance.databse;
    await db.update(
      table,
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
    );
  }
}
