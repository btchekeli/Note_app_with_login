import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ------------------ Modèle Utilisateur ------------------

class User {
  final int? id;
  final String username;
  final String password;

  User({this.id, required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {'id': id, 'username': username, 'password': password};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }
}

// ------------------ Modèle Notes ------------------

class Note {
  int? id;
  String title;
  String content;

  Note({this.id, required this.title, required this.content});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'content': content};
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(id: map['id'], title: map['title'], content: map['content']);
  }
}

// ------------------ DatabaseHelper ------------------

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  static const String _dbName = 'app_database.db';
  static const int _dbVersion = 1;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        // Création de la table des utilisateurs
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            password TEXT NOT NULL
          )
        ''');
        // Création de la table des notes
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Pour fermer la base
  Future<void> close() async {
    final db = await database;
    db.close();
  }

  // ------------------ CRUD Utilisateur ------------------

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUserByUsername(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // ------------------ CRUD Notes ------------------

  Future<int> insertNote(Note note) async {
    final db = await database;
    return await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<int> updateNote(Note note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
