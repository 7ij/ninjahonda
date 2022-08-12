import 'package:get/get.dart';

import '../home.dart';
import '../main.dart';

class SpeedometerController extends GetxController
{
  var currentSpeed=0.obs;
  bool f=true;
  bool isRunning = false;
  SpeedometerController()
  {
    start();
  }
  Future<void> start() async
  {
    while(true)
    {
      await Future.delayed(Duration(milliseconds: 2));
      currentSpeed.value=mdp.current.speedData.truncate();
    }
  }
  // Future<void> stop() async
  // {
  //   isRunning=false;
  // }
  // Stream<void> start() async*
  // {
  //   await for(var value in mdp.currentData)
  //   {
  //     currentSpeed.value=value.speedData;
  //   }
  // }
    // isRunning=true;
    // while(isRunning)
    // {
    //   await Future.delayed(Duration(milliseconds: 30));
    //   if(f)
    //     currentSpeed+=1;
    //   else
    //     currentSpeed-=1;
    //   if(currentSpeed>150)
    //   {
    //     f=false;
    //   }
    //   if(currentSpeed<=0)
    //     f=true;
    // }
  // }
}