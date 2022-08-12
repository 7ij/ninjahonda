import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ninjahonda/bloc/fuel_indicator_controller.dart';
import 'package:ninjahonda/bloc/quadratic_bezier_equation.dart';

import '../../home.dart';
import '../../image_loading_helper.dart';

ui.Image image;

Future<ui.Image> loadImage(List<int> img) async {
  final Completer<ui.Image> completer = new Completer();
  ui.decodeImageFromList(img, (ui.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}

Future <ui.Image> init() async {
  final ByteData data = await rootBundle.load('assets/icon_fuel_station.png');
  return await loadImage(new Uint8List.view(data.buffer));
}

class VerticalCurvedFuelIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    init().then((value) => image = value);
    return ClipPath(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: LeftIconPainter(),
          ),
          ClipPath(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            clipper: IndicatorBoydClipper(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: StaticFuelIndicatingColorPaint(),
                ),
                Builder(
                  builder: (context) {
                    final FuelIndicatorController fic = Get.put(FuelIndicatorController());
                    return Obx(
                          () =>
                          CustomPaint(
                            painter: VerticalCurvedFuelIndicatorWidgetPainter(
                                currentFuel: fic.currentFuelLevel.value),
                          ),
                    );
                  },
                ),
                CustomPaint(
                  painter: StaticHorizontalFuelIndicatingBar(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StaticFuelIndicatingColorPaint extends CustomPainter with FuelIndicatorParameters {
  @override
  void paint(Canvas canvas, Size size) {
    initVariables(size);
    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class IndicatorBoydClipper extends CustomClipper<Path> with FuelIndicatorParameters {
  @override
  Path getClip(Size size) {
    initVariables(size);
    var path = Path()
      ..moveTo(lcsx, lcsy)
      ..quadraticBezierTo(lccx, lccy, lcex, lcey)
      ..lineTo(rcex, rcey)
      ..quadraticBezierTo(rccx, rccy, rcsx, rcsy)
      ..lineTo(lcsx, lcsy);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class FuelIndicatorParameters {
  var height, width, lcsx, lcsy, lcex, lcey, lccx, lccy, rcsx, rcsy, rcex, rcey, rccx, rccy;
  var path;

  void initVariables(Size size) {
    height = size.height;
    width = size.width;
    lcsx = width * (42 / 206.0);
    lcsy = height;

    lccx = width * (218 / 206);
    lccy = height * 99.0 / 379;

    lcex = 0.0;
    lcey = height * (-315 / 379.0);

    rcsx = width * (91 / 206.0);
    rcsy = lcsy;

    rccx = width * 332.0 / 206;
    rccy = height * 22.0 / 379;

    rcex = lcex + width * 91 / 206.0;
    rcey = lcey;

    path = Path()
      ..moveTo(lcsx, lcsy)
      ..quadraticBezierTo(lccx, lccy, lcex, lcey)
      ..lineTo(rcex, rcey)
      ..quadraticBezierTo(rccx, rccy, rcsx, rcsy)
      ..lineTo(lcsx, lcsy);
  }
}

class StaticHorizontalFuelIndicatingBar extends CustomPainter with FuelIndicatorParameters {
  @override
  void paint(Canvas canvas, Size size) {
    initVariables(size);
    num eh = (maxFuelLevel + 1) / height;
    num incr = 0.06;
    List lcp = GetQuadraticBezierPoints(
        x0: lcsx,
        y0: lcsy,
        x1: lccx,
        y1: lccy,
        x2: lcex,
        y2: lcey,
        increament: incr,
        cnt: 1 / incr);
    List rcp = GetQuadraticBezierPoints(
        x0: rcsx,
        y0: rcsy,
        x1: rccx,
        y1: rccy,
        x2: rcex,
        y2: rcey,
        increament: incr,
        cnt: 1 / incr);

    num levelDividerDepth = height * 18.0 / 692;
    for (int i = 1; i < maxFuelLevel && i < lcp.length; i++) {
      canvas.drawLine(
          Offset(lcp[i][0] - width * 150.0 / 218, rcp[i][1]),
          Offset(rcp[i][0] + width * 150.0 / 218, rcp[i][1]),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = levelDividerDepth
            ..color = Colors.black);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class VerticalCurvedFuelIndicatorWidgetPainter extends CustomPainter with FuelIndicatorParameters {
  var currentFuel;

  VerticalCurvedFuelIndicatorWidgetPainter({this.currentFuel});

  @override
  void paint(Canvas canvas, Size size) {
    initVariables(size);
    num h = height * .1145;
    canvas.drawRect(
      Rect.fromLTWH(
          0, 0, width+20, height - (currentFuel == maxFuelLevel ? currentFuel + 1 : currentFuel) * h),
      Paint()
        ..color = Colors.black,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class LeftIconPainter extends CustomPainter with FuelIndicatorParameters {


  @override
  void paint(Canvas canvas, Size size) {
    initVariables(size);
    num incr = 0.17;
    List lcp = GetQuadraticBezierPoints(
        x0: lcsx,
        y0: lcsy,
        x1: lccx,
        y1: lccy,
        x2: lcex,
        y2: lcey,
        increament: incr,
        cnt: 3 - 1);
    // log("${lcp.length}");
    for (int i = 0; i < lcp.length; i++) {
      var text = "E";
      if (i == 1)
        continue;
      if (i == 2)
        text = "F";
      TextPainter(
          text: TextSpan(
            text: text,
            style: TextStyle(
              fontSize: height * 30.0 / 379,
              color: Colors.white,
            ),
          ),
          textDirection: TextDirection.ltr)
        ..layout(
          maxWidth: width,
          minWidth: 0,
        )
        ..paint(canvas, Offset(lcp[i][0] - width * 30.0 / 206, lcp[i][1] - height * 30.0 / 379));
    }

    // canvas.drawImage(
    //     image, Offset(lcp[1][0] - width * 40.0 / 206, lcp[1][1] - height * 40.0 / 379), Paint());
    paintImage(canvas: canvas,
        // rect: Rect.fromLTWH(0, 0, width-width * 30.0 / 206,height-height * 30.0 / 379),
        rect: Rect.fromLTWH(lcp[1][0]-width * 35.0 / 206,lcp[1][1]-height * 30.0 / 379, width, height),
        image: image,
        fit: BoxFit.scaleDown,
        repeat: ImageRepeat.noRepeat,
        scale: 2,
        alignment: Alignment.topLeft,
        flipHorizontally: false,
        filterQuality: FilterQuality.high
    );
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

