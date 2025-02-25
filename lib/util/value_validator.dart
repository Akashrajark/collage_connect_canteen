String? notEmptyValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email address.';
  }
  return null;
}

String? dateValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This date is required.';
  } else if (!RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$')
      .hasMatch(value)) {
    return 'Please select a date';
  }
  return null;
}

String? urlValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^(https?:\/\/)?' // Optional scheme (http or https)
          r'(([a-zA-Z0-9_-]+\.)+[a-zA-Z]{2,})' // Domain name
          r'(:\d+)?' // Optional port
          r'(\/[a-zA-Z0-9#?&%=._-]*)*$' // Optional path and query parameters
          )
      .hasMatch(value)) {
    return 'Please enter a valid URL.';
  }
  return null;
}

String? phoneNumberValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
    return 'Please enter a valid 10 digit phone number.';
  }
  return null;
}

String? alphanumericValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
    return 'Please enter only letters and numbers.';
  }
  return null;
}

String? alphanumericWithSpaceValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
    return 'Please enter only letters, numbers and spaces.';
  }
  return null;
}

String? alphanumericWithSpecialCharsValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[a-zA-Z0-9!@#\$&*~%^()\\/\-+,._\"\[\]{} ]+$')
      .hasMatch(value)) {
    return 'Please enter only letters, numbers, spaces and special characters.';
  }
  return null;
}

String? validateLatitudeLongitude(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else {
    try {
      double.parse(value);
    } catch (e) {
      return 'Please enter a valid latitude and longitude.';
    }
  }
  return null;
}

String? validateFloat(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else {
    try {
      double.parse(value);
    } catch (e) {
      return 'Please enter a valid number';
    }
  }
  return null;
}

String? pincodeValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
    return 'Please enter a valid 6 digit pincode.';
  }
  return null;
}

String? fiveDigitValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^\d{5}$').hasMatch(value)) {
    return 'Please enter a valid 5 digit code.';
  }
  return null;
}

String? numericValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Please enter a valid number.';
  }
  return null;
}

String? percentageValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
    return 'Please enter a valid number.';
  } else {
    // Convert the input to a double to validate the range
    double? percentage = double.tryParse(value);
    if (percentage == null || percentage < 0 || percentage > 100) {
      return 'Please enter a number between 0 and 100.';
    }
  }
  return null;
}

String? bankAccountNumberValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[0-9]{9,18}$').hasMatch(value)) {
    return 'Please enter a valid Indian bank account number.';
  }
  return null;
}

String? ifscCodeValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[A-Z]{4}[0][a-zA-Z0-9]{6}$').hasMatch(value)) {
    return 'Please enter a valid Indian bank IFSC code.';
  }
  return null;
}

String? confirmPasswordValidator(String? value, String? password) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (value != password) {
    return 'Passwords do not match.';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  }

  if (value.length < 8) {
    return 'Password should be at least 8 characters long.';
  }

  if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
    return 'Password should contain at least one lowercase letter.';
  }

  if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
    return 'Password should contain at least one uppercase letter.';
  }

  if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
    return 'Password should contain at least one number.';
  }

  if (!RegExp(r'^(?=.*[@$!%*?&])').hasMatch(value)) {
    return 'Password should contain at least one special character.';
  }

  return null;
}

String? alphabeticWithSpaceValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[a-zA-Z ]*$').hasMatch(value)) {
    return 'Please enter alphabetic characters only.';
  }
  return null;
}

bool isCountryCodeValid(String countryCode) {
  // Regular expression to match valid country codes
  // The country code should start with a plus sign (+), followed by one or more digits.
  RegExp countryCodeRegex = RegExp(r'^\+\d+');

  // Check if the country code matches the regular expression
  return countryCodeRegex.hasMatch(countryCode);
}

String? countryCodeValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!isCountryCodeValid(value)) {
    return 'Invalid country code';
  }
  return null;
}

String? panValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(value)) {
    return 'Please enter a valid PAN number.';
  }
  return null;
}

String? gstValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(
          r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$')
      .hasMatch(value)) {
    return 'Please enter a valid GST number.';
  }
  return null;
}

String? tanValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[A-Z]{4}[0-9]{5}[A-Z]{1}$').hasMatch(value)) {
    return 'Please enter a valid TAN number.';
  }
  return null;
}

String? aadhaarValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field is required.';
  } else if (!RegExp(r'^[2-9]{1}[0-9]{11}$').hasMatch(value)) {
    return 'Please enter a valid Aadhaar number.';
  }
  return null;
}

String? latitudeValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Latitude cannot be empty';
  }

  final double? latitude = double.tryParse(value);

  if (latitude == null) {
    return 'Enter a valid number';
  }

  if (latitude < -90 || latitude > 90) {
    return 'Latitude must be between -90 and 90';
  }

  return null; // No error
}

String? longitudeValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Longitude cannot be empty';
  }

  final double? longitude = double.tryParse(value);

  if (longitude == null) {
    return 'Enter a valid number';
  }

  if (longitude < -180 || longitude > 180) {
    return 'Longitude must be between -180 and 180';
  }

  return null; // No error
}

String? validateAddress(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Address cannot be empty";
  }
  if (value.length < 5) {
    return "Address is too short";
  }
  if (!RegExp(r'^[a-zA-Z0-9\s,.-]+$').hasMatch(value)) {
    return "Invalid characters in address";
  }
  return null; // Valid address
}
