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

  // Create new item (journal)
  static Future<int> createItem(
      String nombre, String? tipo, String? detalle, String? valor) async {
    final db = await SQLHelper.db();

    final data = {'nombre': nombre, 'detalle': detalle, 'valor': valor};
    final id = await db.insert('boleta', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('boleta', orderBy: "id_boleta");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('boleta',
        where: "id_boleta = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String nombre, String? tipo,
      String? detalle, String? valor) async {
    final db = await SQLHelper.db();

    final data = {
      'nombre': nombre,
      'tipo': tipo,
      'detalle': detalle,
      'valor': valor,
      'createdAt': DateTime.now().toString()
    };

    final result = await db
        .update('boleta', data, where: "id_boleta = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("boleta", where: "id_boleta = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
