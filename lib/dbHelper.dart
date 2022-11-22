import 'package:in_class_sqfl/prof.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';

class DBHelper {
  static final _dbName = "prof.db";
  static final dbVersion = 1;
  static final table = "prof_table";
  static final columnId = 'id';
  static final columnName = 'name';
  static final columnDepartment = 'department';

  static Database? _database;
  DBHelper._();

  static final DBHelper db = DBHelper._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $table(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnDepartment TEXT NOT NULL)''');
  }

  Future<int?> insert(Prof p) async {
    Database? d = await db.database;
    // return await d?.insert(table, {'name': p.name, 'department':p.department});
    return await d?.insert(table, p.toJson());
  }

  Future<int?> delete(int val) async {
    Database? d = await db.database;
    return await d?.delete(table, where: '$columnId = ?', whereArgs: [val]);
  }

  Future<int?> deleteInfo(String profName, String deptName) async {
    Database? d = await db.database;
    return await d?.delete(table,
        where: '$columnName = ? and $columnDepartment = ?',
        whereArgs: [profName, deptName]);
  }

  Future<List<Map<String, dynamic>>?> getRows() async {
    Database? d = await db.database;
    return await d?.query(table);
  }
}
