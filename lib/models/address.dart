import 'package:skillbox_test/models/geo_point.dart';

/// Класс реализующий модель данных Address
class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  GeoPoint geo;
  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory Address.fromJson(Map json) {
    if (json == null) return null;

    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: GeoPoint.fromJson(json['geo']),
    );
  }

  Map<String, dynamic> get json => {
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipcode,
        'geo': geo?.json,
      }..removeWhere((key, value) => value == null);

  @override
  String toString() => json.toString();
}
