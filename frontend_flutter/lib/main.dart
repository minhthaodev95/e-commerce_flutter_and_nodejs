import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_ecommerce_app/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:frontend_ecommerce_app/src/configs/routes/app_routes.dart';
import 'package:frontend_ecommerce_app/src/configs/theme/app_theme.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthBloc _authBloc;
  @override
  void initState() {
    _authBloc = AuthBloc();
    _authBloc.add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Material App',
            onGenerateRoute: AppRoute.onGenerateRoutes,
            theme: AppTheme.light,
          );
        },
      ),
    );
  }
}
