import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height / 2.7);
    var firstStart = Offset(size.width / 3.5, size.height / 3.4);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(
        (size.width / 3.5 + (size.width - (size.width / 6))) / 2,
        (size.height / 3.4 + size.height / 1.9) / 2);

    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(size.width - (size.width / 6), size.height / 1.9);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height / 2);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
