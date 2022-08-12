import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninjahonda/bloc/quadratic_bezier_equation.dart';
import 'package:ninjahonda/bloc/rpm_controller.dart';
import 'package:ninjahonda/home.dart';

class HorizontalDigitalRpmMeter extends StatelessWidget {
  HorizontalDigitalRpmMeter();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, parameters) {
      var width = parameters.maxWidth;
      var height = parameters.maxHeight;
      // log("height:${height}");
      log("width:${width}");
      return Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: StaticBlackPaint(),
          ),
          CustomPaint(
            painter: StaticGreyPaint(),
          ),
          ClipPath(
            clipper: MainRpmSlotClippingPath(),
            child: Builder(
              builder: (context) {
                final RpmController rc = Get.put(RpmController());
                return Obx(
                  () => CustomPaint(
                    painter: AnimatingRpmPainter(currentRpm: rc.rpm.value),
                  ),
                );
              },
            ),
          ),
          ClipPath(
            clipper: MainRpmSlotClippingPath(),
            child: CustomPaint(
              painter: VerticalBarPainter(),
            ),
          ),
          CustomPaint(
            painter: HorizontalNumberPainter(),
          ),
          Positioned(
            left: width * .856,
            top: height * .25,
            right: width*.007,
            bottom: height*.652,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "x1000r/min",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class UpdatablePainter extends CustomPainter {
  var rpm;

  UpdatablePainter({this.rpm});

  @override
  void paint(Canvas canvas, Size size) {
    // log("size.widht:${size.width}");
    TextPainter(
      text: TextSpan(
        text: "${rpm}",
        style: TextStyle(fontSize: 20),
      ),
      textDirection: TextDirection.ltr,
    )
      ..layout(maxWidth: size.width, minWidth: 0)
      ..paint(canvas, Offset(0, 0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
    // throw UnimplementedError();
  }
}

class Parameters {
  num rightDistance,
      leftDistance,
      bottomCurveStartY,
      topCurveStartY,
      updownlength,
      topCurveContoleX,
      topCurveControleY,
      bottomCurveStartX,
      topCurveStartX,
      topCurveEndX,
      topCurveEndY,
      bottomCurveControleX,
      bottomCurveControleY;
  var path, paintWith;

  void initiateVariables(Size size) {
    rightDistance = size.height * (117.0 / 465);
    leftDistance = size.height * (69.0 / 465);
    bottomCurveStartX = 0.0;
    bottomCurveStartY = size.height;
    topCurveStartX = 0.0;
    topCurveStartY = bottomCurveStartY - leftDistance;
    updownlength = size.height * (53 / 465.0);
    topCurveContoleX = size.width / 2;
    topCurveControleY = size.height / 32;
    topCurveEndX = size.width;
    topCurveEndY = 0.0;
    bottomCurveControleX = size.width / 2;
    bottomCurveControleY = size.height / 4;
    path = Path()
      ..moveTo(bottomCurveStartX, bottomCurveStartY)
      ..lineTo(topCurveStartX, topCurveStartY)
      ..quadraticBezierTo(topCurveContoleX, topCurveControleY, topCurveEndX, topCurveEndY)
      ..lineTo(topCurveEndX, rightDistance)
      ..quadraticBezierTo(
          bottomCurveControleX, bottomCurveControleY, bottomCurveStartX, bottomCurveStartY);
    paintWith = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
  }
}

class StaticBlackPaint extends CustomPainter with Parameters {
  @override
  void paint(Canvas canvas, Size size) {
    initiateVariables(size);
    canvas.translate(-0, -updownlength);
    canvas.drawPath(
      path,
      paintWith,
    );
    canvas.translate(0, 2 * updownlength);
    canvas.drawPath(
      path,
      paintWith,
    );
    canvas.translate(0, -updownlength);
    // canvas.drawPath(path, paintWith..color = Color(0xff625b5a));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StaticGreyPaint extends CustomPainter with Parameters {
  @override
  void paint(Canvas canvas, Size size) {
    initiateVariables(size);
    canvas.drawPath(path, paintWith..color = Color(0xff625b5a));
    // canvas.clipPath(Path()..moveTo(400, 0)..lineTo(400, 500));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MiddleCurve with Parameters {
  List middleCurve;

  void loadMiddleCurve(Size size) {
    middleCurve = GetQuadraticBezierPoints(
        x0: 0,
        y0: size.height * (454 / 468.0),
        // x1: size.width*(569/1484),
        x1: size.width * .5,
        // y1: size.height *(17/468.0),
        y1: size.height * .156,
        x2: size.width - (size.width * (60.0 / 1484)),
        y2: size.height * (59.0 / 468.0),
        cnt: 10,
        increament: 0.1,
        start: 0.0);
  }
}

class BottomCurve with Parameters {
  List bottomCurve;

  void loadBottomCurve(Size size) {
    bottomCurve = GetQuadraticBezierPoints(
      x0: 0,
      y0: bottomCurveStartY,
      x1: size.width / 2,
      // x1: size.width * .5,
      y1: size.height / 4,
      // y1: size.height * .156,
      x2: size.width,
      y2: rightDistance,
      cnt: 2000,
      increament: 0.005,
      start: 0.0,
    );
  }
}

class HorizontalNumberPainter extends CustomPainter with MiddleCurve, Parameters {
  @override
  void paint(Canvas canvas, Size size) {
    loadMiddleCurve(size);
    for (int i = 1; i < middleCurve.length; i++) {
      TextPainter(
          text: TextSpan(
            text: "${i}",
            style: TextStyle(
                fontSize: size.height * (43 / 468.0),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.italic),
          ),
          textDirection: TextDirection.ltr)
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(
          canvas,
          Offset(
            middleCurve[i][0] - size.width * (15.0 / 1484),
            middleCurve[i][1] - size.height * (55 / 468.0),
          ),
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class VerticalBarPainter extends CustomPainter with MiddleCurve, Parameters {
  @override
  void paint(Canvas canvas, Size size) {
    loadMiddleCurve(size);
    // canvas.rotate(2*pi/180);
    for (int i = 1; i < middleCurve.length; i++) {
      canvas.drawLine(
          Offset(middleCurve[i][0], middleCurve[i][1]),
          Offset(middleCurve[i][0] - 5, middleCurve[i][1] + size.height * (78.0 / 468)),
          Paint()
            ..strokeWidth = size.width * (10.0 / 1484)
            ..color = Colors.white
            ..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MainRpmSlotClippingPath extends CustomClipper<Path> with Parameters {
  @override
  Path getClip(Size size) {
    initiateVariables(size);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class AnimatingRpmPainter extends CustomPainter with Parameters, BottomCurve {
  var currentRpm;

  AnimatingRpmPainter({this.currentRpm});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width * (currentRpm / maxRpm), size.height),
        Paint()..color = Colors.green);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
