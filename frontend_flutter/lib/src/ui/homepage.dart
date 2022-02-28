import 'dart:io' show File, Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_ecommerce_app/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:frontend_ecommerce_app/src/repository/user_repository.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;
  List<File?> images = [];
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

  Future<void> pickMultiImage() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      final imagesTemporary = images.map((image) => File(image.path)).toList();
      setState(() {
        this.images = imagesTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'HomePage',
            // style: TextStyle(color: AppTheme.colors.text1),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(LogOut());
                  Navigator.pushNamed(context, '/');
                },
                child: const Icon(Icons.logout_rounded))
          ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authorized) {
              return Column(
                children: [
                  state.user.image == null
                      ? Container()
                      : ClipOval(
                          child: Platform.isAndroid
                              ? Image.network(
                                  'http://10.0.2.2:3000/api/user/me${state.user.image}',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  'http://localhost:3000/api/user/me${state.user.image}',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                  Center(
                    child: Text('Hello  ${state.user.name}'),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await pickerImage();
                        if (image != null) {
                          await UserRepository().uploadUserAvatar(image!);
                          BlocProvider.of<AuthBloc>(context).add(AppStarted());
                        }
                      },
                      child: const Text(' Upload avatar')),
                  ElevatedButton(
                      onPressed: () async {
                        await pickMultiImage();
                        await UserRepository().uploadMultiImage(images);
                      },
                      child: const Text(' Upload Images')),
                ],
              );
            } else {
              return const Center(
                child: Text('HomePage'),
              );
            }
          },
        ));
  }
}
