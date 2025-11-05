import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id; // Document ID in Firestore
  final String title;
  final String isbn;
  final String author;
  final int pages;
  final String category;
  final String subCategory; // For literature (e.g., Urdu, English)
  final bool isBorrowed;
  final String? borrowedBy; // Student ID if borrowed
  final DateTime? borrowedDate;
  final DateTime? dueDate;

  Book({
    required this.id,
    required this.title,
    required this.isbn,
    required this.author,
    required this.pages,
    required this.category,
    this.subCategory = '',
    this.isBorrowed = false,
    this.borrowedBy,
    this.borrowedDate,
    this.dueDate,
  });

  // Convert a Firestore document to a Book object
  factory Book.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Book(
      id: doc.id,
      title: data['title'] ?? '',
      isbn: data['isbn'] ?? '',
      author: data['author'] ?? '',
      pages: data['pages'] ?? 0,
      category: data['category'] ?? '',
      subCategory: data['sub_category'] ?? '',
      isBorrowed: data['is_borrowed'] ?? false,
      borrowedBy: data['borrowed_by'],
      borrowedDate: (data['borrowed_date'] as Timestamp?)?.toDate(),
      dueDate: (data['due_date'] as Timestamp?)?.toDate(),
    );
  }

  // Convert a Book object to a Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'isbn': isbn,
      'author': author,
      'pages': pages,
      'category': category,
      'sub_category': subCategory,
      'is_borrowed': isBorrowed,
      'borrowed_by': borrowedBy,
      'borrowed_date':
          borrowedDate != null ? Timestamp.fromDate(borrowedDate!) : null,
      'due_date': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
    };
  }
}
