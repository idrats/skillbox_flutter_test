/// Класс реализующий модель данных GeoPoint
class GeoPoint {
  double lat;
  double lng;
  GeoPoint({
    this.lat,
    this.lng,
  });

  factory GeoPoint.fromJson(Map json) {
    if (json == null) return null;

    return GeoPoint(
      lat: double.tryParse(json['lat']),
      lng: double.tryParse(json['lng']),
    );
  }

  Map<String, dynamic> get json => {
        'lat': lat?.toString(),
        'lng': lng?.toString(),
      }..removeWhere((key, value) => value == null);

  @override
  String toString() => json.toString();
}
