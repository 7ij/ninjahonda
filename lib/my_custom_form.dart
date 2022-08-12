import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninjahonda/bloc/settings_controller.dart';

import 'dashboard/speedometer/speedometer.dart';
import 'main.dart';

class MyCustomForm extends StatelessWidget {
  // const MyCustomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Obx(() {
            return TextField(
              controller: settingsController.tec..text=settingsController.webSocketAddress.value,
              textDirection: TextDirection.ltr,
              onEditingComplete:() {
                settingsController.webSocketAddress.value = settingsController.tec.text;
                settingsController.saveSettings();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ws://xxx.xxx.xxx.xxx:yyyyy',
              ),
            );
          }),
        ),
      ],
    );
  }
}
