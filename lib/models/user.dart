import 'package:skillbox_test/models/address.dart';
import 'package:skillbox_test/models/company.dart';

/// Класс реализующий модель данных User
class User {
  num id;
  String name;
  String email;
  Address address;
  String phone;
  String website;
  Company company;
  bool selected;
  User(
      {this.id,
      this.name,
      this.email,
      this.company,
      this.address,
      this.phone,
      this.website,
      this.selected = false});

  String get initials =>
      name.split(' ').map((part) => part.substring(0, 1)).join();

  factory User.fromJson(Map json) {
    if (json == null) return null;

    return User(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      website: json['website'],
      address: Address.fromJson(json['address']),
      company: Company.fromJson(json['company']),
    );
  }

  Map<String, dynamic> get json => {
        'id': id,
        'email': email,
        'phone': phone,
        'name': name,
        'website': website,
        'address': address?.json,
        'company': company?.json,
      }..removeWhere((key, value) => value == null);

  @override
  String toString() => json.toString();
}
