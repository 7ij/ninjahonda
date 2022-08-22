import 'package:flutter/material.dart';
class DashBoard extends StatelessWidget with DashBasementParameters {
  var time;
  var gear;
  var speedometer;
  var rpm;
  var fuel;
  var trip;
  var bluetooth;
  var mileage;
  var temparature;

  DashBoard({
    this.bluetooth,
    this.temparature,
    this.fuel,
    this.time,
    this.gear,
    this.speedometer,
    this.rpm,
    this.trip,
    this.mileage,
  });

  @override
  Widget build(BuildContext context) {
    // num height = MediaQuery.of(context).size.height, width = MediaQuery.of(context).size.width;

    // initVariable(MediaQuery.of(context).size);

    return LayoutBuilder(builder: (context, constraints) {
      var width = constraints.maxWidth;
      var height = constraints.maxHeight;
      initVariable(Size(width, height));
      // log("${height} x ${width}");
      return Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: CustomPaint(
              painter: DashBasement(),
            ),
          ),
          Positioned(
            top: height * .732,
            left: width * .812,
            child: Container(
              width: width - width * .812,
              height: height - height * .732,
              padding: EdgeInsets.symmetric(
                horizontal: width * .006,
                vertical: 0.06 * height,
              ),
              child: time,
            ),
          ),
          Positioned(
            left: width * .041,
            // top: height * .028,
            top: 0,
            child: Container(
              height: height * .069,
              width: width * .077,
              child: FittedBox(
                child: Text(
                  "GEAR",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.082,
            // top: height * 0.11,
            left: width * 0.036,
            child: Container(
              width: width * 0.09,
              height: height * .235,
              child: gear,
            ),
          ),
          Positioned(
            left: width * 118.0 / 1497,
            top: height * 331.0 / 720,
            height: height * (379 / 720),
            // top: height * .019,
            // height: height * .967,
            // width: width * .137,
            width: width * 206.0 / 1497,
            child: Container(
              // color: Colors.green,
              child: fuel,
            ),
          ),
          Positioned(
            left: width * .009,
            top: height * .033,
            height: height * .675,
            width: width - (width * .009),
            child: Container(
              // color: Colors.green,
              child: rpm,
            ),
          ),
          Builder(builder: (context) {
            // log("${.6*(720*width*width)/(1497*height)}");
            num ratio = width / height;
            // log("ratio:${ratio}");
            num left = .4 * width * 720 / 1497;
            left *= ratio;
            // if(ratio>1.96)
            // left=min(left, width*.3);
            // log("${width/height}");
            return Positioned(
              // left: width * .763,
              left: left,
              // left: 720*.44*width*width/1497/width,
              top: height * .255,
              // top: height * .34,

              height: height * .477,
              // height: height * .357,
              width: width - left,
              child: Container(
                // color: Colors.green,
                child: speedometer,
              ),
            );
          }),
          Positioned(
            left: ghsx,
            top: bgsy,
            width: gvsrsx - ghsx,
            height: ghey - gvsrsy,
            child: Container(
              // color: Colors.green,
              child: trip,
            ),
          ),
          Positioned(
            left: csx,
            top: ghsy,
            width: gvslex - csx,
            height: gvsley - ghsy,
            child: Container(
              // color: Colors.green,
              child: bluetooth,
            ),
          ),
          Positioned(
            left: gvslex,
            top: ghsy,
            width: gvbrsx - gvslex,
            height: gvsley - ghsy,
            child: Container(
              // color: Colors.green,
              child: mileage,
            ),
          ),
          Positioned(
            left: gvsrsx,
            top: bgsy,
            width: gvbrsx - gvsrsx,
            height: ghey - bgsy,
            child: Container(
                // color: Colors.green,
                child: temparature),
          ),
        ],
      );
    });
  }
}

class DashBasementParameters {
  num height,
      width,
      ghsx,
      ghsy,
      ghex,
      ghey,
      gvbrsx,
      gvbrsy,
      gvbrex,
      gvbrey,
      gvsrsx,
      gvsrsy,
      gvsrex,
      gvsrey,
      gvslsx,
      gvslsy,
      gvslex,
      gvsley,
      csx,
      csy,
      ccx,
      ccy,
      cex,
      cey,
      bgsx,
      bgsy,
      bgex,
      bgey;

  void initVariable(Size size) {
    height = size.height;
    width = size.width;
    ghsx = width * .194;
    ghsy = height * .864;
    ghex = width * .81;
    ghey = ghsy;
    gvbrsx = width * .81;
    gvbrsy = height * .735;
    gvbrex = gvbrsx;
    gvbrey = height;
    gvsrsx = width * .58;
    gvsrsy = height * .735;
    gvsrex = gvsrsx;
    gvsrey = height * .865;
    gvslsx = width * .342;
    gvslsy = height * .865;
    gvslex = gvslsx;
    gvsley = height;

    csx = width * .154;
    // csy = 0.0;
    // csy = height * 0.019;
    csy = 0.0;
    ccx = width * .332;
    ccy = height * .469;
    cex = width * .159;
    // cey = height*1.0;// * .988;
    // cey = height * .988;
    cey = height; //- height * .009;
    bgsx = width * .222;
    bgsy = height * .74;
    bgex = width;
    bgey = bgsy;
  }
}

class DashBasement extends CustomPainter with DashBasementParameters {
  @override
  void paint(Canvas canvas, Size size) {
    //grey part
    initVariable(size);
    canvas.drawPath(
      Path()
        ..moveTo(ghsx, ghsy)
        ..lineTo(ghex, ghey)
        ..moveTo(gvbrsx, gvbrsy)
        ..lineTo(gvbrex, gvbrey)
        ..moveTo(gvsrsx, gvsrsy)
        ..lineTo(gvsrex, gvsrey)
        ..moveTo(gvslsx, gvslsy)
        ..lineTo(gvslex, gvsley),
      Paint()
        ..color = Colors.grey
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke,
    );
    //green outline
    canvas.drawPath(
      Path()
        ..moveTo(csx, csy)
        ..quadraticBezierTo(ccx, ccy, cex, cey)
        ..moveTo(bgsx, bgsy)
        ..lineTo(bgex, bgey),
      Paint()
        ..color = Colors.green
        ..strokeWidth = 8
        ..style = PaintingStyle.stroke,
    );
    // lower black cut part
    canvas.drawPath(
      Path()
        ..moveTo(cex - 10, cey)
        ..lineTo(cex + 20, cey)
        ..lineTo(cex + 20, cey - height * 8.0 / 720)
        ..lineTo(cex - 10, cey - height * 8.0 / 720)
        ..lineTo(cex - 10, cey),
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.fill,
    );

    //upper black cut part
    canvas.drawPath(
      Path()
        ..moveTo(csx - 10, csy)
        ..lineTo(csx + 20, csy)
        ..lineTo(csx + 20, height * 8.0 / 720)
        ..lineTo(csx - 10, height * 8.0 / 720)
        ..lineTo(csx - 10, csy),
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
