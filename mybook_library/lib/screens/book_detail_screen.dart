import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import '../widgets/rating_widget.dart';
import 'add_edit_book_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          book.title,
          style: GoogleFonts.openSans(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditBookScreen(book: book),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteBook(context, book),
          ),
        ],
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          final updatedBook = bookProvider.books
              .firstWhere((b) => b.id == book.id, orElse: () => book);

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Book Image
                  if (book.imagePath != null)
                    Image.file(
                      File(book.imagePath!),
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 16),

                  // Book Title
                  Text(
                    book.title,
                    style: GoogleFonts.openSans(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  // Author
                  Text(
                    'Author: ${updatedBook.author}',
                    style: GoogleFonts.openSans(fontSize: 18),
                  ),
                  SizedBox(height: 16),

                  // Rating
                  RatingWidget(
                    rating: updatedBook.rating,
                    onRatingChanged: (newRating) {
                      bookProvider
                          .updateBook(updatedBook.copyWith(rating: newRating));
                    },
                  ),
                  SizedBox(height: 16),

                  // Read Switch
                  Row(
                    children: [
                      Text('Read: ', style: GoogleFonts.openSans(fontSize: 18)),
                      Switch(
                        value: updatedBook.isRead,
                        onChanged: (newValue) {
                          bookProvider.updateBook(
                              updatedBook.copyWith(isRead: newValue));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Description
                  Text(
                    'Description:',
                    style: GoogleFonts.openSans(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    book.content,
                    style: GoogleFonts.openSans(fontSize: 16),
                  ),
                  SizedBox(height: 16),

                  // Book File
                  if (book.bookPath != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Book File:',
                          style: GoogleFonts.openSans(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'File: ${book.bookPath!.split('/').last}',
                          style: GoogleFonts.openSans(
                              fontSize: 16, color: Colors.blue),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            _openBookFile(book.bookPath!);
                          },
                          child: Text('Open Book File'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _deleteBook(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Book'),
          content: Text('Are you sure you want to delete ${book.title}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Provider.of<BookProvider>(context, listen: false)
                    .deleteBook(book.id!);
                //Navigator.of(context).pop();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  void _openBookFile(String path) async {
    final result = await OpenFile.open(path);
    if (result.type != ResultType.done) {
      print('Error opening file: ${result.message}');
    }
  }
}
/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import '../widgets/rating_widget.dart';
import 'add_edit_book_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.brown,
              expandedHeight: MediaQuery
                  .of(context)
                  .size
                  .height * 0.4,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  book.title,
                  style: GoogleFonts.openSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                background: book.imagePath != null
                    ? Image.file(
                  File(book.imagePath!),
                  fit: BoxFit.cover,
                )
                    : Container(
                  color: Colors.grey,
                  child: Center(
                    child:
                    Icon(Icons.book, size: 100, color: Colors.white),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        book.title,
                        style: GoogleFonts.openSans(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Author: ${book.author}',
                          style: GoogleFonts.openSans(fontSize: 18)),
                      SizedBox(height: 16),
                      RatingWidget(
                        rating: book.rating,
                        onRatingChanged: (newRating) {
                          // Handle rating change if needed
                        },
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text('Read: ',
                              style: GoogleFonts.openSans(fontSize: 18)),
                          Switch(
                            value: book.isRead,
                            onChanged: (newValue) {
                              // Handle switch change if needed
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Description:',
                        style: GoogleFonts.openSans(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        book.content,
                        style: GoogleFonts.openSans(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      if (book.bookPath != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Book File:',
                              style: GoogleFonts.openSans(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'File: ${book.bookPath!.split('/').last}',
                              style: GoogleFonts.openSans(
                                  fontSize: 16, color: Colors.blue),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                _openBookFile(book.bookPath!);
                              },
                              child: Text('Open Book File'),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            //primary: Colors.brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // Handle button press if needed
          },
          child: Text(
            'Add to Library',
            style: GoogleFonts.openSans(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _openBookFile(String path) async {
    final result = await OpenFile.open(path);
    if (result.type != ResultType.done) {
      // Handle error here, such as showing an alert dialog
      print('Error opening file: ${result.message}');
    }
  }
}//gooodddd!!!!!!!!!
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import '../widgets/rating_widget.dart';
import 'add_edit_book_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          book.title,
          style: GoogleFonts.openSans(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditBookScreen(book: book),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          final updatedBook = bookProvider.books
              .firstWhere((b) => b.id == book.id, orElse: () => book);

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (book.imagePath != null)
                    Image.file(
                      File(book.imagePath!),
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 16),
                  Text(
                    book.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Author: ${updatedBook.author}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 16),
                  RatingWidget(
                    rating: updatedBook.rating,
                    onRatingChanged: (newRating) {
                      bookProvider
                          .updateBook(updatedBook.copyWith(rating: newRating));
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Read: ', style: TextStyle(fontSize: 18)),
                      Switch(
                        value: updatedBook.isRead,
                        onChanged: (newValue) {
                          bookProvider.updateBook(
                              updatedBook.copyWith(isRead: newValue));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'description:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    book.content,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  if (book.bookPath != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Book File:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'File: ${book.bookPath!.split('/').last}',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            _openBookFile(book.bookPath!);
                          },
                          child: Text('Open Book File'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _openBookFile(String path) async {
    final result = await OpenFile.open(path);
    if (result.type != ResultType.done) {
      // Handle error here, such as showing an alert dialog
      print('Error opening file: ${result.message}');
    }
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import '../widgets/rating_widget.dart';
import 'add_edit_book_screen.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditBookScreen(book: book),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Author: ${book.author}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            RatingWidget(
              rating: book.rating,
              onRatingChanged: (newRating) {
                Provider.of<BookProvider>(context, listen: false)
                    .updateBook(book.copyWith(rating: newRating));
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Read: ', style: TextStyle(fontSize: 18)),
                Switch(
                  value: book.isRead,
                  onChanged: (newValue) {
                    Provider.of<BookProvider>(context, listen: false)
                        .updateBook(book.copyWith(isRead: newValue));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/
