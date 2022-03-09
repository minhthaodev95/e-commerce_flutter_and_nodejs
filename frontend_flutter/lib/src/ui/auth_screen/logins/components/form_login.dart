import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_ecommerce_app/src/blocs/auth/auth_bloc.dart';
import 'package:frontend_ecommerce_app/src/ui/auth_screen/logins/blocs/login_bloc.dart';

import '../../../../validator.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _passwordController = TextEditingController();

  final _username = TextEditingController();

  bool _rememberBtn = false;

  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 10.0,
        right: 10.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    contentPadding: const EdgeInsets.all(0),
                    insetPadding: const EdgeInsets.all(0),
                    title: state.isSubmitting
                            
                        ? const Text('Đang đăng nhập',textAlign: TextAlign.center,)
                        : state.isSuccess
                            ? const Text('Đăng nhập thành công',textAlign: TextAlign.center,)
                            : const Text('Email hoặc mật khẩu không đúng !', textAlign: TextAlign.center,),
                    titleTextStyle: TextStyle(
                        color: state.isFailure
                            ? Colors.red[600]
                            : const Color(0xff25D781),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    content: SizedBox(
                      height: 60,
                      child: Center(
                        child: state.isSubmitting
                            ? const SizedBox(
                                width: 32,
                                height: 32,
                                child: CircularProgressIndicator(
                                  color: Color(0xff25D781),
                                ),
                              )
                            : state.isSuccess
                                ? const Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Color(0xff25D781),
                                    size: 48,
                                  )
                                : Icon(
                                    Icons.error_outline,
                                    color: Colors.red[600],
                                    size: 48,
                                  ),
                      ),
                    ),
                  );
                });
            if (state.isSuccess) {
              Future.delayed(const Duration(milliseconds: 500), () {
                BlocProvider.of<AuthBloc>(context).add(LoggedIn());
              });
            } else if (state.isFailure) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              });
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(20),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tài khoản email',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _username,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              right: 10, top: 0, bottom: 0, left: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.teal),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.teal),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          hintText: 'Enter your username',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Mật khẩu',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        obscureText: isObscured,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              right: 10, top: 0, bottom: 0, left: 20),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isObscured = !isObscured;
                              });
                            },
                            child: isObscured
                                ? const Icon(Icons.remove_red_eye,
                                    color: Colors.grey)
                                : const Icon(Icons.remove_red_eye_outlined,
                                    color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.teal),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.teal),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          // labelText: 'Password',
                          // labelStyle: TextStyle(color: Colors.red),
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              color: Colors.blue[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
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
                                    password: _passwordController.text.trim()));
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
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: SvgPicture.asset(
                            'assets/svg_images/google.svg',
                            height: 24,
                            width: 24,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: SvgPicture.asset(
                              'assets/svg_images/facebook.svg'),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text('Sign up',
                              style: TextStyle(color: Colors.blue[700])),
                        ),
                      ],
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
