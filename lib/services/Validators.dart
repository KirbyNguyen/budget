String validateEmail(String email) {
  // Email expression
  RegExp regex = RegExp(r'\w+@\w+\.\w+');
  if (email.isEmpty)
    return "Please enter a value";
  else if (!regex.hasMatch(email))
    return "Please enter a valid email";
  else
    return null;
}

String validatePassword(String password) {
  // Uppercase expression
  RegExp hasUpper = RegExp(r'[A-Z]');
  // Lowercase expression
  RegExp hasLower = RegExp(r'[a-z]');
  // Digit expression
  RegExp hasDigit = RegExp(r'\d');
  // Punctuation expression
  RegExp hasPunct = RegExp(r'[!@#\$&*~-]');

  String error = "";
  if (password.isEmpty) {
    error = "Please enter a value";
    return error;
  } else if (!RegExp(r'.{8,}').hasMatch(password) ||
      !hasUpper.hasMatch(password) ||
      !hasLower.hasMatch(password) ||
      !hasDigit.hasMatch(password) ||
      !hasPunct.hasMatch(password)) {
    error = "Please satisfy the following conditions:\n";
    if (!RegExp(r'.{8,}').hasMatch(password))
      error += '\tPasswords must have at least 8 characters\n';
    if (!hasUpper.hasMatch(password))
      error += '\tPasswords must have at least one uppercase charactern';
    if (!hasLower.hasMatch(password))
      error += '\tPasswords must have at least one lowercase charactern';
    if (!hasDigit.hasMatch(password))
      error += '\tPasswords must have at least one numbern';
    if (!hasPunct.hasMatch(password))
      error +=
          '\tPasswords need at least one special character like !@#\$&*~-\n';
    return error;
  } else
    return null;
}

String validateConfirmPassword(String confirmPassword, String password) {
  if (confirmPassword.isEmpty)
    return "Please enter a value";
  else if (confirmPassword.compareTo(password) != 0)
    return "The value does not match with password field";
  else
    return null;
}