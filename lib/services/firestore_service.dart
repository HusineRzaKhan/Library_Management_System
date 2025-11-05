import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';
import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  CollectionReference get booksCollection => _firestore.collection('books');
  CollectionReference get usersCollection => _firestore.collection('users');
  CollectionReference get requestsCollection =>
      _firestore.collection('requests');

  // Add a new book
  Future<void> addBook(Book book) async {
    try {
      await booksCollection.add(book.toFirestore());
    } catch (e) {
      throw Exception('Error adding book: $e');
    }
  }

  // Get a stream of books
  Stream<List<Book>> getBooks() {
    return booksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();
    });
  }

  // Update book details
  Future<void> updateBook(String bookId, Map<String, dynamic> data) async {
    try {
      await booksCollection.doc(bookId).update(data);
    } catch (e) {
      throw Exception('Error updating book: $e');
    }
  }

  // Delete a book
  Future<void> deleteBook(String bookId) async {
    try {
      await booksCollection.doc(bookId).delete();
    } catch (e) {
      throw Exception('Error deleting book: $e');
    }
  }

  // Add a user
  Future<void> addUser(User user) async {
    try {
      await usersCollection.doc(user.id).set(user.toFirestore());
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }

  // Get a specific user
  Future<User> getUser(String userId) async {
    try {
      final doc = await usersCollection.doc(userId).get();
      if (doc.exists) {
        return User.fromFirestore(doc);
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }

  // Add a new book request
  Future<void> addRequest(Map<String, dynamic> request) async {
    try {
      await requestsCollection.add(request);
    } catch (e) {
      throw Exception('Error adding request: $e');
    }
  }

  // Get a stream of book requests
  Stream<List<Map<String, dynamic>>> getRequests() {
    return requestsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  // Update a request (approve/reject)
  Future<void> updateRequest(
      String requestId, Map<String, dynamic> data) async {
    try {
      await requestsCollection.doc(requestId).update(data);
    } catch (e) {
      throw Exception('Error updating request: $e');
    }
  }
}
