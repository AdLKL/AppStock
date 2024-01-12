import 'package:appstock/database/db_helper.dart';
import 'package:appstock/models/manager.dart';
import 'package:sqflite/sqflite.dart';

class ManagerDAO {
  final String tableName = 'Manager';

  Future<int> insertManager(Manager manager) async {
    Database db = await DatabaseHelper().database;
    return await db.insert(tableName, manager.toMap());
  }

  Future<List<Manager>> getAllManagers() async {
    Database db = await DatabaseHelper().database;
    List<Map<String, dynamic>> result = await db.query(tableName);
    return result.map((map) => Manager.fromMap(map)).toList();
  }
}
