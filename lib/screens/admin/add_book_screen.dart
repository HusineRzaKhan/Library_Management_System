import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBookScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController pagesController = TextEditingController();

  AddBookScreen({super.key});

  Future<void> addBook() async {
    try {
      await FirebaseFirestore.instance.collection('books').add({
        'title': titleController.text,
        'isbn': isbnController.text,
        'author': authorController.text,
        'category': categoryController.text,
        'pages': int.parse(pagesController.text),
        'is_borrowed': false,
        'borrowed_by': null,
        'borrowed_date': null,
        'due_date': null,
      });
      print('Book added successfully!');
    } catch (e) {
      print('Error adding book: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: isbnController,
                decoration: InputDecoration(labelText: 'ISBN'),
              ),
              TextField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: pagesController,
                decoration: InputDecoration(labelText: 'Pages'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: addBook,
                child: Text('Add Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
