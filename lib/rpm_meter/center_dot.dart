import 'dart:ui';

import 'package:flutter/material.dart';

class CenterDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CustomPaint(
        painter: CenterDotPainter(),
      ),
    );
  }
}

class CenterDotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    num cx = size.width / 2;
    num cy = size.height / 2;
    canvas.drawPoints(
      PointMode.points,
      [
        Offset(cx, cy),
      ],
      Paint()
        ..color = Color(0xffd8d9e0)
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 20,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
