import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_ecommerce_app/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:frontend_ecommerce_app/src/repository/user_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'HomePage',
            // style: TextStyle(color: AppTheme.colors.text1),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(LogOut());
                  Navigator.pushNamed(context, '/');
                },
                child: const Icon(Icons.logout_rounded))
          ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authorized) {
              return Column(
                children: [
                  Center(
                    child: Text('Hello  ${state.user.name}'),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        //get token from flutter_secure_storage
                        UserRepository()
                            .printToken()
                            .then((value) => print('Success'));
                      },
                      child: const Text(' Print Token'))
                ],
              );
            } else {
              return const Center(
                child: Text('HomePage'),
              );
            }
          },
        ));
  }
}
