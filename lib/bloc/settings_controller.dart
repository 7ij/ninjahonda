import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController
{
  RxString webSocketAddress="".obs;
  SharedPreferences _prefs=null;
  TextEditingController tec;
  SettingsController(){
    tec = TextEditingController();
    loadSettings();
  }
  Future<void> loadSettings() async
  {
    if(_prefs==null)
     _prefs = await SharedPreferences.getInstance();
    webSocketAddress.value = _prefs.getString("webSocketAddress") ?? null;
  }
  Future<void> saveSettings() async
  {
    if(_prefs == null)
      _prefs = await SharedPreferences.getInstance();
    _prefs.setString("webSocketAddress", webSocketAddress.value);
  }

}