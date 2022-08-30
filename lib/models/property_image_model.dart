class PropertyImageModel {
  int? id;
  String? imgUrl;

  PropertyImageModel({this.id, this.imgUrl});

  factory PropertyImageModel.fromJson(Map<String, dynamic> json) {
    return PropertyImageModel(
      id: json['id'],
      imgUrl: json['imgUrl'],
    );
  }

  //@override
  //String toString() {
  //return "{id: $id.replaceAll(' ', ''), imgUrl: $imgUrl..replaceAll(' ', '')}";
  //}

}
