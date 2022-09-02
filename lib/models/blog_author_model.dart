class BlogAuthorModel {
  final int id;
  final String firstName, lastName, email;

  BlogAuthorModel(this.id, this.firstName, this.lastName, this.email);

  BlogAuthorModel.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        firstName = jsonMap['firstName'] ?? '',
        lastName = jsonMap['lastName'] ?? '',
        email = jsonMap['email'] ?? '';

  @override
  String toString() {
    return "{id: $id, firstName: $firstName, lastName: $lastName, email: $email ,}";
  }
}
