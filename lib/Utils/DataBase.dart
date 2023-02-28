import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHandler {
  static DbHandler dbHandler = DbHandler();
  Database? database;

  Future<Database?> checkDb() async {
    if (database != null) {
      return database;
    } else {
      return await createDb();
    }
  }

  Future<Database> createDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'parth.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE std (id INTEGER PRIMARY KEY AUTOINCREMENT,task TEXT,category TEXT)";
        db.execute(query);
      },
    );
  }



  Future<void> insertData(
      {required String task, required String category}) async {
    database = await checkDb();
    database!.insert(
      "std",
      {
        "task": task,
        "category": category,
      },
    );
  }

  Future<List<Map>> readData() async {
    database = await checkDb();
    String query = "SELECT * FROM std";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  Future<void> deleteData({required int id}) async {
    database = await checkDb();
    database!.delete(
      "std",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateData(
      {required int id, required String name, required String number}) async {
    database = await checkDb();
    database!.update(
      "std",
      {"task": name, "category": number},
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
