import 'package:flutter_a_z/model/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';

import 'dart:async';

class NoteControll{
  
  static final String tableName = "notes";

  static final NoteControll _noteControll = NoteControll._internal();

  Database _db;

  factory NoteControll(){
    return _noteControll;
  }

  // Ensure that only one instance of the class is created
  NoteControll._internal();

  get db async{
    if(_db != null){
      print("get db NULL");
      return _db;
    }
    print("get db NOT NULL");
    _db = await startingDB();
    return _db;

  }

  
  startingDB() async {
    print(">>> startingDB()");    
    final dbPath = await getDatabasesPath();
    print(dbPath);
    
    final dbFullPath = join(dbPath, "bd_keep_notes.bd");
    print("FULL path: $dbFullPath");

    var db = await openDatabase(dbFullPath, version: 1, onCreate: _onCreate);

    return db;
  }

  _onCreate(Database db, int version) async {
    /*
    * Table format
    * id; title; desc; date
    * 01; test ; test; 11/05/2020
    */

    String sql = 
    """
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title VARCHAR,
      desc TEXT,
      date DATETIME
    )
    """;

    await db.execute(sql);
  }

  Future<int> saveNote(Note note) async {
    Database dataBase = await db;
    int result = await dataBase.insert(tableName, note.toMap());

    return result;
  }

  recoveryNotes() async {
    print(">>> recoveryNotes()");
    Database dataBase = await db;
    String sql = 
    """
    SELECT * FROM $tableName
    ORDER BY date DESC 
    """;

    List notes = await dataBase.rawQuery(sql);    
    print(notes);
    return notes;
  }

  Future<int> updateNote(Note note) async {
    Database dataBase = await db;

    return await dataBase.update(
      tableName, 
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id]
    );
  }

  Future<int> removeNote(int id) async {
    Database dataBase = await db;

    return await dataBase.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id]
    );
  }



}