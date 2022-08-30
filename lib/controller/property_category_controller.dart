import 'package:get/get.dart';

import '../models/model.dart';
import '../repositories/repository.dart';

class PropertyCategoryController extends GetxController {
  final PropertyCategoryRepository propertyCategoryRepository;

  PropertyCategoryController({required this.propertyCategoryRepository});

  List<PropertyCategoryModel>? _propertyCategories = [];
  List<PropertyCategoryModel> get propertyCategories =>
      [...?_propertyCategories];

  Future<List<PropertyCategoryModel>?> getPropertyCategory() async {
    _propertyCategories = await propertyCategoryRepository.loadCategories();
    update();
  }
}
