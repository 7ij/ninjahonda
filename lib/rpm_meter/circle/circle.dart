import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ninjahonda/home.dart';
import 'package:ninjahonda/rpm_meter/circle/number_painter.dart';

class Circle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CustomPaint(
        // painter: NumberPainter(),
        painter: CirclePainter(),
      ),
    );
  }
}
class CirclePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var displacementRange=300;
    var centerX = size.width/2;
    var centerY = size.height/2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    double dx=-5, dy=-10;
    canvas.translate(dx, dy);
    for (int i = 0, increament = (displacementRange / (maxRpm ~/ 1000)).toInt(), rpmMultiplier = maxRpm~/1000;
    i <= displacementRange;
    i += increament, rpmMultiplier--)
    {
      var r=radius-50;

      var x1 = centerX + r*sin(i*pi/180);
      var y1 = centerY + r*cos(i*pi/180);



      TextPainter(
          text: TextSpan(
            text: "${rpmMultiplier}",
            // text: "${x1.toInt()}, ${y1.toInt()}",
            style: TextStyle(
              fontSize: 20,


            ),
          ),
          textDirection: TextDirection.ltr)
        ..layout(
          maxWidth: size.width,
          minWidth: 0,

        )
        ..paint(
          canvas,
          Offset(x1, y1),
        );


      // canvas.drawPoints( PointMode.points, [Offset(centerX, centerY)], Paint()..strokeWidth=10..color=dayFg);
    }

    canvas.translate(-1*dx, -1*dy);

    var circleBrush = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3
    ..shader = LinearGradient(colors: [Color(0xFFb2c7ce), Color(0xFFb2c4ce),]).createShader(Rect.fromCircle(center: center, radius: radius));

    var indicatorBrush = Paint()
      ..color=Color(0xFFb2c7ce)
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius, circleBrush);
    final rect = Rect.fromLTRB(50, 45, 90, 180);
    final startAngle = -pi / 2;
    final sweepAngle = pi;
    final useCenter = false;
    // canvas.drawArc(rect, startAngle, sweepAngle, useCenter, circleBrush);
    for(int i=0, increament=(displacementRange/(maxRpm~/100)).toInt(); i<=displacementRange; i+=increament)
    {
      var r=radius-20, R=radius-7;
      var x1 = centerX + r*sin(i*pi/180);
      var y1 = centerY + r*cos(i*pi/180);
      var x2 = centerX + R*sin(i*pi/180);
      var y2 = centerY + R*cos(i*pi/180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), indicatorBrush);
    }

    for (int i = 0, increament = (displacementRange / (maxRpm ~/ 1000)).toInt(), rpmMultiplier = maxRpm~/1000;
          i <= displacementRange;
          i += increament, rpmMultiplier--)
    {
      var r=radius-30, R=radius-7;
      var x1 = centerX + r*sin(i*pi/180);
      var y1 = centerY + r*cos(i*pi/180);
      var x2 = centerX + R*sin(i*pi/180);
      var y2 = centerY + R*cos(i*pi/180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), Paint()..color=Color(0xffcedee3)..strokeWidth=3);
    }

    for(int i=0, increament=(displacementRange/(maxRpm~/500)).toInt(); i<=displacementRange; i+=increament)
    {
      var r=radius-25, R=radius-7;
      var x1 = centerX + r*sin(i*pi/180);
      var y1 = centerY + r*cos(i*pi/180);
      var x2 = centerX + R*sin(i*pi/180);
      var y2 = centerY + R*cos(i*pi/180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), Paint()..color=Color(0xffcedee3)..strokeWidth=1);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
