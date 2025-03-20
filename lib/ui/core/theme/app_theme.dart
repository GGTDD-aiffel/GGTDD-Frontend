import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.lightPrimary,
        onPrimary: AppColors.lightPrimaryText,
        secondary: AppColors.lightTextEmphasis,
        background: AppColors.lightBackground,
        surface: AppColors.lightBackground,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
      ),
      // 텍스트 스타일 정의
      textTheme: TextTheme(
        displayLarge:
            TextStyle(fontSize: 34, color: AppColors.lightTextPrimary),
        headlineLarge:
            TextStyle(fontSize: 25, color: AppColors.lightTextPrimary),
        headlineMedium:
            TextStyle(fontSize: 20, color: AppColors.lightTextPrimary),
        headlineSmall:
            TextStyle(fontSize: 16, color: AppColors.lightTextPrimary),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.lightTextPrimary),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.lightTextPrimary),
        bodySmall: TextStyle(fontSize: 12, color: AppColors.lightTextPrimary),
        labelLarge: TextStyle(fontSize: 14, color: AppColors.lightTextPrimary),
        labelMedium: TextStyle(fontSize: 12, color: AppColors.lightTextPrimary),
        labelSmall: TextStyle(fontSize: 10, color: AppColors.lightTextPrimary),
      ),
      // 아이콘 테마
      iconTheme: IconThemeData(
        color: AppColors.lightIcon,
      ),
      // Divider 테마
      dividerTheme: DividerThemeData(
        color: AppColors.lightDivider,
        thickness: 1,
      ),
      // 카드 테마 (BorderRadius 10, 은은한 그림자)
      cardTheme: CardTheme(
        color: AppColors.lightBackground,
        elevation: 2,
        shadowColor: AppColors.lightShadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      // Input 스타일
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightInputBackground,
        contentPadding: EdgeInsets.all(4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.lightInputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.lightInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.lightInputFocused, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.lightInputError, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.lightInputError, width: 2),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.darkPrimary,
        onPrimary: AppColors.darkPrimaryText,
        secondary: AppColors.darkTextEmphasis,
        background: AppColors.darkBackground,
        surface: AppColors.darkBackground,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
      ),
      // 텍스트 스타일 정의
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 34, color: AppColors.darkTextPrimary),
        headlineLarge:
            TextStyle(fontSize: 25, color: AppColors.darkTextPrimary),
        headlineMedium:
            TextStyle(fontSize: 20, color: AppColors.darkTextPrimary),
        headlineSmall:
            TextStyle(fontSize: 16, color: AppColors.darkTextPrimary),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.darkTextPrimary),
        bodySmall: TextStyle(fontSize: 12, color: AppColors.darkTextPrimary),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkTextPrimary),
        labelLarge: TextStyle(fontSize: 14, color: AppColors.darkTextPrimary),
        labelMedium: TextStyle(fontSize: 12, color: AppColors.darkTextPrimary),
        labelSmall: TextStyle(fontSize: 10, color: AppColors.darkTextPrimary),
      ),
      // 아이콘 테마
      iconTheme: IconThemeData(
        color: AppColors.darkIcon,
      ),
      // Divider 테마
      dividerTheme: DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 1,
      ),
      // 카드 테마 (BorderRadius 10, 은은한 그림자)
      cardTheme: CardTheme(
        color: AppColors.darkBackground,
        elevation: 2,
        shadowColor: AppColors.darkShadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      // Input 스타일
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkInputBackground,
        contentPadding: EdgeInsets.all(4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.darkInputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.darkInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.darkInputFocused, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.darkInputError, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.darkInputError, width: 2),
        ),
      ),
    );
  }
}
