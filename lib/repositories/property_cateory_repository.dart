import 'dart:developer';
import 'package:flutter/foundation.dart';

import '../api/madalali_api.dart';
import '../models/model.dart';

abstract class PropertyCategoryRepository {
  Future<List<PropertyCategoryModel>?> loadCategories();
  //Future<PropertyCategory> fetchPropertyCategoryById(int categoryId);
}

class PropertyCategoryRepositoryImpl implements PropertyCategoryRepository {
  @override
  Future<List<PropertyCategoryModel>?> loadCategories() async {
    final response = await Api.requestCategories();

    debugPrint(response.toString());

    List _temp = response.data['data'];
    //print(_temp);

    List<PropertyCategoryModel> _categories =
        _temp.map((item) => PropertyCategoryModel.fromJson(item)).toList();

    return _categories;
  }
}
