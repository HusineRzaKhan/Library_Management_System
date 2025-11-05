import 'package:comsats_library/screens/student/student_dashboard.dart';
import 'package:comsats_library/screens/admin/admin_dashboard.dart';
import 'package:comsats_library/screens/login_screen.dart';
import 'package:comsats_library/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:comsats_library/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDzOlwBRkz5e_fB5i3YFA0iUuKb1nqlRr4",
        authDomain: "comsats-library-3090c.firebaseapp.com",
        projectId: "comsats-library-3090c",
        storageBucket: "comsats-library-3090c.firebasestorage.app",
        messagingSenderId: "237715661231",
        appId: "1:237715661231:web:9dd52e63c449de22db0f5a"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: AuthWrapper(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/admin_dashboard': (context) => AdminDashboard(),
        '/student_dashboard': (context) => StudentDashboard(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<firebase_auth.User?>(
      stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null) {
          return LoginScreen();
        } else {
          final user = snapshot.data!;
          if (user.email!.toLowerCase() == 'hussainrazakhanbaloch@gmail.com') {
            // Admin Dashboard
            return AdminDashboard();
          } else {
            // Student Dashboard
            return StudentDashboard();
          }
        }
      },
    );
  }
}
