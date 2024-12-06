import 'package:flutter/material.dart';

class AppColors {
  static const Color mainColor = Color(0xFF46B1E1); // 메인 색상
  static const Color secondaryColor = Color(0xFF5DC8F5); // 보조 색상
  static const Color backgroundColor = Color(0xFFFFFFFF); // 배경 색상
  static const Color chatbackgroundColor = Color(0xFFF6F6F6);
  static const Color maintext = Color(0xFF191919); // 텍스트 색상
  static const Color subtexo = Color(0xFF9A9A9A);
  static const Color accentColor = Color(0xFFFFC107); // 강조 색상
}

class AppGradients {
  static const LinearGradient mainGradient = LinearGradient(
    colors: [
      Color(0xFF79D5FF), // 시작색
      Color(0xFF46B1E1), // 끝색
    ],
    begin: Alignment(-0.87, -0.5), // 66도
    end: Alignment(0.87, 0.5), // 맞춘거
  );
}

class AppFonts {
  static const String pretendard = 'Pretendard'; 

  static const TextStyle extralight = TextStyle(
    fontFamily: pretendard,
    fontWeight: FontWeight.w200,
    letterSpacing: -0.7,
  );
  
  static const TextStyle light = TextStyle(
    fontFamily: pretendard,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.7,
  );

    static const TextStyle regular = TextStyle(
    fontFamily: pretendard,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.7,
  );

  static const TextStyle medium = TextStyle(
    fontFamily: pretendard,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.7,
  );

  static const TextStyle semibold = TextStyle(
    fontFamily: pretendard,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.7,
  );

  static const TextStyle bold = TextStyle(
    fontFamily: pretendard,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.7,
  );
}