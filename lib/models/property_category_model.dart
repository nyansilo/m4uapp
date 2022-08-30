class PropertyCategoryModel {
  int? id;
  String? title;

  PropertyCategoryModel({this.id, this.title});

  factory PropertyCategoryModel.fromJson(Map<String, dynamic> json) {
    return PropertyCategoryModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
    );
  }

  @override
  String toString() {
    return "{id: $id, title: $title,}";
  }
}
