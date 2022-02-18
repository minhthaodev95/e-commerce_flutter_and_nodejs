import 'package:flutter/material.dart';
import 'package:frontend_ecommerce_app/src/configs/theme/colors.dart';

class AppTheme {
  static const colors = AppColors();
  static ThemeData get light {
    return ThemeData(
      appBarTheme: AppBarTheme(
          elevation: 0,
          color: colors.green,
          titleTextStyle: TextStyle(color: colors.text1)),
      scaffoldBackgroundColor: colors.white,
      splashColor: Colors.transparent,
      fontFamily: 'Poppins',
      primaryColor: colors.primaryColor,
    );
  }
}
