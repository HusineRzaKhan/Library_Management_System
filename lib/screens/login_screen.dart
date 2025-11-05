import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:comsats_library/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailOrIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;
  String selectedRole = 'Admin'; // Default role
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButton<String>(
                value: selectedRole,
                items: ['Admin', 'Student'].map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),
              TextFormField(
                controller: _emailOrIdController,
                decoration: InputDecoration(
                  labelText: selectedRole == 'Admin' ? 'Email' : 'Student ID',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return selectedRole == 'Admin'
                        ? 'Please enter your email'
                        : 'Please enter your student ID';
                  }
                  if (selectedRole == 'Admin' &&
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              if (selectedRole == 'Student') // Show Sign Up only for Students
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text('Don\'t have an account? Sign Up'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (selectedRole == 'Admin') {
          // Admin login
          if (_emailOrIdController.text == 'hussainrazakhanbaloch@gmail.com' &&
              _passwordController.text == 'Library/1234') {
            Navigator.pushReplacementNamed(context, '/admin_dashboard');
          } else {
            _showErrorMessage('Invalid email or password for Admin.');
          }
        } else {
          // Student login
          String studentId = _emailOrIdController.text;
          String password = _passwordController.text;

          // Fetch the student document using the studentId as the document ID
          DocumentSnapshot<Map<String, dynamic>> studentDoc =
              await FirebaseFirestore.instance
                  .collection('students')
                  .doc(studentId) // Using studentId as the document ID
                  .get();

          // Check if the student document exists and validate the password
          if (studentDoc.exists && studentDoc.data()?['password'] == password) {
            Navigator.pushReplacementNamed(context, '/student_dashboard');
          } else {
            _showErrorMessage('Invalid Student ID or password.');
          }
        }
      } catch (e) {
        print('Error: $e'); // Log the error for debugging purposes
        _showErrorMessage('An error occurred. Please try again.');
      }
    }
  }

  void _showErrorMessage(String message) {
    setState(() {
      errorMessage = message;
    });
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        errorMessage = null;
      });
    });
  }
}
