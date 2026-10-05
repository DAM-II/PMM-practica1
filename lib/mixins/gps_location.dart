mixin GPSLocation {
  double latitude = 0.0;
  double longitude = 0.0;

  void updateLocation(double lat, double lng) {
    latitude = lat;
    longitude = lng;
  }

  (double lat, double lng) getCoordinates() {
    return (latitude, longitude);
  }
}
