import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id; // User ID (Firestore document ID or UID)
  final String name;
  final String fatherName;
  final String address;
  final String phoneNumber;
  final int age;
  final int currentSemester;
  final String email;
  final String role; // 'admin' or 'student'
  final List<String> borrowedBooks; // List of borrowed book IDs
  final int fine; // Total fine amount in rupees

  User({
    required this.id,
    required this.name,
    required this.fatherName,
    required this.address,
    required this.phoneNumber,
    required this.age,
    required this.currentSemester,
    required this.email,
    required this.role,
    this.borrowedBooks = const [],
    this.fine = 0,
  });

  // Convert a Firestore document to a User object
  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      fatherName: data['father_name'] ?? '',
      address: data['address'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      age: data['age'] ?? 0,
      currentSemester: data['current_semester'] ?? 0,
      email: data['email'] ?? '',
      role: data['role'] ?? 'student',
      borrowedBooks: List<String>.from(data['borrowed_books'] ?? []),
      fine: data['fine'] ?? 0,
    );
  }

  // Convert a User object to a Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'father_name': fatherName,
      'address': address,
      'phone_number': phoneNumber,
      'age': age,
      'current_semester': currentSemester,
      'email': email,
      'role': role,
      'borrowed_books': borrowedBooks,
      'fine': fine,
    };
  }

  // Method to copy the user and allow updates
  User copyWith({
    String? id,
    String? name,
    String? fatherName,
    String? address,
    String? phoneNumber,
    int? age,
    int? currentSemester,
    String? email,
    String? role,
    List<String>? borrowedBooks,
    int? fine,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age ?? this.age,
      currentSemester: currentSemester ?? this.currentSemester,
      email: email ?? this.email,
      role: role ?? this.role,
      borrowedBooks: borrowedBooks ?? this.borrowedBooks,
      fine: fine ?? this.fine,
    );
  }
}
