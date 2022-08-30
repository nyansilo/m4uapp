import '../api/dio_client.dart';
import '../api/madalali_api.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../models/model.dart';

class PropertyRepository {
  final Map<String, String> _headers = {
    'Accept': 'application/json',
  };

  Future<List<PropertyModel>> loadAllProperties() async {
    final response = await Api.requestAllProperties();
    List temp = response.data['data'];
    List<PropertyModel> allProperties =
        temp.map((item) => PropertyModel.fromJson(item)).toList();
    return allProperties;
  }

  Future<List<PropertyModel>> loadPopularProperties() async {
    //Dio dio =Dio();
    //Response response  = await dio.get("http://localhost:8000/api/properties/popular");
    //final response = await M4uApi.getDio().get("/api/properties/popular", options: Options(headers: _headers));

    final response = await Api.requestPopularProperties();
    List temp = response.data['data'];
    List<PropertyModel> popularProperties =
        temp.map((item) => PropertyModel.fromJson(item)).toList();
    return popularProperties;
  }

  Future<List<PropertyModel>> loadRecentProperties() async {
    final response = await Api.requestRecentProperties();
    List temp = response.data['data'];
    List<PropertyModel> recentProperties =
        temp.map((item) => PropertyModel.fromJson(item)).toList();

    return recentProperties;
  }

  Future<List<PropertyModel>> loadPropertiesByCategoryId(int categoryId) async {
    final response =
        await Api.requestPropertiesByCategoryId(categoryId: categoryId);
    List temp = response.data['data'];
    List<PropertyModel> propertiesByCategory =
        temp.map((item) => PropertyModel.fromJson(item)).toList();
    return propertiesByCategory;
  }

  Future<List<PropertyModel>> loadRelatedPropertiesByPropertyId(
      int propertyId) async {
    final response =
        await Api.requestRelatedPropertiesByPropertyId(propertyId: propertyId);
    List temp = response.data['data'];
    List<PropertyModel> relatedProperties =
        temp.map((item) => PropertyModel.fromJson(item)).toList();
    return relatedProperties;
  }
}
