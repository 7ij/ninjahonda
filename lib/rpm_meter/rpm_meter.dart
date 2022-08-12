import 'package:flutter/material.dart';
import 'package:ninjahonda/rpm_meter/aero.dart';
import 'package:ninjahonda/rpm_meter/circle/circle.dart';

import 'center_dot.dart';

class RpmMeter extends StatelessWidget {
  double currentRpm;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Circle(),
        // Positioned(
        //   bottom: 80,
        //   child: Text(
        //     "${(currentRpm/1000).toInt()}",
        //     style: TextStyle(
        //       fontSize: 100,
        //       color: Color(0xffacbdce),
        //     ),
        //   ),
        // ),
        Aero(
          rpm: currentRpm,
        ),
        CenterDot(),
      ],
    );
  }

  RpmMeter({this.currentRpm});
}
