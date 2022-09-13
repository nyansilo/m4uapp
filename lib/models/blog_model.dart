import 'model.dart';

class BlogModel {
  final int? id;
  int? likes;
  final String? title;
  final String? description;
  final String? image;
  final String? createdAt;
  final int? commentNumber;
  final BlogCategoryModel? category;
  final BlogAuthorModel? createdBy;
  List<BlogCommentModel>? comments;

  BlogModel(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.category,
      this.createdBy,
      this.createdAt,
      this.commentNumber,
      this.comments,
      this.likes});

  factory BlogModel.fromJson(Map<String, dynamic> jsonMap) {
    return BlogModel(
      id: jsonMap['id'] ?? 0,
      comments: (jsonMap['comments'] as List)
          .map((e) => BlogCommentModel.fromJson(e))
          .toList(),
      title: jsonMap['title'] ?? "",
      description: jsonMap['description'] ?? "",
      image: jsonMap['image'] ?? "",
      commentNumber: jsonMap['commentNumber'] ?? 0,
      likes: jsonMap['likes'] ?? 0,
      category: jsonMap['category'] != null
          ? BlogCategoryModel.fromJson(jsonMap['category'])
          : null,
      createdBy: jsonMap['createdBy'] != null
          ? BlogAuthorModel.fromJson(jsonMap['createdBy'])
          : null,
      createdAt: jsonMap['createdAt'] ?? "",
    );
  }

  //Entities should contain all the logic that it controls
  //incrementLikes() {
  // likes!++;
  //}

  @override
  String toString() {
    return "{id: $id, title: $title, image: $image, category: $category, createdBy: $createdBy,}";
  }
}
