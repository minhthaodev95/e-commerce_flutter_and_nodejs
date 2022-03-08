import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_ecommerce_app/src/blocs/auth/auth_bloc.dart';
import 'package:frontend_ecommerce_app/src/ui/widgets/custom_clip_path.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authorized) {
          Navigator.of(context).pushReplacementNamed('/mainscreen');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
              body: Stack(
            children: [
              ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background01.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )),
              Positioned(
                  top: MediaQuery.of(context).size.height / 2 - 58,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/icons/splash.svg'),
                        const SizedBox(height: 10),
                        const Text(
                          'ChoDoGo',
                          style: TextStyle(
                            fontFamily: 'Metro',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'The best hotels for all your needs right at your fingertips',
                          style: TextStyle(
                            fontFamily: 'Metro',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
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
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text('Sign up'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            primary: const Color(0xff323643),
                            minimumSize: const Size(double.infinity,
                                46), // double.infinity is the width and 30 is the height
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              fontFamily: 'Metropolish',
                              // fontSize: 15,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ));
        },
      ),
    );
  }
}
