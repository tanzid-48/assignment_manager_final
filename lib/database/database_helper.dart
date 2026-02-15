import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/assignment.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('assignments.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE assignments (
  id $idType,
  title $textType,
  subject $textType,
  description TEXT,
  deadline $textType,
  status $textType,
  created_at $textType
)
    ''');

    print('✅ Database table created successfully');
  }

  Future<int> create(Assignment assignment) async {
    final db = await database;
    final id = await db.insert('assignments', assignment.toMap());
    print('✅ Assignment created with ID: $id');
    return id;
  }

  Future<Assignment?> readAssignment(int id) async {
    final db = await database;
    final maps = await db.query(
      'assignments',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Assignment.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Assignment>> readAllAssignments() async {
    final db = await database;
    const orderBy = 'deadline ASC';
    final result = await db.query('assignments', orderBy: orderBy);
    return result.map((json) => Assignment.fromMap(json)).toList();
  }

  Future<List<Assignment>> readAssignmentsByStatus(String status) async {
    final db = await database;
    final result = await db.query(
      'assignments',
      where: 'status = ?',
      whereArgs: [status],
      orderBy: 'deadline ASC',
    );
    return result.map((json) => Assignment.fromMap(json)).toList();
  }

  Future<int> update(Assignment assignment) async {
    final db = await database;
    return db.update(
      'assignments',
      assignment.toMap(),
      where: 'id = ?',
      whereArgs: [assignment.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(
      'assignments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, int>> getStatistics() async {
    final db = await database;
    final total = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM assignments'));
    final pending = Sqflite.firstIntValue(await db
        .rawQuery('SELECT COUNT(*) FROM assignments WHERE status = ?', ['Pending']));
    final inProgress = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM assignments WHERE status = ?', ['In-Progress']));
    final completed = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM assignments WHERE status = ?', ['Completed']));

    return {
      'total': total ?? 0,
      'pending': pending ?? 0,
      'inProgress': inProgress ?? 0,
      'completed': completed ?? 0,
    };
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
