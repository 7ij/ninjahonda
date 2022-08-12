import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:ninjahonda/test_controller.dart';
import 'dashboard/bluetooth_indicator/bluetooth_indicator.dart';
import 'dashboard/clock/clock.dart';
import 'dashboard/dashboard.dart';
import 'dashboard/fuel_incdicator/vertical_curved_fuel_indicator.dart';
import 'dashboard/gear_indicator/gear_indicator.dart';
import 'dashboard/horizontal_digital_rpm_meter/horizontal_digital_rpm_meter.dart';
import 'dashboard/mileage_indicator/mileage_indicator.dart';
import 'dashboard/speedometer/speedometer.dart';
import 'dashboard/temparature_indicator/temparature_indicator.dart';
import 'dashboard/trip_meter/trip_meter.dart';
import 'main.dart';
import 'my_custom_form.dart';

double maxRpm = 10000;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft],
    );
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      // body: Builder(builder: (context) {
      //   return Test();
      // }),
      // appBar: AppBar(
      //   title: Text("Hello"),
      // ),
      drawer: Drawer(child: MyCustomForm()),
      body: DashBoard(
        time: Clock(),
        gear: GearIndicator(),
        speedometer: Speedometer(),
        rpm: HorizontalDigitalRpmMeter(),
        fuel: VerticalCurvedFuelIndicator(),
        trip: TripMeter(),
        bluetooth: BluetoothIndicator(),
        mileage: MileageIndicator(),
        temparature: TemparatureIndicator(),
      ),
    );
  }
}
