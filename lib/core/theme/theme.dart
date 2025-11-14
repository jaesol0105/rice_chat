import 'package:flutter/material.dart';
import 'color_scheme_ext.dart'; //이건 View에서 사용해야지 오류 사라진대요!

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF983E24),
    brightness: Brightness.light
  ),

  // 배경 컬러
  scaffoldBackgroundColor: Color(0xFFFCF5F3),

  // 텍스트 크기,두께,컬러
  textTheme: TextTheme(
    labelLarge: TextStyle(   // 위치 텍스트 '상봉동'
      color: Color(0xFFF2F2F2),
      fontSize: 20, fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(  // 리스트 안의 닉네임 텍스트
      color: Color(0xFF373737),
      fontSize: 17, fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(   // 리스트 안의 설명 텍스트
      color: Color(0xFF373737),
      fontSize: 13, 
    ),
    bodySmall: TextStyle(    // 리스트 안의 시간 텍스트
      color: Color(0xFFA3A3A3),
      fontSize: 13,
    )
  ),

  // 텍스트 필드 컬러
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    contentPadding: EdgeInsets.all(15),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Color(0xFFD2D5DA)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Color(0xFF983E24)),
    ),
    hintStyle: TextStyle(
      color: Color(0xFF373737),
      fontSize: 12,
    ),
  ),

  // 바텀네비 아이콘,라벨 크기,컬러
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(
      size: 27, color: Color(0xFF983E24),
    ),
    unselectedIconTheme: IconThemeData(
      size: 27, color: Color(0xFF373737),
    ),
    selectedLabelStyle: TextStyle(
      fontSize: 12, color: Color(0xFF983E24),
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12, color: Color(0xFF373737),
    )
  ),

  // 버튼 컬러 및 버튼 텍스트 컬러
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      fixedSize: WidgetStatePropertyAll(
        Size(double.infinity, 70),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        )
      ),
      backgroundColor: WidgetStatePropertyAll(Color(0xFF983E24)),
      foregroundColor: WidgetStatePropertyAll(Color(0xFFF2F2F2)),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    )
  ),
  
  // 버튼 컬러 및 아이콘 컬러
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF983E24),
    foregroundColor: Color(0xFFF2F2F2),
    sizeConstraints: BoxConstraints.tightFor(
      width: 60,
      height: 60
    ),
    shape: CircleBorder(),
    iconSize: 28,
  ),
);