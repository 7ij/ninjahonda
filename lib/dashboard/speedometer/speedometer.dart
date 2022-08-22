import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ninjahonda/bloc/speedometerController.dart';

class Speedometer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SpeedometerController sc = Get.put(SpeedometerController());
    return Obx(() => SpeedometerWidget(
      currentSpeed: sc.currentSpeed.value,
    ));
  }
}

class SpeedometerWidget extends StatelessWidget {
  var currentSpeed;

  SpeedometerWidget({this.currentSpeed});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpeedometerWidgetPainter(currentSpeed: currentSpeed),
    );
  }
}

class SpeedometerWidgetPainter extends CustomPainter {
  String currentSpeed;

  SpeedometerWidgetPainter({var currentSpeed}) {
    this.currentSpeed = "${currentSpeed}";
  }

  @override
  void paint(Canvas canvas, Size size) {
    num height = size.height, width = size.width, squareCanvasSize = min(size.height, size.width);
    num myBoardSize = size.width;
    num speedWidth = width * .8, gap = width * 0, unitWidth = width * .2;
    num speedOffsetX = 0;
    num unitFontSize = (50 / 525) * speedWidth;
    num UnitYOffset = height - (60 / 525) * speedWidth;
    num SpeedYOffset = height - (0.655) * speedWidth;
    if (currentSpeed.length == 1) {
      speedOffsetX = 2 * speedWidth / 3.0;
    } else if (currentSpeed.length == 2) {
      speedOffsetX = 1 * speedWidth / 3.0;
    }
    TextPainter(
        text: TextSpan(
            text: "${currentSpeed}",
            style: TextStyle(
              letterSpacing: 0,
              fontSize: (120 / 210) * speedWidth,
              fontStyle: FontStyle.italic,
              // fontFamily: "impact",
              color: Colors.white,
            )),
        textDirection: TextDirection.ltr)
      ..layout(
        maxWidth: speedWidth + gap,
        minWidth: 0,
      )
      ..paint(canvas, Offset(speedOffsetX * 1.0, SpeedYOffset));

    TextPainter(
      text: TextSpan(text: "km/h", style: TextStyle(fontSize: unitFontSize, color: Colors.white)),
      textDirection: TextDirection.rtl,
    )
      ..layout(
        maxWidth: unitWidth,
        minWidth: 0,
      )
      ..paint(canvas, Offset(speedWidth + gap, UnitYOffset));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
