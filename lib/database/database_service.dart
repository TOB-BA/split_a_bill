import 'package:first_flutter_project/models/admin.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@injectable
class DatabaseService {
  late final Future<Database> database;

  Future<void> insertAdmin(Admin admin) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'split_bill_database.db'),
    );

    final Database db = await database;
    await db.insert(
      'admin',
      admin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Admin>> getAdmin() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'split_bill_database.db'),
    );
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('admin');

    return List.generate(maps.length, (i) {
      return Admin(
        id: maps[i]['id'] as int,
        firstName: maps[i]['firstName'] as String,
        lastName: maps[i]['lastName'] as String,
        email: maps[i]['email'] as String,
        address: maps[i]['address'] as String,
        creditCardNumber: maps[i]['creditCardNumber'] as int,
      );
    });
  }

  Future<void> updateAdmin(Admin admin) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'split_bill_database.db'),
    );
    final db = await database;

    await db.update(
      'admin',
      admin.toMap(),
      where: 'id = ?',
      whereArgs: [admin.id],
    );
  }
}
