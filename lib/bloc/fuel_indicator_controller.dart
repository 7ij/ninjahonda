import 'package:get/get.dart';

import '../main.dart';
num maxFuelLevel=6;
class FuelIndicatorController extends GetxController
{
  var currentFuelLevel=0.obs;
  bool f=true;
  bool isRunning = false;
  FuelIndicatorController()
  {
    currentFuelLevel.value=maxFuelLevel;
    start();
  }
  Future<void> start() async
  {
    while(true)
    {
      await Future.delayed(Duration(milliseconds: 2));
      currentFuelLevel.value=mdp.current.fuelData.truncate();
    }
  }
  //
  // Future<void> stop() async
  // {
  //   isRunning=false;
  // }
  // Future<void> start() async
  // {
  //   isRunning=true;
  //   while(isRunning)
  //   {
  //     await Future.delayed(Duration(milliseconds: 500));
  //     if(f)
  //       currentFuelLevel+=1;
  //     else
  //       currentFuelLevel-=1;
  //     if(currentFuelLevel>=maxFuelLevel)
  //     {
  //       f=false;
  //     }
  //     if(currentFuelLevel<=0)
  //       f=true;
  //   }
  // }
}