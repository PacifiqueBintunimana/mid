/*import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../services/database_service.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  List<Book> get books => _books;

  Future<void> fetchBooks() async {
    _books = await DatabaseService.instance.readAllBooks();
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    final newBook = await DatabaseService.instance.create(book);
    _books.add(newBook);
    notifyListeners();
  }

  Future<void> updateBook(Book book) async {
    await DatabaseService.instance.update(book);
    int index = _books.indexWhere((b) => b.id == book.id);
    if (index != -1) {
      _books[index] = book;
      notifyListeners();
    }
  }

  Future<void> deleteBook(int id) async {
    await DatabaseService.instance.delete(id);
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }

  void sortBooks(String criteria) {
    switch (criteria) {
      case 'title':
        _books.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'author':
        _books.sort((a, b) => a.author.compareTo(b.author));
        break;
      case 'rating':
        _books.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    notifyListeners();
  }

  List<Book> searchBooks(String query) {
    return _books
        .where((book) =>
            book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}*/
import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../services/database_service.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  List<Book> get books => _books;

  Future<void> fetchBooks() async {
    _books = await DatabaseService.instance.readAllBooks();
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    final newBook = await DatabaseService.instance.create(book);
    _books.add(newBook);
    notifyListeners();
  }

  Future<void> updateBook(Book book) async {
    await DatabaseService.instance.update(book);
    int index = _books.indexWhere((b) => b.id == book.id);
    if (index != -1) {
      _books[index] = book;
      notifyListeners();
    }
  }

  Future<void> deleteBook(int id) async {
    await DatabaseService.instance.delete(id);
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }

  void sortBooks(String criteria) {
    switch (criteria) {
      case 'title':
        _books.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'author':
        _books.sort((a, b) => a.author.compareTo(b.author));
        break;
      case 'rating':
        _books.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    notifyListeners();
  }

  List<Book> searchBooks(String query) {
    return _books
        .where((book) =>
            book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
