import 'package:flutter/material.dart';

class BluetoothIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        num height = constraints.maxHeight, width = constraints.maxWidth;
        return FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              width * .745,
              height * .211,
              width * .073,
              height * .168,
            ),
            child: Icon(
              Icons.bluetooth,
              size: (height*.621)>width?width*.188:height*.621,
              color: Colors.white,
            ),
          ),
        );
      }
    );
  }
}
