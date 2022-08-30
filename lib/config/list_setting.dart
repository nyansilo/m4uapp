import 'package:flutter/material.dart';

import '../models/model.dart';
import '../views/widgets/widget.dart';

class ListSetting {
  static List<PropertyCategoryModel> category = [];
  static List<PropertyCategoryModel> features = [];
  static List<PropertyCategoryModel> locations = [];
  static List<SortModel> sort = [];
  static int perPage = 20;
  static ProductViewType modeView = ProductViewType.list;
  static double minPrice = 0.0;
  static double maxPrice = 100.0;
  static List<String> color = [];
  static String unit = 'USD';
  static TimeOfDay startHour = const TimeOfDay(hour: 8, minute: 0);
  static TimeOfDay endHour = const TimeOfDay(hour: 15, minute: 0);

  ///Singleton factory
  static final ListSetting _instance = ListSetting._internal();

  factory ListSetting() {
    return _instance;
  }

  ListSetting._internal();
}
