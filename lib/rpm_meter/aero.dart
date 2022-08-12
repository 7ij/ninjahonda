import 'package:flutter/material.dart';
import 'dart:math';
import '../home.dart';

class Aero extends StatelessWidget {
  double rpm = 0;
  double displacementAngle = 150;

  @override
  Widget build(BuildContext context) {
    double angle = 61*pi/180;
    return Transform.rotate(
      // angle:30*pi/180,
      angle: angle + (rpm / (maxRpm / (2 * displacementAngle)) * pi) / 180.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CustomPaint(
          painter: AeroPainter(),
        ),
      ),
    );
  }

  Aero({this.rpm});
}
class AeroPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var cx = size.width / 2;
    var cy = size.height / 2;
    var radius = min(cx, cy)-20;

    var x2 = cx + radius * sin(pi / 180);
    var y2 = cy + radius * cos(pi / 180);
    int d=6;
    canvas.drawPath(
      Path()
      ..moveTo(cx-d, cy)
      ..lineTo(x2, y2)
      ..lineTo(cx+d, cy)
      ..lineTo(cx-d, cy)
        ,
      Paint()
        ..style = PaintingStyle.fill
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..color = Color(0xffd8d9e0),
        // ..color = Color(0xffff0000),

    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}