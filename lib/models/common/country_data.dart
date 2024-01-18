class CountryData {

  CountryData({this.countries});

  CountryData.fromJson(Map<String, dynamic> json) {
    if (json['country'] != null) {
      countries = <Country>[];
      (json['country'] as Map<String, dynamic>).forEach((k, v) {
        countries!.add(Country.fromJson({'id': int.parse(k), 'value': v}));
      });
    }
  }
  List<Country>? countries;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (countries != null) {
      data['country'] = { for (var e in countries!) e.id.toString() : e.value };
    }
    return data;
  }
}

class Country {

  Country({this.id, this.value});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }
  int? id;
  String? value;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    return data;
  }
}
