import 'package:appstock/database/db_helper.dart';
import 'package:appstock/models/produit.dart';
import 'package:sqflite/sqflite.dart';

class ProduitDAO {
  final String tableName = 'Produits';

  Future<void> createTable(Database database) async {
    await database.execute("""
        CREATE TABLE IF NOT EXISTS $tableName (
        "produit_id" INTEGER NOT NULL,
        "nom" VARCHAR(25),
        "prix_unitaire" VARCHAR(25),
        "quantite" INTEGER,
        PRIMARY KEY("produit_id" AUTOINCREMENT)
      );""");
  }

  Future<int> insertProduit(Produit produit) async {
    final database = await DatabaseHelper().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (nom, prix_unitaire, quantite) VALUES (?,?,?)''',
      [produit.nom, produit.prixUnitaire, produit.quantite],
    );
  }

  Future<List<Produit>> fetchAll() async {
    final database = await DatabaseHelper().database;
    final produits = await database.rawQuery(
      '''SELECT * from $tableName''',
    );
    return produits.map((map) => Produit.fromMap(map)).toList();
  }

  Future<Produit> fetchById(int id) async {
    final database = await DatabaseHelper().database;
    final produit = await database
        .rawQuery('''SELECT * from $tableName WHERE id = ?''', [id]);
    return Produit.fromMap(produit.first);
  }

  Future<int> update(Produit produit) async {
    final database = await DatabaseHelper().database;
    return await database.update(
      tableName,
      {
        'nom': produit.nom,
        'prix_unitaire': produit.prixUnitaire,
        'quantite': produit.quantite,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [produit.produitId],
    );
  }

  Future<void> delete(Produit produit) async {
    final database = await DatabaseHelper().database;
    await database.rawDelete(
        '''DELETE FROM $tableName WHERE id = ?''', [produit.produitId]);
  }

  // Future<int> insertProduit(Produit produit) async {
  //   Database db = await DatabaseHelper.instance.database;
  //   return await db.insert(tableName, produit.toMap());
  // }

  // Future<List<Produit>> getAllProduits() async {
  //   Database db = await DatabaseHelper(ConcurrentModificationError).database;
  //   List<Map<String, dynamic>> result = await db.query(tableName);
  //   return result.map((map) => Produit.fromMap(map)).toList();
  // }

  Future<int> updateProduit(Produit product) async {
    Database db = await DatabaseHelper().database;
    return await db.update(
      tableName,
      product.toMap(),
      where: 'produit_id = ?',
      whereArgs: [product.produitId],
    );
  }

  Future<int> deleteProduit(int produitId) async {
    Database db = await DatabaseHelper().database;
    return await db.delete(
      tableName,
      where: 'produit_id = ?',
      whereArgs: [produitId],
    );
  }
  // Add other CRUD methods
}
