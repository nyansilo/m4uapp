class BlogCommentModel {
  final int id;
  final String commentBody, authorName, createdAt;

  BlogCommentModel(this.id, this.commentBody, this.authorName, this.createdAt);

  BlogCommentModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        commentBody = jsonMap['commentBody'] ?? '',
        authorName = jsonMap['authorName'] ?? '',
        createdAt = jsonMap['createdAt'] ?? '';

  @override
  String toString() {
    return "{id: $id, commentBody: $commentBody , authorName: $authorName, createdAt: $createdAt,}";
  }
}
