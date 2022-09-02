import '../api/dio_client.dart';
import '../api/madalali_api.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../models/model.dart';

class BlogRepository {
  Future<List<BlogModel>> loadAllBlogs() async {
    final response = await Api.requestAllBlogs();
    List temp = response.data['data'];
    List<BlogModel> allBlogs =
        temp.map((item) => BlogModel.fromJson(item)).toList();
    return allBlogs;
  }
}
