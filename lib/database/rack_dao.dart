import 'package:appstock/database/db_helper.dart';
import 'package:appstock/models/rack.dart';
import 'package:sqflite/sqflite.dart';

class RackDAO {
  final String tableName = 'Racks';

  Future<int> insertRack(Rack rack) async {
    Database db = await DatabaseHelper().database;
    return await db.insert(tableName, rack.toMap());
  }

  Future<List<Rack>> getAllRacks() async {
    Database db = await DatabaseHelper().database;
    List<Map<String, dynamic>> result = await db.query(tableName);
    return result.map((map) => Rack.fromMap(map)).toList();
  }

  Future<int> updateRack(Rack rack) async {
    Database db = await DatabaseHelper().database;
    return await db.update(
      tableName,
      rack.toMap(),
      where: 'rack_id = ?',
      whereArgs: [rack.rackId],
    );
  }

  Future<int> deleteRack(int rackId) async {
    Database db = await DatabaseHelper().database;
    return await db.delete(
      tableName,
      where: 'rack_id = ?',
      whereArgs: [rackId],
    );
  }
}

  // Add other CRUD methods