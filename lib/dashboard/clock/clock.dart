import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ninjahonda/bloc/clock_controller.dart';

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ClockController cc = Get.put(ClockController());
    return Obx(
      () => ClockWidget(
        currentTime: cc.currentTime.value,
      ),
    );
  }
}

class ClockWidget extends StatelessWidget {
  var currentTime;

  ClockWidget({this.currentTime});

  @override
  Widget build(BuildContext context) {
    DateTime x = currentTime;
    String hour = "${x.hour % 12}", min = "${x.minute}", second = "${x.second}";
    if (x.hour % 12 < 10) {
      hour = "0${x.hour % 12}";
    }
    if (x.minute < 10) {
      min = "0${x.minute}";
    }
    if (x.second < 10) {
      second = "0${x.second}";
    }
    return FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "${hour}: ${min}: ${second}",
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
  }
}
