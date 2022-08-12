import 'package:flutter/material.dart';

class TemparatureIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        num height = constraints.maxHeight, width = constraints.maxWidth;
        return FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: EdgeInsets.fromLTRB(width * .071, height * .07, width * .088, height * .07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.anchor,
                  color: Colors.white,
                  size: height*.523,
                ),
                Text(
                  "30 °C",
                  style: TextStyle(
                    fontSize: height * .523,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
