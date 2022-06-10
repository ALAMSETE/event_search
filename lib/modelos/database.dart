// ignore_for_file: unused_import

import 'dart:ffi';

import 'package:event_search/modelos/event.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseDatos{
  static Future<Database> abrirDB() async{

    return openDatabase(join(await getDatabasesPath(), 'eventos.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE CATEGORIAS(nIdentificador TEXT PRIMARY KEY, tipo TEXT);"
          "CREATE TABLE USUARIOS(dni TEXT PRIMARY KEY, nombre TEXT, apellidos TEXT, contrasenia TEXT, telefono TEXT);"
          "CREATE TABLE CALENDARIO(idCalendario TEXT , fecha TEXT, nomLocalidad TEXT);"
          "CREATE TABLE EVENTOS(nIdentificador TEXT, nomEvento TEXT, dniOwner TEXT, idCalendario TEXT);"
        );
      }, version: 1);
  }

  static Future<Future<int>> insertar(Event evento) async{
    Database database = await abrirDB();
   await database.rawInsert("INSERT INTO CALENDARIO (idCalendario, fecha, nomLocalidad) VALUES (${evento.idCalendario}, ${evento.fecha}, 'Granada')");
    return database.insert("CALENDARIO", evento.toMap());
  }

  static Future<Future<int>> delete(Event evento) async{
    Database database = await abrirDB();
    return database.delete("CALENDARIO", where: "idCalendario = ? and fecha = ?", whereArgs: [evento.idCalendario ,evento.fecha]);
  }

  static Future<List<Event>> eventos(Event evento) async{
    Database database = await abrirDB();
    final List<Map<String, dynamic>> eventosMap = await database.query("CALENDARIO");
    return List.generate(eventosMap.length, (i) => Event(
      idCalendario: eventosMap[i]['idCalendario'],
      fecha: eventosMap[i]['fecha'],
      localidad: eventosMap[i]['nomLocalidad'],
      dniRes: eventosMap[i]['dniRes']
    ));
  }
}