import 'package:intl/intl.dart';

String formatValue(dynamic value) {
  if (value == null || (value is String && value.isEmpty)) {
    return '_';
  }
  return value.toString();
}

List? formatDatesInList(List? data) {
  // Check if the list is null, return an empty list if so
  if (data == null) return [];

  return data.map((map) {
    var updatedMap = Map<String, dynamic>.from(map);

    // Iterate through all the keys and check for date string values
    updatedMap.forEach((key, value) {
      if (value is String) {
        // Try parsing the string to a DateTime object
        try {
          DateTime? date = DateTime.tryParse(value);
          if (date != null) {
            // Format DateTime to day month year
            updatedMap[key] =
                "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
          }
        } catch (e) {
          // If it's not a valid DateTime string, leave it as is
          updatedMap[key] = value;
        }
      }
    });

    return updatedMap;
  }).toList();
}

String formatInteger(dynamic value) {
  if (value == null || (value is String && value.isEmpty)) {
    return '0';
  }
  return value.toString();
}

String formatStringEscapeUnderscore(String input) {
  // Split the string by underscore
  List<String> words = input.split('_');

  // Capitalize first letter of each word and join with space
  return words.map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}

String formatAddress(Map<dynamic, dynamic>? details) {
  if (details == null) return '_\n_';

  String line1 = '', line2 = '';

  // First line
  if (details['address']?.toString().trim().isNotEmpty == true) {
    line1 = details['address'].toString().trim();
    if (details['place']?.toString().trim().isNotEmpty == true) {
      line1 += ', ${details['place'].toString().trim()}';
    }
  } else if (details['place']?.toString().trim().isNotEmpty == true) {
    line1 = details['place'].toString().trim();
  } else {
    line1 = '_';
  }

  // Second line
  if (details['district']?.toString().trim().isNotEmpty == true) {
    line2 = details['district'].toString().trim();
    if (details['state']?.toString().trim().isNotEmpty == true) {
      line2 += ', ${details['state'].toString().trim()}';
    }
    if (details['pincode']?.toString().trim().isNotEmpty == true) {
      line2 += ', ${details['pincode'].toString().trim()}';
    }
  } else if (details['state']?.toString().trim().isNotEmpty == true) {
    line2 = details['state'].toString().trim();
    if (details['pincode']?.toString().trim().isNotEmpty == true) {
      line2 += ', ${details['pincode'].toString().trim()}';
    }
  } else if (details['pincode']?.toString().trim().isNotEmpty == true) {
    line2 = details['pincode'].toString().trim();
  } else {
    line2 = '_';
  }

  return '$line1\n$line2';
}

String formatDate(dynamic date) {
  // Return '_' if the date is null
  if (date == null) {
    return '_';
  }

  DateTime? parsedDate;

  // Try parsing if the date is a String
  if (date is String) {
    try {
      parsedDate = DateTime.parse(date); // Parsing the date from string
    } catch (e) {
      return '_'; // Return '_' if parsing fails
    }
  } else if (date is DateTime) {
    parsedDate = date;
  } else {
    return '_'; // Return '_' if the input type is invalid
  }

  // Format and return the date as dd-MM-yyyy
  return DateFormat('dd-MM-yyyy').format(parsedDate);
}

String formatDateTime(dynamic dateTime) {
  if (dateTime == null) return '_';

  DateTime? parsedDateTime;

  if (dateTime is String) {
    try {
      parsedDateTime = DateTime.parse(dateTime);
    } catch (e) {
      return '_'; // Return '_' if parsing fails
    }
  } else if (dateTime is DateTime) {
    parsedDateTime = dateTime;
  } else {
    return '_'; // Return '_' if input is neither DateTime nor String
  }

  return DateFormat('dd-MM-yyyy / HH:mm').format(parsedDateTime);
}

String checkPrivileges(Map<dynamic, dynamic>? data) {
  if (data == null ||
      !(data['access_employee_attendance'] == true ||
          data['edit_customers'] == true ||
          data['edit_projects'] == true)) {
    return 'No Privileges';
  }

  return '${data['access_employee_attendance'] == true ? 'Employee Attendance\n' : ''}'
          '${data['edit_customers'] == true ? 'Edit Customers\n' : ''}'
          '${data['edit_projects'] == true ? 'Edit Projects\n' : ''}'
      .trim();
}
