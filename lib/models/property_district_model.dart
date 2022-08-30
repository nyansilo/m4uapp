class PropertyDistrictModel {
  int? id;
  String? name;

  PropertyDistrictModel({this.id, this.name});

  factory PropertyDistrictModel.fromJson(Map<String, dynamic> json) {
    return PropertyDistrictModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  @override
  String toString() {
    return "{id: $id, title: $name,}";
  }
}
