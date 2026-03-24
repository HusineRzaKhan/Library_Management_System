# Short Description
A Flutter-based Library Management System developed for University, enabling students and administrators to manage books, borrowing, and requests efficiently. It features secure authentication, real-time Firebase integration, and an intuitive interface for both mobile and desktop platforms.

## 💖 Support my Open-Source Journey

I am a software engineer and student dedicated to building tools that give users back their digital agency. If my work has saved you time, solved a technical headache, or improved your workflow, consider supporting my independent development!

☕ **[Support my work on Patreon (Buy Me a Coffee)](https://patreon.com/HussainRazaKhan)**
    **NayaPay ID:** `HusineRzaKhan@nayapay`

# Detail of the Project
---------------------------

# Library Management System

A comprehensive Flutter-based library management application designed for University, enabling efficient book management, borrowing, and administrative operations.

## 📱 Overview

Library is a full-featured mobile application built with Flutter that streamlines library operations for both students and administrators. The app provides a seamless experience for book searching, borrowing, request management, and administrative tasks.

## ✨ Features

### 👨‍🎓 Student Features
- **User Authentication**: Secure login and registration system
- **Book Search**: Search and browse books by category, author, or title
- **Book Borrowing**: Request books and view borrowing history
- **Borrowed Books Management**: View currently borrowed books with due dates
- **Book Reviews**: Write and submit book reviews
- **Real-time Updates**: Live updates on book availability and status

### 👨‍💼 Admin Features
- **Book Management**: Add, edit, and delete books from the library catalog
- **Request Management**: View, approve, or reject book borrowing requests
- **Library Catalog**: Complete list and management of all books
- **User Management**: Oversee student accounts and borrowing activities
- **Dashboard**: Centralized control panel for all administrative functions

## 🛠️ Technology Stack

- **Framework**: Flutter 3.6.0+
- **Backend**: Firebase
  - Firebase Authentication (Email/Password)
  - Cloud Firestore (Database)
  - Firebase Core
- **Additional Packages**:
  - `flutter_email_sender`: For email notifications
  - `cupertino_icons`: iOS-style icons

## 📋 Prerequisites

Before you begin, ensure you have met the following requirements:

- Flutter SDK (3.6.0 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Firebase account and project setup
- Google Services configuration files

## 🚀 Getting Started

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/HusineRzaKhan/Library_Management_System.git
   cd Library_Management_System
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add your Android/iOS app to the Firebase project
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place `google-services.json` in `android/app/`
   - Place `GoogleService-Info.plist` in `ios/Runner/`
   - Update Firebase configuration in `lib/main.dart` with your Firebase project credentials

4. **Run the application**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── main.dart                 # Application entry point
├── models/                   # Data models
│   ├── book.dart            # Book model
│   └── user.dart            # User model
├── screens/                  # UI screens
│   ├── admin/               # Admin-specific screens
│   │   ├── admin_dashboard.dart
│   │   ├── add_book_screen.dart
│   │   ├── list_books_screen.dart
│   │   └── view_requests_screen.dart
│   ├── student/             # Student-specific screens
│   │   ├── student_dashboard.dart
│   │   ├── search_books_screen.dart
│   │   ├── borrowed_books_screen.dart
│   │   └── write_review_screen.dart
│   ├── login_screen.dart
│   └── signup_screen.dart
├── services/                 # Business logic services
│   ├── auth_service.dart    # Authentication service
│   └── firestore_service.dart # Firestore database service
├── widgets/                  # Reusable widgets
│   ├── book_card.dart
│   ├── custom_textfield.dart
│   └── request_card.dart
└── utils/                    # Utility files
    ├── constants.dart       # App constants
    └── validators.dart      # Input validators
```

## 📚 Book Categories

The application supports the following book categories:

- Physics
- Chemistry
- Biology
- Maths
- Computer
- Architecture & Design
- Literature (with sub-categories: Urdu, English)

## 🔐 Authentication

### Admin Login
- Email: Admin email configured in Firebase
- Password: Admin password
- Access: Full administrative privileges

### Student Login
- Student ID: Unique student identifier
- Password: Student password
- Access: Student features and book borrowing

## 📊 Database Schema

### Books Collection
- `id`: Document ID
- `title`: Book title
- `isbn`: International Standard Book Number
- `author`: Author name
- `pages`: Number of pages
- `category`: Book category
- `sub_category`: Sub-category (for Literature)
- `is_borrowed`: Boolean availability status
- `borrowed_by`: Student ID if borrowed
- `borrowed_date`: Date when book was borrowed
- `due_date`: Book return due date

### Users Collection
- `id`: User ID (Firebase UID)
- `name`: Full name
- `father_name`: Father's name
- `address`: Address
- `phone_number`: Contact number
- `age`: Age
- `current_semester`: Current semester
- `email`: Email address
- `role`: User role (admin/student)
- `borrowed_books`: List of borrowed book IDs
- `fine`: Total fine amount (in rupees)

### Requests Collection
- `id`: Request document ID
- `student_id`: Student who made the request
- `title`: Book title requested
- `book_details`: Book information
- `status`: Request status (pending/approved/rejected)
- `reason`: Rejection reason (if applicable)

## 🎨 UI/UX Features

- Material Design components
- Responsive layout
- Real-time data synchronization
- Intuitive navigation
- Error handling and user feedback
- Loading indicators for async operations

## 🔧 Configuration

### Firebase Configuration

Update the Firebase configuration in `lib/main.dart`:

```dart
FirebaseOptions(
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_AUTH_DOMAIN",
  projectId: "YOUR_PROJECT_ID",
  storageBucket: "YOUR_STORAGE_BUCKET",
  messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
  appId: "YOUR_APP_ID"
)
```

## 🧪 Testing

Run tests using:

```bash
flutter test
```

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Linux
- ✅ macOS
- ✅ Windows

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👤 Author

**Hussain Raza Khan**
- GitHub: [@HusineRzaKhan](https://github.com/HusineRzaKhan)

## 📞 Support

For support, email HussainRazaKhanBaloch@gmail.com or open an issue in the repository.

---

**Note**: Make sure to configure your Firebase project properly and update all credentials before running the application.
