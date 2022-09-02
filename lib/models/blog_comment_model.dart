class BlogComment {
  final int id;
  final String commentBody, authorName, createdAt;

  BlogComment(this.id, this.commentBody, this.authorName, this.createdAt);

  BlogComment.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        commentBody = jsonMap['commentBody'] ?? '',
        authorName = jsonMap['authorName'] ?? '',
        createdAt = jsonMap['createdAt'] ?? '';

  @override
  String toString() {
    return "{id: $id, commentBody: $commentBody , authorName: $authorName, createdAt: $createdAt,}";
  }
}
