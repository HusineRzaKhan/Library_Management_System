class Constants {
  // Define some common strings
  static const String appTitle = 'COMSATS Library App';
  static const String adminRole = 'admin';
  static const String studentRole = 'student';

  // Firebase collection names
  static const String booksCollection = 'books';
  static const String usersCollection = 'users';
  static const String requestsCollection = 'requests';

  // Book categories
  static const List<String> categories = [
    'Physics',
    'Chemistry',
    'Biology',
    'Maths',
    'Computer',
    'Architecture & Design',
    'Literature'
  ];

  // Sub-categories for Literature
  static const List<String> literatureSubCategories = ['Urdu', 'English'];

  // Firebase document field names
  static const String titleField = 'title';
  static const String authorField = 'author';
  static const String isbnField = 'isbn';
  static const String categoryField = 'category';
  static const String subCategoryField = 'sub_category';
  static const String isBorrowedField = 'is_borrowed';
  static const String borrowedByField = 'borrowed_by';
  static const String borrowedDateField = 'borrowed_date';
  static const String dueDateField = 'due_date';

  // Error messages
  static const String emailAlreadyInUse = 'Email already in use';
  static const String weakPassword = 'Password is too weak';
  static const String invalidEmail = 'Invalid email address';
}
