import 'package:flutter/material.dart';
import 'package:frontend_ecommerce_app/src/ui/auth_screen/logins/login.dart';
import 'package:frontend_ecommerce_app/src/ui/auth_screen/register/register.dart';
import 'package:frontend_ecommerce_app/src/ui/screens/cart/cart.dart';
import 'package:frontend_ecommerce_app/src/ui/screens/homepage/homepage.dart';
import 'package:frontend_ecommerce_app/src/ui/screens/onboarding/onboarding.dart';
import 'package:frontend_ecommerce_app/src/ui/screens/main/main.dart';
import 'package:frontend_ecommerce_app/src/ui/screens/profile/profile.dart';
import 'package:frontend_ecommerce_app/src/ui/screens/profile/profile_child_screen/account.dart';
import 'package:frontend_ecommerce_app/src/ui/screens/profile/profile_child_screen/products.dart';
import 'package:frontend_ecommerce_app/src/ui/screens/search/search.dart';

class AppRoute {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const SplashScreen());
      case '/mainscreen':
        if (settings.arguments != null) {
          final args = settings.arguments as Map;
          return _materialRoute(
              MainScreen(selectedIndex: args['selectedIndex']));
        } else {
          return _materialRoute(MainScreen());
        }
      case '/register':
        return _materialRoute(const RegisterScreen());
      case '/login':
        return _materialRoute(const LoginPage());
      case '/home':
        return _materialRoute(const HomePage());
      case '/cart':
        return _materialRoute(const CartScreen());
      case '/search':
        return _materialRoute(const SearchScreen());
      case '/profile':
        return _materialRoute(const ProfileScreen());
      case '/account':
        return _materialRoute(const AccountScreen());

      case '/myproducts':
        if (settings.arguments != null) {
          final args = settings.arguments as Map;
          return _materialRoute(MyProductsScreen(userId: args['userId']));
        }
        break;
      default:
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(
      builder: (context) => view,
    );
  }
}
