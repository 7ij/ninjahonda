import 'package:get/get.dart';

class TestController extends GetxController
{
  var one = 0.obs, two =0.obs;
  TestController()
  {
    startOne();
  }
  Future<void> startOne() async
  {
    while(true)
    {
      await Future.delayed(Duration(milliseconds: 1));
      one++;
    }
  }
  Future<void> startTwo() async
  {
    while(true)
    {
      await Future.delayed(Duration(milliseconds: 1));
      two++;
    }
  }

}