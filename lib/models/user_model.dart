class UserModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? jobTitle;
  final String? email;
  final String? phoneNumber;
  final String? bio;
  final String? profileImg;

  //Typically called form service layer to create a new user
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.jobTitle,
    this.email,
    this.bio,
    this.phoneNumber,
    this.profileImg,
  });

  //Typically called from data_source layer after getting data from external source.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      userName: json['userName'] ?? "",
      jobTitle: json['jobTitle'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phoneNumber'] ?? "",
      bio: json['bio'] ?? "",
      profileImg: json['profileImg'] ?? "",
    );
  }

  @override
  String toString() {
    return "{id: $id, firstName: $firstName, lastName: $lastName, email: $email, bio: $bio,}";
  }
}
