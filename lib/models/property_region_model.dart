class PropertyRegionModel {
  int? id;
  String? name;

  PropertyRegionModel({this.id, this.name});

  factory PropertyRegionModel.fromJson(Map<String, dynamic> json) {
    return PropertyRegionModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  @override
  String toString() {
    return "{id: $id, title: $name,}";
  }
}
