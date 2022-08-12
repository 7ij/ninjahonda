import 'package:get/get.dart';

import '../home.dart';
import '../main.dart';

class RpmController extends GetxController
{
  var rpm=0.0.obs;
  bool f=true;
  bool isRunning = false;
  RpmController()
  {
    rpm.value=maxRpm;
    start();
  }
  Future<void> start() async
  {
    while(true)
    {
      await Future.delayed(Duration(milliseconds: 2));
      rpm.value=mdp.current.rpmData;
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
  //     await Future.delayed(Duration(microseconds: 800));
  //     if(f)
  //       rpm+=1;
  //     else
  //       rpm-=1;
  //     if(rpm>maxRpm)
  //     {
  //       f=false;
  //     }
  //     if(rpm<=0)
  //       f=true;
  //   }
  // }
}