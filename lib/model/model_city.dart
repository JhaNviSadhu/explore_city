class City {
  int? id;
  String? cityName;
  String? imageUrl;
  String? stateName;
  String? cityDiscription;

  City({
    this.id,
    this.cityName,
    this.imageUrl,
    this.stateName,
    this.cityDiscription,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cityName': cityName,
      'imageUrl': imageUrl,
      'stateName': stateName,
      'cityDiscription': cityDiscription,
    };
  }

  City.fromMap(Map<String, dynamic> city) {
    id = city['id'];
    cityName = city['cityName'].toString();
    imageUrl = city['imageUrl'].toString();
    stateName = city['stateName'];
    cityDiscription = city['cityDiscription'];
  }
}
