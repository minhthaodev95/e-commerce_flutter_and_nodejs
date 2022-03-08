import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_ecommerce_app/src/models/user_register_model.dart';
import 'package:frontend_ecommerce_app/src/ui/auth_screen/register/blocs/register_bloc.dart';
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
                        ? const Text(
                            'Đang đăng ký',
                            textAlign: TextAlign.center,
                          )
                        : state.isSuccess
                            ? const Text(
                                'Đăng ký thành công',
                                textAlign: TextAlign.center,
                              )
                            : state.isExists
                                ? const Text(
                                    'Email đã tồn tại',
                                    textAlign: TextAlign.center,
                                  )
                                : const Text('Đăng ký thất bại',
                                    textAlign: TextAlign.center),
                    titleTextStyle: TextStyle(
                        color: state.isFailure || state.isExists
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
                    actions: state.isSuccess
                        ? [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff4FC7C0),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child:
                                    const Text('Quay lại trang đăng nhập !')),
                          ]
                        : [],
                    actionsAlignment: MainAxisAlignment.center,
                  );
                });
            if (state.isFailure || state.isExists) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              });
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
