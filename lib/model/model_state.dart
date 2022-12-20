import 'dart:convert';

List<ModelState> modelStateFromMap(String str) =>
    List<ModelState>.from(json.decode(str).map((x) => ModelState.fromMap(x)));

String modelStateToMap(List<ModelState> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ModelState {
  ModelState({
    this.id,
    this.name,
    this.countryId,
    this.countryCode,
    this.countryName,
    this.stateCode,
  });

  String? id;
  String? name;
  String? countryId;
  CountryCode? countryCode;
  CountryName? countryName;
  String? stateCode;

  factory ModelState.fromMap(Map<String, dynamic> json) => ModelState(
        id: (json["id"] == null) ? null : json["id"],
        name: (json["name"] == null) ? null : json["name"],
        countryId: (json["country_id"] == null) ? null : json["country_id"],
        countryCode: json["country_code"] == null
            ? null
            : countryCodeValues.map![json["country_code"]],
        countryName: json["country_name"] == null
            ? null
            : countryNameValues.map![json["country_name"]],
        stateCode: (json["state_code"] == null) ? null : json["state_code"],
      );

  Map<String, dynamic> toMap() => {
        "id": (id == null) ? null : id,
        "name": (name == null) ? null : name,
        "country_id": (countryId == null) ? null : countryId,
        "country_code":
            countryCode == null ? null : countryCodeValues.reverse[countryCode],
        "country_name":
            countryName == null ? null : countryNameValues.reverse[countryName],
        "state_code": (stateCode == null) ? null : stateCode,
      };
}

enum CountryCode { IN }

final countryCodeValues = EnumValues({"IN": CountryCode.IN});

enum CountryName { INDIA }

final countryNameValues = EnumValues({"India": CountryName.INDIA});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
