import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/models/birthdayTodo.dart';
import 'package:todo_application/models/quickTodo.dart';
import 'dart:io';
import 'package:todo_application/models/reminderTodo.dart';

class DatabaseHelper {
  // database name
  static final _databasename = "todo.db";
  static final _databaseversion = 1;

  // the table name
  static final tableReminderTodo = "my_Reminder_table";
  static final tableQuickTodo = "my_Quick_table";
  static final tableBirthdayTodo = "my_birthday_table";

  // a database
  static Database _database;

  // privateconstructor
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // asking for a database
  Future<Database> get database async {
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
    await db.execute('''
      CREATE TABLE $tableReminderTodo (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        completed INTEGER,
        date TEXT NOT NULL,
        remindDate NOT NULL,
        remindTime NOT NULL
      )
      ''');
    await db.execute('''
        CREATE TABLE $tableQuickTodo(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        completed INTEGER,
        date TEXT NOT NULL
      )
    ''');
    await db.execute('''
        CREATE TABLE $tableBirthdayTodo(
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          date TEXT NOT NULL,
          birthDate TEXT NOT NULL
        )
    ''');
  }

  // functions to insert Reminder todo
  Future<void> insertReminderTodo(ReminderTodo reminderTodo) async {
    Database db = await instance.database;
    return await db.insert(
      tableReminderTodo,
      reminderTodo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
 
  //function to insert quick todo
  Future<void> insertQuickTodo(QuickTodo quickTodo) async {
    Database db = await instance.database;
    return await db.insert(
      tableQuickTodo,
      quickTodo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //
  Future<void> insertBirthdayTodo(BirthdayTodo birthdayTodo) async {
    Database db = await instance.database;
    return await db.insert(
      tableBirthdayTodo,
      birthdayTodo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // function to query all ReminderTodo's
  Future<List<ReminderTodo>> queryallReminderTodo() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableReminderTodo);
    print(maps);
    print('thats all');
    return List.generate(
      maps.length,
      (index) {
        return ReminderTodo(
          id: maps[index]['id'],
          title: maps[index]['title'],
          completed: maps[index]['completed'],
          date: maps[index]['date'],
          remindDate: maps[index]['remindDate'],
          remindTime: maps[index]['remindTime'],
        );
      },
    );
  }

  //function to query all QuickTodo's
  Future<List<QuickTodo>> queryallQuickTodo() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableQuickTodo);
    print(maps);
    print('thats all');
    return List.generate(
      maps.length,
      (index) {
        return QuickTodo(
          id: maps[index]['id'],
          name: maps[index]['name'],
          date: maps[index]['date'],
          completed: maps[index]['completed'],
        );
      },
    );
  }

  //
  Future<List<BirthdayTodo>> queryallBirthdayTodo() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableBirthdayTodo);
    print(maps);
    print('thats all');
    return List.generate(
      maps.length,
      (index) {
        return BirthdayTodo(
          id: maps[index]['id'],
          name: maps[index]['name'],
          date: maps[index]['date'],
          birthDate: maps[index]['birthDate']
        );
      },
    );
  }

  // delete reminder from database
  Future<void> deleteReminderTodo(String id) async {
    Database db = await instance.database;
    await db.delete(tableReminderTodo, where: "id = ?", whereArgs: [id]);
  }

  //delete quickTodo from database
  Future<void> deleteQuickTodo(String id) async {
    Database db = await instance.database;
    await db.delete(tableQuickTodo, where: "id = ?", whereArgs: [id]);
  }

  //delete birthdayTodo from database
  Future<void> deleteBirthdayTodo(String id) async {
    Database db = await instance.database;
    await db.delete(tableBirthdayTodo, where: "id = ?", whereArgs: [id]);
  }

  //update Reminder todo
  Future<void> updateReminderTodo(ReminderTodo reminderTodo) async {
    final db = await instance.database;
    await db.update(
      tableReminderTodo,
      reminderTodo.toMap(),
      where: "id = ?",
      whereArgs: [reminderTodo.id],
    );
  }

  //update quick Todo
  Future<void> updateQuickTodo(QuickTodo quickTodo) async {
    final db = await instance.database;
    await db.update(
      tableQuickTodo,
      quickTodo.toMap(),
      where: "id = ?",
      whereArgs: [quickTodo.id],
    );
  }

  //update birthday todo
  Future<void> updateBirthdayTodo(BirthdayTodo birthdayTodo) async {
    final db = await instance.database;
    await db.update(
      tableQuickTodo,
      birthdayTodo.toMap(),
      where: "id = ?",
      whereArgs: [birthdayTodo.id],
    );
  }

  //toggle reminder todo
  Future<void> toggleTodo(ReminderTodo reminderTodo) async {
    final db = await instance.database;
    reminderTodo.completed == 1 ? reminderTodo.completed = 0 : reminderTodo.completed = 1;
    await db.update(
      tableReminderTodo,
      reminderTodo.toMap(),
      where: "id = ?",
      whereArgs: [reminderTodo.id],
    );
  }

  Future<void> toggleQuickTodo(QuickTodo quickTodo) async {
    final db = await instance.database;
    quickTodo.completed == 1 ? quickTodo.completed = 0 : quickTodo.completed = 1;
    await db.update(
      tableQuickTodo,
      quickTodo.toMap(),
      where: "id = ?",
      whereArgs: [quickTodo.id],
    );
  }
}
