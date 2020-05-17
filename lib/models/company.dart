/// Класс реализующий модель данных Company
class Company {
  String name;
  String catchPhrase;
  String bs;
  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory Company.fromJson(Map json) {
    if (json == null) return null;

    return Company(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }

  Map<String, dynamic> get json => {
        'name': name,
        'catchPhrase': catchPhrase,
        'bs': bs,
      }..removeWhere((key, value) => value == null);

  @override
  String toString() => json.toString();
}
