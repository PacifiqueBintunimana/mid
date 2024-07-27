import 'dart:io';

import 'package:flutter/material.dart';
import '../models/book.dart';
import '../screens/book_detail_screen.dart';

class BookListItem extends StatelessWidget {
  final Book book;

  BookListItem({required this.book});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: book.imagePath != null
          ? Image.file(File(book.imagePath!),
              width: 50, height: 50, fit: BoxFit.cover)
          : null,
      title: Text(book.title),
      subtitle: Text(book.author),
      trailing: Icon(book.isRead ? Icons.book : Icons.book_outlined),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailScreen(book: book),
          ),
        );
      },
    );
  }
}
