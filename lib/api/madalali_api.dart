import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:m4uapp/api/dio_client.dart';
import 'package:m4uapp/api/dio_helper.dart';

import '../models/model.dart';
import 'http_manager.dart';
import 'dart:developer' as developer;

class Api {
  ///URL API
  static const String categories = "/api/categories";
  static const String allProperties = "/api/properties";
  static const String popularProperties = "/api/properties/popular";
  static const String recentProperties = "/api/properties/recent";
  static const String featuredProperties = "/api/properties/featured";
  static const String propertiesByCategoryId = "/api/properties/category";
  static const String relatedpropertiesByPropertyId = "/api/properties/related";
  static const String allBlogs = "/api/blogs";
  static const String allCommentsByBlogId = "/api/blog/comments/all";
  static const String allRegions = "/api/regions";
  static const String districtByRegionId = "/api/districts";
  static const String authValidate = "/jwt-auth/v1/token/validate";
  static const String user = "/listar/v1/auth/user";
  static const String register = "/listar/v1/auth/register";
  static const String forgotPassword = "/listar/v1/auth/reset_password";
  static const String changePassword = "/wp/v2/users/me";
  static const String changeProfile = "/wp/v2/users/me";

  ///Get Categories
  static Future<ResultApiModel> requestCategories() async {
    final result = await httpManager.get(url: categories);
    return ResultApiModel.fromJson(result.data);
  }

  ///Request All Properties
  static Future requestAllProperties() async {
    final result = await httpManager.get(url: allProperties);
    //final result = await M4uApi.getDio().get(popularProperties);
    // developer.log(result);
    return result;
  }

  ///Request Popular Properties
  static Future requestPopularProperties() async {
    final result = await httpManager.get(url: popularProperties);
    return result;
  }

  ///Request Recent Properties
  static Future<Response> requestRecentProperties() async {
    final result = await httpManager.get(url: recentProperties);
    return result;
  }

  ///Request Featued Properties
  static Future<Response> requestFeaturedProperties() async {
    final result = await httpManager.get(url: featuredProperties);
    return result;
  }

  ///Request Properties by CategoryId
  static Future<Response> requestPropertiesByCategoryId({categoryId}) async {
    final result =
        await httpManager.get(url: "$propertiesByCategoryId/$categoryId");
    return result;
  }

  ///Request Properties by CategoryId
  static Future<Response> requestRelatedPropertiesByPropertyId(
      {propertyId}) async {
    final result = await httpManager.get(
        url: "$relatedpropertiesByPropertyId/$propertyId");
    return result;
  }

  ///Request All Blogs
  static Future requestAllBlogs() async {
    final result = await httpManager.get(url: allBlogs);
    return result;
  }

  ///Request Properties by CategoryId
  static Future<Response> requestAllCommentByBlogId({blogId}) async {
    final result = await httpManager.get(url: "$allCommentsByBlogId/$blogId");
    return result;
  }

  ///Request All Regions
  static Future requestAllRegions() async {
    final result = await httpManager.get(url: allRegions);
    return result;
  }

  ///Request Properties by CategoryId
  static Future<Response> requestDistrictByRegionId({regionId}) async {
    final result = await httpManager.get(url: "$districtByRegionId/$regionId");
    return result;
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
