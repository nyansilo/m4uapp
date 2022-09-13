import 'package:flutter/material.dart';
import 'package:m4uapp/views/screens/screen.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../config/routes.dart';
import 'classes/language_constant.dart';
import 'controller/controller.dart';
import 'controller/property_controller.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  _AppContainerState createState() {
    return _AppContainerState();
  }
}

class _AppContainerState extends State<AppContainer> {
  String _selected = Routes.homeRoute;

  ///Export index stack
  int _exportIndexed(String route) {
    switch (route) {
      case Routes.homeRoute:
        return 0;
      case Routes.wishListRoute:
        return 1;
      case Routes.blogRoute:
        return 2;
      case Routes.accountRoute:
        return 3;
      default:
        return 0;
    }
  }

  ///On change tab bottom menu and handle when not yet authenticate
  void _onItemTapped({
    required String route,
  }) async {
    setState(() {
      _selected = route;
    });
  }

  ///On handle submit post
  void _onSubmit() {}

  ///Build Item Menu
  Widget _buildMenuItem({
    required String route,
  }) {
    Color? color;
    String title = 'home';
    IconData iconData = Icons.help_outline;
    switch (route) {
      case Routes.homeRoute:
        iconData = Icons.home_outlined;
        title = translation(context).home_nav_item;
        break;
      case Routes.wishListRoute:
        iconData = Icons.bookmark_outline;
        title = translation(context).wishlist_nav_item;
        break;
      case Routes.blogRoute:
        iconData = Icons.wysiwyg_outlined;
        title = translation(context).blog_nav_item;
        break;
      case Routes.accountRoute:
        iconData = Icons.account_circle_outlined;
        title = translation(context).account_nav_item;
        break;
      default:
        iconData = Icons.home_outlined;
        title = translation(context).home_nav_item;
        break;
    }
    if (route == _selected) {
      color = Theme.of(context).primaryColor;
    }
    return IconButton(
      onPressed: () {
        _onItemTapped(route: route);
      },
      padding: EdgeInsets.zero,
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: color,
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontSize: 10,
                  color: color,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _exportIndexed(_selected),
        children: <Widget>[Home(), WishList(), Blogs(), Account()],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 7,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMenuItem(
                route: Routes.homeRoute,
              ),
              _buildMenuItem(
                route: Routes.wishListRoute,
              ),
              const SizedBox(width: 56),
              _buildMenuItem(
                route: Routes.blogRoute,
              ),
              _buildMenuItem(
                route: Routes.accountRoute,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          GetBuilder<AddPropertyController>(builder: (popularPropertiesData) {
        return FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            popularPropertiesData.getAllRegions();
            //popularPropertiesData.getAllBlogs();
            Navigator.pushNamed(
              context,
              Routes.addPropertyRoute,
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
