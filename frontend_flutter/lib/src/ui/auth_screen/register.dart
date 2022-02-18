import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_ecommerce_app/src/blocs/register_bloc/register_bloc.dart';
import 'package:frontend_ecommerce_app/src/models/user_register_model.dart';

import '../../validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // create 4 controller for the 4 textfields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _username = TextEditingController();
  final _phoneController = TextEditingController();

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
            'SignUp Screen',
            // style: TextStyle(color: AppTheme.colors.text1),
          )),
      body: BlocProvider(
        create: (context) => RegisterBloc(),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Register Failure'),
                      Icon(Icons.error)
                    ],
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
                      Text('Processing...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            }
            if (state.isExists) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Account already exists !'),
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
                      Text('Registration Successful !!'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Enter your email',
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
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Enter your phone',
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
                        primary: const Color(0xff323643),
                        minimumSize: const Size(double.infinity,
                            46), // double.infinity is the width and 30 is the height
                      ),
                      onPressed: () async {
                        UserRegister user = UserRegister(
                            username: _username.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            phone: _phoneController.text);

                        if (Validator.isValidEmail(
                                _emailController.text.trim()) &&
                            Validator.isValidPassword(
                                _passwordController.text.trim()) &&
                            Validator.isValidPhoneNumber(
                                _phoneController.text.trim())) {
                          BlocProvider.of<RegisterBloc>(context)
                              .add(RegisterWithEmailAndPassword(user: user));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                      'Invalid Email,Password or Phone Number'),
                                  Icon(Icons.error)
                                ],
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text('SignUp'),
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
