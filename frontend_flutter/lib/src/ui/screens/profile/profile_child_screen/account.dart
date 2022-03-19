import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_ecommerce_app/src/blocs/auth/auth_bloc.dart';
import 'package:frontend_ecommerce_app/src/configs/theme/text_styles.dart';
import 'package:frontend_ecommerce_app/src/models/user_model.dart';
import 'package:frontend_ecommerce_app/src/repository/user_repository.dart';
import 'package:image_picker/image_picker.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? image;

  @override
  void initState() {
    super.initState();
  }

  Future pickerImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // a dialod to edit user profile
  Future<void> editProfile() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final nameController = TextEditingController();
            final phoneController = TextEditingController();
            final addressController = TextEditingController();
            final emailController = TextEditingController();
            late User user;

            if (state is Authorized) {
              user = state.user;
              nameController.text = state.user.name;
              phoneController.text = state.user.phone;
              addressController.text = state.user.address ?? '';
              emailController.text = state.user.email;
            }

            return AlertDialog(
              title: Text('Edit Profile'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Edit your profile'),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                      ),
                    ),
                    TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('Hủy'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: Text('Cập nhật'),
                  onPressed: () async {
                    User userUpdate = User(
                      id: user.id,
                      role: user.role,
                      image: user.image,
                      name: nameController.text,
                      phone: phoneController.text,
                      address: addressController.text,
                      email: emailController.text,
                    );
                    await UserRepository().updateUser(user: userUpdate);
                    Navigator.of(context).pop();
                    BlocProvider.of<AuthBloc>(context).add(AppStarted());
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Tài khoản',
              style: AppTextStyle.styleTitlePage,
              // style: TextStyle(color: AppTheme.colors.text1),
            ),
            actions: [
              GestureDetector(onTap: editProfile, child: Icon(Icons.edit)),
            ]),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authorized) {
              return Container(
                padding: const EdgeInsets.only(top: 36, right: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            ClipOval(
                              child: Platform.isAndroid
                                  ? Image.network(
                                      'http://10.0.2.2:3000/api/user/me${state.user.image}',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      'http://localhost:3000/api/user/me${state.user.image}',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  await pickerImage();
                                  if (image != null) {
                                    await UserRepository()
                                        .updateAvatar(file: image);
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(AppStarted());
                                  }
                                },
                                child: const Icon(
                                  Icons.add_a_photo,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.user.name,
                              style: AppTextStyle.styleHeading1,
                            ),
                            const SizedBox(height: 5),
                            if (state.user.role == 'shopOwner')
                              Text('Người bán hàng'),
                            if (state.user.role == 'customer')
                              Text('Khách hàng'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        const SizedBox(width: 20),
                        Text(
                          state.user.phone,
                          // style: AppTextStyle.styleSubtitle1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    //row email
                    Row(
                      children: [
                        Icon(Icons.email),
                        const SizedBox(width: 20),
                        Text(
                          state.user.email,
                          // style: AppTextStyle.styleSubtitle1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    //row address
                    if (state.user.address != null)
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          const SizedBox(width: 20),
                          Text(
                            state.user.address!,
                            // style: AppTextStyle.styleSubtitle1,
                          ),
                        ],
                      ),
                  ],
                ),
                //List Icon social linking
              );
            }
            return Container();
          },
        ));
  }
}
