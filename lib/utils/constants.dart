import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'BLEND';

  // Colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFFFF6584);
  static const Color accentColor = Color(0xFF43E6D6);
  static const Color backgroundColor = Color(0xFFF8F8FF);
  static const Color cardColor = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF9C88FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient1 = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF9C88FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient2 = LinearGradient(
    colors: [Color(0xFFFF6584), Color(0xFFFF9A9E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient3 = LinearGradient(
    colors: [Color(0xFF43E6D6), Color(0xFF0CB3A7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient4 = LinearGradient(
    colors: [Color(0xFFFFB347), Color(0xFFFF8C00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Onboarding Options
  static const List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];

  static const List<String> lookingForOptions = [
    'Same level',
    'More experienced',
    'Learn together',
  ];

  static const List<String> frequencies = [
    'Daily',
    '3-4 times/week',
    'Weekends',
  ];

  static const List<String> preferredTimes = ['Morning', 'Afternoon', 'Night'];

  static const List<String> workingStyles = [
    'Chill & flexible',
    'Structured & disciplined',
    'Competitive',
  ];

  static const List<String> deadlines = [
    'No deadline',
    '1 month',
    '3 months',
    'Custom',
  ];

  static const List<String> collaborationTypes = [
    'Chat only',
    'Voice/video',
    'Regular check-ins',
  ];
}
