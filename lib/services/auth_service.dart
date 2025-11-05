import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user.dart';
import 'firestore_service.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Sign up a new user
  Future<void> signUpUser(String email, String password, User user) async {
    try {
      firebase_auth.UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user!.uid;
      final newUser = user.copyWith(id: uid);
      await _firestoreService.addUser(newUser);
    } catch (e) {
      throw Exception('Error signing up: $e');
    }
  }

  // Login a user
  Future<User?> loginUser(String email, String password) async {
    try {
      firebase_auth.UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user!.uid;
      return _firestoreService.getUser(uid);
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }

  // Logout user
  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Error logging out: $e');
    }
  }

  // Get the currently logged-in user
  firebase_auth.User? get currentUser {
    final user = _auth.currentUser;
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Error sending password reset email: $e');
    }
  }
}
