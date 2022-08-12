import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../home.dart';

class NumberPainter extends CustomPainter
{
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width/2;
    var centerY = size.height/2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    for (int i = 0, increament = (360 / (maxRpm ~/ 1000)).toInt(), rpmMultiplier = maxRpm~/1000;
    i <= 360;
    i += increament, rpmMultiplier--)
    {
      var r=radius-70;

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
          textDirection: TextDirection.rtl
      )..layout(
        maxWidth: size.width,
        minWidth: 0,
      )..paint(canvas, Offset(x1, y1));
      // canvas.drawPoints( PointMode.points, [Offset(centerX, centerY)], Paint()..strokeWidth=10..color=dayFg);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}