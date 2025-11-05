
// Validator for non-empty fields
String? validateRequired(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}

// Validator for email format
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  String pattern = r'\w+@\w+\.\w+';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

// Validator for phone number format
String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  }
  if (value.length != 12) {
    return 'Phone number must be 12 digits';
  }
  return null;
}

// Validator for password strength
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 6) {
    return 'Password should be at least 6 characters';
  }
  return null;
}

// Validator for age range (must be between 18 and 100)
String? validateAge(int? value) {
  if (value == null || value < 18 || value > 100) {
    return 'Age must be between 18 and 100';
  }
  return null;
}
