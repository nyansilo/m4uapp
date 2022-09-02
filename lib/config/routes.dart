import 'package:flutter/material.dart';
import 'package:m4uapp/views/screens/screen.dart';

import '../models/model.dart';

class RouteArguments<T> {
  final T? item;
  final VoidCallback? callback;
  RouteArguments({this.item, this.callback});
}

class Routes {
  static const String home = "/home";
  static const String blog = "/blog";
  static const String wishList = "/wishList";
  static const String account = "/account";
  static const String categoryRoute = "/category";
  static const String propertyListRoute = "/propertyList";
  static const String propertyDetailRoute = "/propertyDetail";
  static const String propertyGalleryRoute = "/propertyGallery";
  static const String propertiesRoute = "/allProperties";
  static const String blogsRoute = "/allBlogs";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case categoryRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const Category();
          },
        );

      case propertyListRoute:
        var category = settings.arguments as CategoryDisplayModel;
        return MaterialPageRoute(
          builder: (context) {
            return PropertyList(category: category);
          },
        );

      case propertyDetailRoute:
        var property = settings.arguments as PropertyModel;

        return MaterialPageRoute(
          builder: (context) {
            return PropertyDetail(property: property);
          },
        );

      case propertyGalleryRoute:
        var property = settings.arguments as PropertyModel;

        return MaterialPageRoute(
          builder: (context) {
            return PropertyGallery(property: property);
          },
        );

      case propertiesRoute:
        return MaterialPageRoute(
          builder: (context) {
            return AllProperties();
          },
        );

      case blogsRoute:
        return MaterialPageRoute(
          builder: (context) {
            return Blogs();
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            );
          },
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
