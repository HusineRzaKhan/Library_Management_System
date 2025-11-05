import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WriteReviewScreen extends StatelessWidget {
  final TextEditingController bookTitleController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  WriteReviewScreen({super.key});

  Future<void> submitReview() async {
    try {
      final bookTitle = bookTitleController.text.trim();
      final review = reviewController.text.trim();

      if (bookTitle.isEmpty || review.isEmpty) {
        print('All fields are required.');
        return;
      }

      final bookQuery = await FirebaseFirestore.instance
          .collection('books')
          .where('title', isEqualTo: bookTitle)
          .get();

      if (bookQuery.docs.isEmpty) {
        print('Book not found.');
        return;
      }

      final bookId = bookQuery.docs.first.id;

      await FirebaseFirestore.instance
          .collection('books')
          .doc(bookId)
          .collection('reviews')
          .add({
        'review': review,
        'student_id': 'student_123', // Replace with logged-in student's ID
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('Review submitted successfully!');
    } catch (e) {
      print('Error submitting review: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: bookTitleController,
              decoration: InputDecoration(labelText: 'Book Title'),
            ),
            TextField(
              controller: reviewController,
              decoration: InputDecoration(labelText: 'Your Review'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitReview,
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
