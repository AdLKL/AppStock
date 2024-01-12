import 'package:appstock/database/produit_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  Database? _database;

  // DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'stock.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
  }

  Future<void> create(Database database, int version) async {
    await ProduitDAO().createTable(database);
  }

  // Future<void> _createDatabase(Database db, int version) async {
  //   try {
  //     // Add table creation queries here
  //     await db.execute('''

  //     CREATE TABLE IF NOT EXISTS Categories (
  //       categorie_id INTEGER PRIMARY KEY AUTOINCREMENT,
  //       nom VARCHAR(25)
  //     );

  //     CREATE TABLE IF NOT EXISTS Warehouse (
  //       warehouse_id INTEGER PRIMARY KEY AUTOINCREMENT,
  //       nom VARCHAR(25),
  //       pays VARCHAR(25),
  //       ville VARCHAR(25),
  //       quartier VARCHAR(25),
  //       numero INTEGER,
  //       manager_id INTEGER,
  //       FOREIGN KEY (manager_id) REFERENCES Manager(manager_id) ON DELETE RESTRICT ON UPDATE CASCADE
  //     );

  //     CREATE TABLE IF NOT EXISTS Racks (
  //       rack_id INTEGER PRIMARY KEY AUTOINCREMENT,
  //       width_free INTEGER,
  //       height_free INTEGER,
  //       warehouse_id INTEGER,
  //       FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id) ON DELETE RESTRICT ON UPDATE CASCADE
  //     );

  //     CREATE TABLE IF NOT EXISTS Manager (
  //       manager_id INTEGER PRIMARY KEY AUTOINCREMENT,
  //       nom VARCHAR(25),
  //       prenom VARCHAR(25),
  //       email VARCHAR(25),
  //       num_telephone VARCHAR(25)
  //     );

  //     CREATE TABLE IF NOT EXISTS Fournisseur (
  //       fournisseur_id INTEGER PRIMARY KEY AUTOINCREMENT,
  //       nom VARCHAR(25),
  //       prenom VARCHAR(25),
  //       email VARCHAR(25),
  //       num_telephone VARCHAR(25)
  //     );
  //   ''');
  //     print('Tables created successfully!');
  //   } catch (e) {
  //     print('Error creating tables: $e');
  //   }
  // }
}
