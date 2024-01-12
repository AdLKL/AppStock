import 'package:appstock/database/db_helper.dart';
import 'package:appstock/models/fournisseur.dart';
import 'package:sqflite/sqflite.dart';

class FournisseurDAO {
  final String tableName = 'Fournisseur';

  Future<int> insertFournisseur(Fournisseur fournisseur) async {
    Database db = await DatabaseHelper().database;
    return await db.insert(tableName, fournisseur.toMap());
  }

  Future<List<Fournisseur>> getAllFournisseurs() async {
    Database db = await DatabaseHelper().database;
    List<Map<String, dynamic>> result = await db.query(tableName);
    return result.map((map) => Fournisseur.fromMap(map)).toList();
  }
}
