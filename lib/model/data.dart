class Data
{
  double rpmData;
  double fuelData;
  int gearData;
  double speedData;
  double temperatureData;
  Data({this.rpmData, this.fuelData, this.gearData, this.speedData, this.temperatureData})
  {
    rpmData=rpmData??0.0;
    fuelData=fuelData??0.0;
    gearData=gearData??0;
    speedData=speedData??0.0;
    temperatureData=temperatureData??0.0;
  }
}