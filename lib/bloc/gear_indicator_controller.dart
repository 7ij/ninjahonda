import 'package:get/get.dart';

import '../home.dart';
import '../main.dart';
num maxGear=4;
class GearIndicatorController extends GetxController
{
  var currentGear=0.obs;
  bool f=true;
  bool isRunning = false;
  GearIndicatorController()
  {

    start();
  }
  Future<void> start() async
  {
    while(true)
    {
      await Future.delayed(Duration(milliseconds: 2));
      currentGear.value=mdp.current.gearData;
    }
  }
  // Future<void> stop() async
  // {
  //   isRunning=false;
  // }
  // Future<void> start() async
  // {
  //   isRunning=true;
  //   while(isRunning)
  //   {
  //     await Future.delayed(Duration(milliseconds: 2000));
  //     if(f)
  //       currentGear+=1;
  //     else
  //       currentGear-=1;
  //     if(currentGear>maxGear)
  //     {
  //       f=false;
  //     }
  //     if(currentGear<=0)
  //       f=true;
  //   }
  // }
}