import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_ecommerce_app/src/blocs/auth/auth_bloc.dart';
import 'package:frontend_ecommerce_app/src/configs/theme/app_theme.dart';
import 'package:frontend_ecommerce_app/src/configs/theme/colors.dart';
import 'package:frontend_ecommerce_app/src/configs/theme/text_styles.dart';

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
            title: const Text('More', style: AppTextStyle.styleTitlePage
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
                    color: AppColors.white,
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/account');
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle,
                            color: AppColors.iconProfileColor,
                          ),
                          const SizedBox(width: 18),
                          const Text('Tài khoản',
                              style: AppTextStyle.styleTextProfile),
                          Expanded(child: Container()),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.iconProfileColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  state.user.role == 'admin'
                      ? Container(
                          color: AppColors.white,
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                          height: 50,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.dashboard_outlined,
                                color: AppColors.iconProfileColor,
                              ),
                              const SizedBox(width: 18),
                              const Text('Dashboard',
                                  style: AppTextStyle.styleTextProfile),
                              Expanded(child: Container()),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.iconProfileColor,
                              ),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/myorders',
                                arguments: {'userId': state.user.id});
                          },
                          child: Container(
                            color: AppColors.white,
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                            height: 50,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.shopping_basket,
                                  color: AppColors.iconProfileColor,
                                ),
                                const SizedBox(width: 18),
                                const Text('Đơn hàng của tôi',
                                    style: AppTextStyle.styleTextProfile),
                                Expanded(child: Container()),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.iconProfileColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                  if (state.user.role == 'shopOwner') const Divider(height: 1),
                  if (state.user.role == 'shopOwner')
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/myproducts',
                            arguments: {'userId': state.user.id});
                      },
                      child: Container(
                        color: AppColors.white,
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                        height: 50,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.shopping_cart,
                              color: AppColors.iconProfileColor,
                            ),
                            const SizedBox(width: 18),
                            const Text(
                              'Sản phẩm của tôi',
                              style: AppTextStyle.styleTextProfile,
                            ),
                            Expanded(child: Container()),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.iconProfileColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  const Divider(height: 1),
                  Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    height: 50,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.settings,
                          color: AppColors.iconProfileColor,
                        ),
                        const SizedBox(width: 18),
                        const Text(
                          'Cài đặt',
                          style: AppTextStyle.styleTextProfile,
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.iconProfileColor,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    height: 50,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error,
                          color: AppColors.iconProfileColor,
                        ),
                        const SizedBox(width: 18),
                        const Text(
                          'Về chúng tôi',
                          style: AppTextStyle.styleTextProfile,
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.iconProfileColor,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    height: 50,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout_rounded,
                          color: AppColors.iconProfileColor,
                        ),
                        const SizedBox(width: 18),
                        const Text(
                          'Đăng xuất',
                          style: AppTextStyle.styleTextProfile,
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.iconProfileColor,
                        ),
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
