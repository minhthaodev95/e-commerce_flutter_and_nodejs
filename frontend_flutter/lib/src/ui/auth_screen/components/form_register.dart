import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_ecommerce_app/src/blocs/register_bloc/register_bloc.dart';
import 'package:frontend_ecommerce_app/src/models/user_register_model.dart';
import 'package:frontend_ecommerce_app/src/validator.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({Key? key}) : super(key: key);

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _username = TextEditingController();

  final _phoneController = TextEditingController();

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Họ và Tên',
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
                      height: 10,
                    ),
                    Text(
                      'Email',
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
                        controller: _emailController,
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
                          hintText: 'Enter your email',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                    const SizedBox(
                      height: 5,
                    ),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Số điện thoại',
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
                        controller: _phoneController,
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
                          hintText: 'Enter your phone number',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
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
                        child: const Text('Đăng ký'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Or with',
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
                        const Text('Already have account?'),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text('Sign in',
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
