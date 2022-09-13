import 'model.dart';

class PropertyModel {
  int? id;
  double? price;
  String? title;
  String? slug;
  String? description;
  String? address;
  List<PropertyImageModel>? images;

  ///final List<PropertyModel>? latest;
  String? createdAt;
  //int? viewNumber;
  String? type;
  PropertyCategoryModel? category;
  PropertySubCategoryModel? subCategory;
  UserModel? createdBy;
  PropertyDistrictModel? district;
  PropertyRegionModel? region;
  bool? isFavorite;
  bool? isBooking;
  final int? area;
  final int? room;
  final int? sittingRoom;
  final int? bed;
  final int? bath;
  final String? vehicleBrand;
  final String? modelType;
  final String? drivingType;
  final int? engineCapacity;
  final int? coverage;
  final String? fuelType;
  final String? color;
  final double? rate;
  final int? numRate;

  PropertyModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.address,
    required this.images,
    required this.category,
    required this.subCategory,
    required this.type,
    required this.price,
    required this.region,
    required this.district,
    this.createdBy,

    ///this.latest,
    this.createdAt,
    // this.viewNumber,
    this.isFavorite,
    this.isBooking,
    this.area,
    this.room,
    this.sittingRoom,
    this.bed,
    this.bath,
    this.vehicleBrand,
    this.modelType,
    this.drivingType,
    this.engineCapacity,
    this.coverage,
    this.fuelType,
    this.color,
    this.rate,
    this.numRate,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      slug: json['slug'] ?? "",
      description: json['description'] ?? "",
      address: json['address'] ?? "",
      createdAt: json['createdAt'] ?? "",
      images: (json['images'] as List)
          .map((e) => PropertyImageModel.fromJson(e))
          .toList(),
      type: json['type'] ?? "",
      price:
          double.parse(json['price'].toStringAsFixed(2) ?? '0.00'.toString()),
      //viewNumber: json['viewNumber'],
      isFavorite: json['isFavorite'] ?? false,
      isBooking: json['isBooking'] ?? false,
      region: json['region'] != null
          ? PropertyRegionModel.fromJson(json['region'])
          : null,
      district: json['district'] != null
          ? PropertyDistrictModel.fromJson(json['district'])
          : null,
      category: json['category'] != null
          ? PropertyCategoryModel.fromJson(json['category'])
          : null,
      subCategory: json['subCategory'] != null
          ? PropertySubCategoryModel.fromJson(json['subCategory'])
          : null,
      createdBy: json['createdBy'] != null
          ? UserModel.fromJson(json['createdBy'])
          : null,
      //latest: listLastest,

      area: json['area'] ?? 0,
      room: json['room'] ?? 0,
      sittingRoom: json['sittingRoom'] ?? 0,
      bed: json['bed'] ?? 0,
      bath: json['bath'] ?? 0,
      engineCapacity: json['engineCapacity'] ?? 0,
      coverage: json['coverage'] ?? 0,
      vehicleBrand: json['vehicleBrand'] ?? "",
      modelType: json['modelType'] ?? "",
      drivingType: json['drivingType'] ?? "",
      fuelType: json['fuelType'] ?? "",
      color: json['color'] ?? "",
      rate: double.parse(json['rate'].toStringAsFixed(1) ?? '0.0'.toString()),
      numRate: json['numRate'] ?? 0,
    );
  }

  @override
  String toString() {
    return "{id: $id, title: $title, slug:$slug, $title,  category: $category, district: $district,  image1: $images, createdBy: $createdBy,}";
  }
}
