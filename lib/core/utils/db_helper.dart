import 'dart:async';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodoDatabaseHelper {
  static final TodoDatabaseHelper _instance = TodoDatabaseHelper._internal();
  static Database? _database;

  factory TodoDatabaseHelper() => _instance;

  TodoDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'todo.db');
    log("Databasepath : ${path}");

    // Check if the database file exists
    if (!(await databaseExists(path))) {
      // If the database file doesn't exist, create it
      return await openDatabase(path, version: 1, onCreate: _createDatabase);
    }

    // If the database file exists, just open it
    return await openDatabase(path);
  }


  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todo(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      taskDone INTEGER  -- Add taskDone column
    )
  ''');
  }

  Future<int> insertTodo(Map<String, dynamic> todo) async {
    Database db = await database;
    return await db.insert('todo', {
      'title': todo['title'],
      'description': todo['description'],
      'taskDone': todo['taskDone'] == true ? 1 : 0, // Convert bool to integer
    });
  }

  Future<List<Map<String, dynamic>>> fetchTodos() async {
    final Database db = await database;
    final todos = await db.query('todo');
    log('Todos: $todos');

    // Convert taskDone values from integer to boolean
    return todos.map((todo) => {
      ...todo,
      'taskDone': todo['taskDone'] == 1, // Convert integer to bool
    }).toList();
  }


  Future<int> updateTodo(Map<String, dynamic> todo) async {
    final Database db = await database;
    return await db.update('todo', todo, where: 'id = ?', whereArgs: [todo['id']]);
  }

  Future<int> deleteTodo(int id) async {
    final Database db = await database;
    return await db.delete('todo', where: 'id = ?', whereArgs: [id]);
  }
}


