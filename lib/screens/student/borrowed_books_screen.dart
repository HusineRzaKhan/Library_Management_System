import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BorrowedBooksScreen extends StatelessWidget {
  final String studentId = 'student_123';

  const BorrowedBooksScreen({super.key}); // Replace with logged-in student's ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrowed Books'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('books')
            .where('borrowed_by', isEqualTo: studentId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final books = snapshot.data!.docs;

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Card(
                child: ListTile(
                  title: Text(book['title']),
                  subtitle: Text('Due Date: ${book['due_date']}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
