class BlogCategoryModel {
  final int id;
  final String title;

  BlogCategoryModel(this.id, this.title);

  BlogCategoryModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        title = jsonMap['title'] ?? '';

  @override
  String toString() {
    return "{id: $id, title: $title,}";
  }
}
