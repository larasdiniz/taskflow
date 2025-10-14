import 'package:flutter/material.dart';

class ThemeModel with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;
  
  ThemeData get currentTheme => _isDarkMode ? _darkTheme : _lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }

  // TEMA CLARO - versão simplificada
  static final ThemeData _lightTheme = ThemeData(
    primaryColor: const Color(0xFFA069FF),
    scaffoldBackgroundColor: const Color(0xFFF6F6F9),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF6F6F9),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFA069FF)),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF130F2B)),
      bodyMedium: TextStyle(color: Color(0xFF130F2B)),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFA069FF),
      secondary: Color(0xFFE0D9F0),
      background: Color(0xFFF6F6F9),
      surface: Colors.white,
    ),
  );

  // TEMA ESCURO - COM A COR 1B1B2C
  static final ThemeData _darkTheme = ThemeData(
    primaryColor: const Color(0xFFA069FF),
    scaffoldBackgroundColor: const Color(0xFF1B1B2C),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1B1B2C), 
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFA069FF)),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFA069FF),
      secondary: Color(0xFF2D2D2D),
      background: Color(0xFF1B1B2C),
      surface: Color(0xFF2D2D3C),
    ),
  );
}