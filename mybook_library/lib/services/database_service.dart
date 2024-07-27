import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/book.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('books.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    try {
      await db.execute('''
    CREATE TABLE books(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      author TEXT NOT NULL,
      rating REAL NOT NULL,
      isRead INTEGER NOT NULL,
      content TEXT NOT NULL,
      imagePath TEXT, 
      bookPath TEXT 
    )
    ''');
    } catch (e) {
      print('Error creating database: $e');
      // You might want to rethrow the error or handle it in some way
      rethrow;
    }
  }

  Future<Book> create(Book book) async {
    /*  final db = await instance.database;
    final id = await db.insert('books', book.toMap());
    print('Read all books: $result');
    //return result.map((json) => Book.fromMap(json)).toList();
    return book.copyWith(id: id);
  */
    try {
      final db = await instance.database;
      print('Creating book: ${book.toMap()}');
      final id = await db.insert('books', book.toMap());
      return book.copyWith(id: id);
    } catch (e) {
      print('Error creating book: $e');
      rethrow;
    }
  }

  Future<Book> readBook(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'books',
      columns: [
        'id',
        'title',
        'author',
        'rating',
        'isRead',
        'content',
        'imagePath',
        'bookPath'
      ],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Book.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Book>> readAllBooks() async {
    final db = await instance.database;
    final result = await db.query('books');
    return result.map((json) => Book.fromMap(json)).toList();
  }

  Future<int> update(Book book) async {
    final db = await instance.database;
    return db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> checkTableStructure() async {
    try {
      final db = await instance.database;
      var tableInfo = await db.rawQuery("PRAGMA table_info('books')");
      print('Table structure: $tableInfo');
    } catch (e) {
      print('Error checking table structure: $e');
      rethrow;
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
