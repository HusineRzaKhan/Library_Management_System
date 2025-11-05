import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:comsats_library/widgets/custom_textfield.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  String? errorMessage;

  // Password validation states
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool isCorrectLength = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  controller: _studentIdController,
                  label: 'Student ID',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Student ID';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$'))
                  ],
                ),
                CustomTextField(
                  controller: _fatherNameController,
                  label: 'Father\'s Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your father\'s name';
                    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return 'Father\'s name can only contain letters';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$'))
                  ],
                ),
                CustomTextField(
                  controller: _addressController,
                  label: 'Address',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _ageController,
                  label: 'Age',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your age';
                    } else if (int.tryParse(value) == null) {
                      return 'Age must be a number';
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                CustomTextField(
                  controller: _semesterController,
                  label: 'Current Semester',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your current semester';
                    } else if (int.tryParse(value) == null) {
                      return 'Semester must be a number';
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  onChanged: (value) {
                    setState(() {
                      hasUppercase = value.contains(RegExp(r'[A-Z]'));
                      hasLowercase = value.contains(RegExp(r'[a-z]'));
                      hasNumber = value.contains(RegExp(r'\d'));
                      hasSpecialChar =
                          value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                      isCorrectLength = value.length >= 8 && value.length <= 16;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (!isCorrectLength ||
                        !hasUppercase ||
                        !hasLowercase ||
                        !hasNumber ||
                        !hasSpecialChar) {
                      return 'Password does not meet the requirements';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPasswordRequirement(
                        'At least one uppercase letter', hasUppercase),
                    _buildPasswordRequirement(
                        'At least one lowercase letter', hasLowercase),
                    _buildPasswordRequirement('At least one number', hasNumber),
                    _buildPasswordRequirement(
                        'At least one special character', hasSpecialChar),
                    _buildPasswordRequirement(
                        '8-16 characters long', isCorrectLength),
                  ],
                ),
                CustomTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (!RegExp(r'^\d{1,12}$').hasMatch(value)) {
                      return 'Phone number must be numeric and up to 12 digits';
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ElevatedButton(
                  onPressed: _signUp,
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(String requirement, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check : Icons.close,
          color: isMet ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(requirement),
      ],
    );
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final studentId = _studentIdController.text.trim();
        final newStudent = {
          'studentid': studentId,
          'name': _nameController.text.trim(),
          'father_name': _fatherNameController.text.trim(),
          'address': _addressController.text.trim(),
          'age': int.parse(_ageController.text.trim()),
          'current_semester': int.parse(_semesterController.text.trim()),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
          'phone': int.parse(_phoneController.text.trim()),
        };

        // Save to Firestore
        await FirebaseFirestore.instance
            .collection('students')
            .doc(studentId)
            .set(newStudent);

        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        setState(() {
          errorMessage = 'Sign up failed. Please try again.';
        });
        Future.delayed(const Duration(seconds: 4), () {
          setState(() {
            errorMessage = null;
          });
        });
      }
    }
  }
}
