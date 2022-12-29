import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE boleta(
        id_boleta INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nombre TEXT,
        tipo TEXT,
        detalle TEXT,
        valor TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute("""CREATE TABLE tratamiento(
        id_tratamiento INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nombre TEXT,
        peso TEXT,
        edad TEXT,
        dni TEXT,
        telefono TEXT,
        detalle TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'clinica.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }
}
