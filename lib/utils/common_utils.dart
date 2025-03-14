import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:math';

class CommonUtils {
  /// 문자열이 비어있는지 확인
  static bool isEmpty(String? text) {
    return text == null || text.trim().isEmpty;
  }

  /// 텍스트를 자르고 최대 길이 초과 시 "..." 추가
  static String truncateText(String text, int maxLength) {
    if (isEmpty(text) || text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// 현재 날짜를 포맷팅하여 반환 (예: "2025-03-13")
  static String getFormattedDate({String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(DateTime.now());
  }

  /// 날짜를 문자열로 변환 (커스텀 포맷 가능)
  static String formatDate(DateTime date,
      {String format = 'yyyy-MM-dd HH:mm'}) {
    return DateFormat(format).format(date);
  }

  /// 랜덤 색상 생성
  static Color getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  /// 스낵바 표시 (GetX 사용)
  static void showSnackBar(String title, String message,
      {Color? backgroundColor}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor ?? Colors.grey[800],
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
    );
  }

  /// 화면 크기 기반으로 비율 계산 (반응형 디자인용)
  static double getResponsiveWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  static double getResponsiveHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  /// 리스트가 비어있는지 확인
  static bool isListEmpty<T>(List<T>? list) {
    return list == null || list.isEmpty;
  }

  /// 이메일 형식 유효성 검사
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// 숫자만 포함되어 있는지 확인
  static bool isNumeric(String? text) {
    if (isEmpty(text)) return false;
    return double.tryParse(text!) != null;
  }

  /// 디바이스 플랫폼 확인
  static bool isAndroid() => GetPlatform.isAndroid;
  static bool isIOS() => GetPlatform.isIOS;

  /// 랜덤 ID 생성 (간단한 예시)
  static String generateRandomId({int length = 8}) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(Random().nextInt(chars.length)),
      ),
    );
  }

  /// 딥카피 리스트 생성 (참조 방지)
  static List<T> deepCopyList<T>(List<T> original) {
    return List<T>.from(original);
  }
}

/// 디버깅용 로그 함수
void logDebug(String message) {
  debugPrint('[DEBUG] $message');
}
