import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'package:frontend_ecommerce_app/src/ui/screens/profile/profile.dart';

import '../cart/cart.dart';
import '../homepage/homepage.dart';
import '../search/search.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  MainScreen({this.selectedIndex, Key? key}) : super(key: key);
  int? selectedIndex;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  initState() {
    super.initState();
    if (widget.selectedIndex != null) {
      _selectedIndex = widget.selectedIndex!;
    }
  }

  Widget? getScreen(index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const SearchScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const ProfileScreen();
    }

    // return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: getScreen(_selectedIndex),
      ),
      // body: getScreen(_selectedIndex),
      // floatingActionButton: showFab ? floatingActionButton() : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(30),
          //   topRight: Radius.circular(30),
          // ),
          color: Colors.transparent,
        ),
        height: Platform.isAndroid ? 80 : 100,
        // padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.white,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.red,
              bottomAppBarColor: Colors.green,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: const TextStyle(
                      color: Colors
                          .grey))), // sets the inactive color of the `BottomNavigationBar`
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
                elevation: 10,
                backgroundColor: const Color(0xffffffff),
                selectedItemColor: const Color(0xff3D5CFF),
                unselectedItemColor: const Color(0xffB8B8D2),
                selectedLabelStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: _selectedIndex == 0
                            ? const Color(0xff3D5CFF)
                            : const Color(0xffB8B8D2),
                      ),
                      label: 'Home',
                      backgroundColor: Colors.black),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      color: _selectedIndex == 1
                          ? const Color(0xff3D5CFF)
                          : const Color(0xffB8B8D2),
                    ),
                    label: 'Search',
                  ),
                  // BottomNavigationBarItem(
                  //     icon: Icon(
                  //       Icons.bookmark_border,
                  //       color: Colors.transparent,
                  //     ),
                  //     label: 'Search'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: _selectedIndex == 2
                            ? const Color(0xff3D5CFF)
                            : const Color(0xffB8B8D2),
                      ),
                      label: 'Cart'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        color: _selectedIndex == 3
                            ? const Color(0xff3D5CFF)
                            : const Color(0xffB8B8D2),
                      ),
                      label: 'Profile'),
                ]),
          ),
        ),
      ),
      extendBody: true,
    );
  }
}
