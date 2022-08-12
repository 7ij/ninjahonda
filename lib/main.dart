import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ninjahonda/bloc/main_data_provider.dart';
import 'package:ninjahonda/test_controller.dart';
import 'package:window_manager/window_manager.dart';

import 'bloc/settings_controller.dart';
import 'home.dart';
SettingsController settingsController = Get.put(SettingsController());
MainDataProvider mdp = MainDataProvider();
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.setSize(Size(1497, 720));
  runApp(GetMaterialApp(
      home: Home(),
  ));
}