import 'package:flutter/material.dart';
import 'package:frontend_ecommerce_app/src/configs/theme/colors.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
          elevation: 0,
          color: AppColors.white,
          iconTheme: IconThemeData(color: AppColors.text1),
          titleTextStyle: TextStyle(color: AppColors.text1)),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      splashColor: Colors.transparent,
      fontFamily: 'Roboto',
      primaryColor: AppColors.primaryColor,
    );
  }
}
