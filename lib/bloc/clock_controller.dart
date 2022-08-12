import 'package:get/get.dart';

class ClockController extends GetxController
{
  var currentTime=DateTime.now().obs;
  ClockController()
  {
    run();
  }
  Future<void> run() async
  {
    while(true)
    {
      await Future.delayed(Duration(seconds: 1));
      currentTime.value=DateTime.now();
    }
  }
}