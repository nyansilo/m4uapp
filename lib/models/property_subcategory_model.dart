class PropertySubCategoryModel {
  int? id;
  String? title;

  PropertySubCategoryModel({this.id, this.title});

  factory PropertySubCategoryModel.fromJson(Map<String, dynamic> json) {
    return PropertySubCategoryModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
    );
  }

  @override
  String toString() {
    return "{id: $id, title: $title,}";
  }
}
