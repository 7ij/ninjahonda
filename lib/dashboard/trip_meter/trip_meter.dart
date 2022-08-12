import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TripMeter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    num height = MediaQuery.of(context).size.height, width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.041, height * .018, width * .023, height * .011),
      child: Container(
        // color: Colors.red,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "TRIP A",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height*.057,
                ),
              ),
              SizedBox(width: width*.124,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    // color: Colors.grey,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "6969",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height*.09,
                          // height: 1.2
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 0.014*width,),
                  Text(
                    "km",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height*.043,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
