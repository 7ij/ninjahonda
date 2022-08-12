List GetQuadraticBezierPoints({num x0, y0, x1, y1, x2, y2, cnt, increament, start})
{
  if(start==null) {
    start = 0.0;
  }
  List points=[];
  for (num t = start, z = 0; z <= cnt && t <= 1; t += increament, z++) {
    num x = (x0 - 2 * x1 + x2) * t * t + 2 * (x1 - x0) * t + x0;
    num y = (y0 - 2 * y1 + y2) * t * t + 2 * (y1 - y0) * t + y0;
    points.add([x, y]);
  }
  return points;
}