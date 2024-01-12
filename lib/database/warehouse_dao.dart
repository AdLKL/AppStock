import 'package:appstock/database/db_helper.dart';
import 'package:appstock/models/warehouse.dart';
import 'package:sqflite/sqflite.dart';

class WarehouseDAO {
  final String tableName = 'Warehouse';

  Future<int> insertWarehouse(Warehouse warehouse) async {
    Database db = await DatabaseHelper().database;
    return await db.insert(tableName, warehouse.toMap());
  }

  Future<List<Warehouse>> getAllWarehouses() async {
    Database db = await DatabaseHelper().database;
    List<Map<String, dynamic>> result = await db.query(tableName);
    return result.map((map) => Warehouse.fromMap(map)).toList();
  }
}

  // Add other CRUD methods