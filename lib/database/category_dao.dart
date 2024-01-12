import 'package:appstock/database/db_helper.dart';
import 'package:appstock/models/category.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDAO {
  final String tableName = 'Categories';

  // Future<int> insertCategory(Category category) async {
  //   Database db = await DatabaseHelper(Category).database;
  //   return await db.insert(tableName, category.toMap());
  // }

  Future<List<Category>> getAllCategories() async {
    Database db = await DatabaseHelper().database;
    List<Map<String, dynamic>> result = await db.query(tableName);
    return result.map((map) => Category.fromMap(map)).toList();
  }
}
