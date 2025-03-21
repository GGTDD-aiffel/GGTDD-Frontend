import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const lightPrimary = Color(0xFF87CEFA);
  static const lightPrimaryText = Color(0xFFFFFFFF);
  static const lightGrayButton = Color(0xFFD9D9D9);
  static const lightGrayButtonText = Color(0xFF000000);
  static const lightBackground = Color(0xFFF5F8FF);
  static const lightTextPrimary = Color(0xFF000000);
  static const lightTextEmphasis = Color(0xFF1E90FF);
  static const lightIcon = Color(0xFF4682B4);
  static const lightDivider = Color(0x4D999999);
  static const lightInputBorder = Color(0xFFD5D8DE);
  static const lightInputBackground = Color(0xFFFFFFFF);
  static const lightInputFocused = Color(0xFF6495ED);
  static const lightInputError = Color(0xFFFFFF00);
  static const lightBackdrop = Color(0xFFBDBFC5);
  static const lightShadow = Color(0x33000000);

  // Dark Theme Colors
  static const darkPrimary = Color(0xFF4682B4);
  static const darkPrimaryText = Color(0xFFFFFFFF);
  static const darkGrayButton = Color(0xFF2A2A2A);
  static const darkGrayButtonText = Color(0xFFFFFFFF);
  static const darkBackground = Color(0xFF121212);
  static const darkTextPrimary = Color(0xFFE0E0E0);
  static const darkTextEmphasis = Color(0xFF87CEFA);
  static const darkIcon = Color(0xFFB0C4DE);
  static const darkDivider = Color(0x4DCCCCCC);
  static const darkInputBorder = Color(0xFF4A4A4A);
  static const darkInputBackground = Color(0xFF1E1E1E);
  static const darkInputFocused = Color(0xFF87CEFA);
  static const darkInputError = Color(0xFFFF4444);
  static const darkBackdrop = Color(0xFF2A2A2A);
  static const darkShadow = Color(0x4D000000);

  // 태그 배경 색상 (라이트)
  static const tagBackgroundColorsLight = [
    Color(0xFFF2E2FC), // week_unit
    Color(0xFFFFF394), // meal_unit
    Color(0xFFD5EFFF), // commute_unit
    Color(0xFFCBFFB5), // day_night_unit
    Color(0xFFFFDFB5), // place
    Color(0xFFE9E8E6), // vehicle
    Color(0xFFFBDCEF), // basic
    Color(0xFFC4E8D1), // time_unit
  ];

  // 태그 텍스트 색상 (라이트)
  static const tagTextColorsLight = [
    Color(0xFF6550B9), // week_unit
    Color(0xFF9E6C00), // meal_unit
    Color(0xFF0D74CE), // commute_unit
    Color(0xFF21B177), // day_night_unit
    Color(0xFFCC4E00), // place
    Color(0xFF63635E), // vehicle
    Color(0xFFC2298A), // basic
    Color(0xFF218358), // time_unit
  ];

  // 태그 아이콘 색상 (라이트)
  static const tagIconColorsLight = [
    Color(0xFF6550B9), // week_unit
    Color(0xFF9E6C00), // meal_unit
    Color(0xFF0D74CE), // commute_unit
    Color(0xFF21B177), // day_night_unit
    Color(0xFFCC4E00), // place
    Color(0xFF63635E), // vehicle
    Color(0xFFC2298A), // basic
    Color(0xFF218358), // time_unit
  ];

  // 태그 배경 색상 (다크) - 다크 배경(0xFF121212)에 어울리도록 조정
  static const tagBackgroundColorsDark = [
    Color(0xFF2A1A3A), // week_unit (어두운 보라 계열)
    Color(0xFF3A2A00), // meal_unit (어두운 노랑 계열)
    Color(0xFF1A2A3A), // commute_unit (어두운 파랑 계열)
    Color(0xFF2A3A1A), // day_night_unit (어두운 초록 계열)
    Color(0xFF3A2A1A), // place (어두운 주황 계열)
    Color(0xFF2A2A2A), // vehicle (어두운 회색 계열)
    Color(0xFF3A1A2A), // basic (어두운 핑크 계열)
    Color(0xFF1A3A2A), // time_unit (어두운 초록 계열)
  ];

  // 태그 텍스트 색상 (다크) - 가독성을 위해 밝은 색상
  static const tagTextColorsDark = [
    Color(0xFF9575CD), // week_unit (밝은 보라 계열)
    Color(0xFFFFCA28), // meal_unit (밝은 노랑 계열)
    Color(0xFF42A5F5), // commute_unit (밝은 파랑 계열)
    Color(0xFF66BB6A), // day_night_unit (밝은 초록 계열)
    Color(0xFFFF8A65), // place (밝은 주황 계열)
    Color(0xFFB0BEC5), // vehicle (밝은 회색 계열)
    Color(0xFFF06292), // basic (밝은 핑크 계열)
    Color(0xFF4CAF50), // time_unit (밝은 초록 계열)
  ];

  // 태그 아이콘 색상 (다크) - 가독성을 위해 밝은 색상
  static const tagIconColorsDark = [
    Color(0xFF9575CD), // week_unit (밝은 보라 계열)
    Color(0xFFFFCA28), // meal_unit (밝은 노랑 계열)
    Color(0xFF42A5F5), // commute_unit (밝은 파랑 계열)
    Color(0xFF66BB6A), // day_night_unit (밝은 초록 계열)
    Color(0xFFFF8A65), // place (밝은 주황 계열)
    Color(0xFFB0BEC5), // vehicle (밝은 회색 계열)
    Color(0xFFF06292), // basic (밝은 핑크 계열)
    Color(0xFF4CAF50), // time_unit (밝은 초록 계열)
  ];
}
