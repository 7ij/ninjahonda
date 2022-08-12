import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MileageIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
          constraints.maxWidth * 0.071,
          constraints.maxHeight * 0.295,
          constraints.maxWidth * 0.049,
          constraints.maxHeight * .084,
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "AV",
                style: TextStyle(
                  fontSize: constraints.maxHeight * 0.457,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 0.381*constraints.maxWidth,),
              Text(
                "--.- km/L",
                style: TextStyle(
                  fontSize: constraints.maxHeight * 0.457,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
