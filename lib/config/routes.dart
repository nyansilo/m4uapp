import 'package:flutter/material.dart';
import 'package:m4uapp/controller/add_property_controller.dart';
import 'package:m4uapp/views/screens/screen.dart';

import '../models/model.dart';

class RouteArguments<T> {
  final T? item;
  final VoidCallback? callback;
  RouteArguments({this.item, this.callback});
}

class Routes {
  static const String homeRoute = "/home";
  static const String blogRoute = "/blog";
  static const String blogDetailRoute = "/blogDetail";
  static const String blogCommentsRoute = "/blogComments";
  static const String wishListRoute = "/wishList";
  static const String accountRoute = "/account";
  static const String settingRoute = "/setting";
  static const String categoryRoute = "/category";
  static const String propertyListRoute = "/propertyList";
  static const String propertyDetailRoute = "/propertyDetail";
  static const String propertyGalleryRoute = "/propertyGallery";
  static const String propertiesRoute = "/allProperties";
  static const String blogsRoute = "/allBlogs";
  static const String pickerRoute = "/picker";
  static const String galleryUploadRoute = "/galleryUpload";
  static const String addPropertyRoute = "/addProperty";
  static const String changePasswordRoute = "/changePassword";
  static const String changeLanguageRoute = "/changeLanguage";
  static const String themeSettingRoute = "/themeSetting";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case categoryRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const Category();
          },
        );

      case addPropertyRoute:
        return MaterialPageRoute(
          builder: (context) {
            PropertyModel? item;
            if (settings.arguments != null) {
              item = settings.arguments as PropertyModel;
            }
            return AddProperty(item: item);
          },
          fullscreenDialog: true,
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

      case blogDetailRoute:
        var blog = settings.arguments as BlogModel;

        return MaterialPageRoute(
          builder: (context) {
            return BlogDetail(blog: blog);
          },
        );

      /* case blogCommentsRoute:

        var blog = settings.arguments as BlogModel;

        return MaterialPageRoute(
          builder: (context) {
            return BlogComment(blog: blog);
          },
        );
        */

      case pickerRoute:
        return MaterialPageRoute(
          builder: (context) {
            return Picker(
              picker: settings.arguments as PickerModel,
            );
          },
          fullscreenDialog: true,
        );

      case galleryUploadRoute:
        return MaterialPageRoute(
          builder: (context) {
            return GalleryUpload(
              images: settings.arguments as List<PropertyImageModel>,
            );
          },
          fullscreenDialog: true,
        );

      case settingRoute:
        return MaterialPageRoute(
          builder: (context) {
            return const Setting();
          },
        );

      case changePasswordRoute:
        return MaterialPageRoute(
          builder: (context) {
            return Container();
            //return const ChangePassword();
          },
        );

      case changeLanguageRoute:
        return MaterialPageRoute(
          builder: (context) {
            //return Container();
            return const LanguageSetting();
          },
        );

      case themeSettingRoute:
        return MaterialPageRoute(
          builder: (context) {
            return Container();
            //return const ThemeSetting();
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
