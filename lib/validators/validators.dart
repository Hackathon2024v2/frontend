String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

String? passwordConfirmationValidator(String? value, String originalPassword) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }
  if (value != originalPassword) {
    return 'Passwords do not match';
  }
  return null;
}

String? inputValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter your name';
  }

  return null; // Valid name
}

String? validateWeight(String? value) {
  if (value == null || value.isEmpty) {
    return 'Weight is required.';
  }
  final weight = double.tryParse(value);
  if (weight == null || weight <= 0) {
    return 'Enter a valid weight greater than 0.';
  }
  return null;
}

String? validateHeight(String? value) {
  if (value == null || value.isEmpty) {
    return 'Height is required.';
  }
  final height = double.tryParse(value);
  if (height == null || height <= 0) {
    return 'Enter a valid height greater than 0.';
  }
  return null;
}
