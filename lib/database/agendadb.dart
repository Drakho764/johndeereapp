import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:johndeereapp/models/carrera_model.dart';
import 'package:johndeereapp/models/popular_model.dart';
import 'package:johndeereapp/models/profesor_model.dart';
import 'package:johndeereapp/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class AgendaDB {
  static const nameDB = 'AGENDADB';
  static const versionDB = 1;

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(pathDB, version: versionDB, onCreate: _createTables);
  }

  FutureOr<void> _createTables(Database db, int version) {
    String query = '''CREATE TABLE tblTareas( 
      idTask INTEGER PRIMARY KEY,
      nameTask VARCHAR(50),
      dscTask VARCHAR(50),
      sttTask BYTE,
      fecExpiracion DATETIME,
      fecRecordatorio DATETIME,
      idProfesor INTEGER, FOREIGN KEY (idProfesor) REFERENCES tblProfesor(idProfe));''';

    String query2 = '''CREATE TABLE tblCarrera(
      idCarrera INTEGER PRIMARY KEY,
      nameCarrera VARCHAR(50));''';

    String query3 = '''CREATE TABLE tblProfesor(
      idProfe INTEGER PRIMARY KEY, 
      nameProfe VARCHAR(50), 
      idCarrera INTEGER, 
      email VARCHAR(50), 
      FOREIGN KEY (idCarrera) REFERENCES tblProfesor(idCarrera));''';

    String query4 = '''CREATE TABLE tblPopular(
        backdrop_path TEXT, 
        id INTEGER, 
        original_language TEXT, 
        original_title TEXT, 
        overview TEXT, 
        popularity REAL, 
        poster_path TEXT, 
        release_date TEXT, 
        title TEXT, 
        vote_average REAL, 
        vote_count INTEGER
      );''';

    db.execute(query2);
    db.execute(query3);
    db.execute(query);
    db.execute(query4);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idTask = ?', whereArgs: [data['idTask']]);
  }

  Future<int> DELETE(String tblName, int idTask) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'idTask = ?', whereArgs: [idTask]);
  }
  Future<int> DELETEMOVIE(String tblName, int idM) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'id = ?', whereArgs: [idM]);
  }
  Future<int> DELETEPROF(String tblName, int idprof) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'idProfe = ?', whereArgs: [idprof]);
  }
  Future<List<TaskModel>> GETALLTASK() async {
    var conexion = await database;
    var result = await conexion!.query('tblTareas');
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> getTaskByStatus(String status) async {
    var conexion = await database;
    var result = await conexion!
        .query('tblTareas', where: 'sttTask = ?', whereArgs: [status]);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> getTaskByText(String nameTask) async {
    var conexion = await database;
    var result = await conexion!
        .query('tblTareas', where: "nameTask LIKE ?", whereArgs: [nameTask]);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<Profesor>> GETALLPROFESOR() async {
    var conexion = await database;
    var result = await conexion!.query('tblProfesor');
    return result.map((profesor) => Profesor.fromMap(profesor)).toList();
  }

  Future<List<Map<String, dynamic>>?> PROFESORES() async {
    var conexion = await database;
    return await conexion?.rawQuery('select nameProfe from tblProfesor');
  }
  Future<List<Map<String, dynamic>>?> INDICE( String indice) async {
    var conexion = await database;
    List<Map<String, Object?>>? ind;
    return ind= await conexion?.rawQuery('select idCarrera from tblCarrera where nameCarrera="$indice"');
  }
    Future<List<Map<String, dynamic>>?> CARRERA() async {
    var conexion = await database;
    return await conexion?.rawQuery('select nameCarrera from tblCarrera');
  }

  Future<List<Carrera>> GETALLCARRERA() async {
    var conexion = await database;
    var result = await conexion!.query('tblCarrera');
    return result.map((carrera) => Carrera.fromMap(carrera)).toList();
  }

  Future<List<TaskModel>> ListarTareasPendientes() async {
    var conexion = await database;
    var result = await conexion!
        .query('tblTareas', where: 'sttTask = ?', whereArgs: ['P']);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> ListarTareasRealizadas() async {
    var conexion = await database;
    var result = await conexion!
        .query('tblTareas', where: 'sttTask = ?', whereArgs: ['C']);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> ListarTareasProceso() async {
    var conexion = await database;
    var result = await conexion!
        .query('tblTareas', where: 'sttTask = ?', whereArgs: ['E']);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<PopularModel>> GETALLPOPULAR() async {
    var conexion = await database;
    var result = await conexion!.query('tblPopular');
    return result.map((event) => PopularModel.fromMap(event)).toList();
  }

  Future<List<PopularModel>> GETPOPULAR(int id) async {
    var conexion = await database;
    var result = await conexion!.query('tblPopular', where: 'id=$id');
    return result.map((event) => PopularModel.fromMap(event)).toList();
  }
  /*Future<List<Map<String, dynamic>>?> GETPOPULAR(int id) async {
    var conexion = await database;
    return await conexion?.rawQuery('select id from tblPopular where id=$id');
  }*/
}