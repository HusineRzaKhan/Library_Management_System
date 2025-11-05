import 'package:flutter/material.dart';
import '../models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookCard({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        contentPadding: EdgeInsets.all(15),
        title: Text(
          book.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          'Author: ${book.author}\nCategory: ${book.category}',
          style: TextStyle(fontSize: 14),
        ),
        trailing: Icon(
          book.isBorrowed ? Icons.remove_circle : Icons.check_circle,
          color: book.isBorrowed ? Colors.red : Colors.green,
        ),
        onTap: onTap,
      ),
    );
  }
}
