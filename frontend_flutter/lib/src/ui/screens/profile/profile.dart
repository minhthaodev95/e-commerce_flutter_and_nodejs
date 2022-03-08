import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_ecommerce_app/src/blocs/auth/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          'More',
          // style: TextStyle(color: AppTheme.colors.text1),s
        )),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authorized) {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  const Divider(height: 2),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    height: 50,
                    child: Row(
                      children: [
                        const Icon(Icons.account_circle),
                        const SizedBox(width: 18),
                        const Text('My Account'),
                        Expanded(child: Container()),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  state.user.role == 'admin'
                      ? Container(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                          height: 50,
                          child: Row(
                            children: [
                              const Icon(Icons.dashboard_outlined),
                              const SizedBox(width: 18),
                              const Text('Dashboard'),
                              Expanded(child: Container()),
                              const Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/myproducts',
                                arguments: {'userId': state.user.id});
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                            height: 50,
                            child: Row(
                              children: [
                                const Icon(Icons.shopping_cart),
                                const SizedBox(width: 18),
                                const Text('My Products'),
                                Expanded(child: Container()),
                                const Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                  const Divider(height: 1),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    height: 50,
                    child: Row(
                      children: [
                        const Icon(Icons.settings),
                        const SizedBox(width: 18),
                        const Text('Settings'),
                        Expanded(child: Container()),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    height: 50,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error,
                        ),
                        const SizedBox(width: 18),
                        const Text('About Us'),
                        Expanded(child: Container()),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    height: 50,
                    child: Row(
                      children: [
                        const Icon(Icons.logout_rounded),
                        const SizedBox(width: 18),
                        const Text('Logout'),
                        Expanded(child: Container()),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                ],
              ));
            } else {
              return const Center(
                child: Text('Setting Screen'),
              );
            }
          },
        ));
  }
}
