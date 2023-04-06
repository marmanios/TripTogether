import 'package:flutter/material.dart';

class CustomSemiCircle extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final double width;
  final Color color;

  CustomSemiCircle(
      {required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _SemiCircleClipper(),
      child: Container(
        height: height,
        width: width,
        color: color,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _SemiCircleClipper extends CustomClipper<Path> {
  final double pi = 3.14;
  @override
  Path getClip(Size size) {
    final Path path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
        size.width / 2,
        size.height + size.height / (2 * pi) - size.height * 0.7,
        size.width,
        size.height * 0.7,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
