import 'package:flutter/material.dart';
import 'package:frontend_ecommerce_app/src/ui/auth_screen/login.dart';
import 'package:frontend_ecommerce_app/src/ui/auth_screen/register.dart';
import 'package:frontend_ecommerce_app/src/ui/homepage.dart';
import 'package:frontend_ecommerce_app/src/ui/onboarding.dart';

class AppRoute {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const SplashScreen());
      case '/register':
        return _materialRoute(const RegisterScreen());
      case '/login':
        return _materialRoute(const LoginPage());
      case '/homepage':
        return _materialRoute(const HomePage());

      default:
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(
      builder: (context) => view,
    );
  }
}
