import 'package:flutter/material.dart';

import 'components/form_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.blue[600]),
              height: MediaQuery.of(context).size.height - 20,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 60.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        color: Colors.deepOrange[300],
                      ),
                    ),
                  ]),
            ),
            const Positioned(
              top: 180,
              left: 0,
              right: 0,
              bottom: 0,
              child: FormLogin(),
            ),
          ],
        ),
      ),
    );
  }
}
