class Waste{
  String imageUrl;
  double longitude;
  double latitude;
  int wasteCount;
  String date;
  Waste({this.imageUrl, this.longitude, this.latitude, this.wasteCount, this.date});
  String shareLocation(){
    return "Meet me at ($longitude $latitude) !";
  }
}
