import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninjahonda/bloc/gear_indicator_controller.dart';
import 'package:ninjahonda/home.dart';
class GearIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GearIndicatorController gc = Get.put(GearIndicatorController());
    return Obx(() => GearIndicatorWidget(currentGear: gc.currentGear.value,),);
  }
}

class GearIndicatorWidget extends StatelessWidget {
  var currentGear;

  GearIndicatorWidget({this.currentGear});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Text(
        currentGear==0?"N":"${currentGear}",
        style: TextStyle(
          height: 1,
          fontFamily: "impact",
          color: currentGear==0?Colors.green:Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start  ,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height*.05,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "GEAR",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height*.2,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              currentGear==0?"N":"${currentGear}",
              style: TextStyle(
                height: 0.9,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
