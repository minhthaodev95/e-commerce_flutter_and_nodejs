import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_ecommerce_app/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:frontend_ecommerce_app/src/blocs/login_bloc/login_bloc.dart';

import '../../validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordController = TextEditingController();
  final _username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text(
          'LoginPage',
          // style: TextStyle(color: AppTheme.colors.text1),
        ),
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Login Failure'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state.isSubmitting) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Logging In...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            }
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('You are logged in !'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
              BlocProvider.of<AuthBloc>(context).add(LoggedIn());
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _username,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        primary: const Color(0xff3FB6F7),
                        minimumSize: const Size(double.infinity,
                            46), // double.infinity is the width and 30 is the height
                      ),
                      onPressed: () {
                        if (Validator.isValidEmail(_username.text.trim()) &&
                            Validator.isValidPassword(
                                _passwordController.text.trim())) {
                          BlocProvider.of<LoginBloc>(context).add(
                              LoginWithEmailAndPassword(
                                  email: _username.text.trim(),
                                  password: _passwordController.text));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Invalid Email or Password'),
                                  Icon(Icons.error)
                                ],
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        // var formData = FormData.fromMap({
                        //   "username": _username.text,
                        //   "password": _passwordController.text,
                        // });
                        // BaseOptions options = BaseOptions(
                        //   baseUrl: "http://localhost:3000/api/",
                        //   connectTimeout: 3000,
                        //   receiveTimeout: 3000,
                        // );
                        // Dio dio = Dio(options);
                        // await dio
                        //     .request(
                        //       '/user/login',
                        //       data: formData,
                        //       options: Options(method: 'POST'),
                        //     )
                        //     .then((value) =>
                        //         print('data : ' + value.data['token']))
                        //     .catchError((error) => print(error));
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
