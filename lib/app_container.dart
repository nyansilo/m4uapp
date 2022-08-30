import 'package:flutter/material.dart';
import 'package:m4uapp/views/screens/screen.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../config/routes.dart';
import 'controller/property_controller.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  _AppContainerState createState() {
    return _AppContainerState();
  }
}

class _AppContainerState extends State<AppContainer> {
  String _selected = Routes.home;

  ///Export index stack
  int _exportIndexed(String route) {
    switch (route) {
      case Routes.home:
        return 0;
      case Routes.wishList:
        return 1;
      case Routes.blog:
        return 2;
      case Routes.account:
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
      case Routes.home:
        iconData = Icons.home_outlined;
        title = 'home';
        break;
      case Routes.wishList:
        iconData = Icons.location_on_outlined;
        title = 'wish_list';
        break;
      case Routes.blog:
        iconData = Icons.bookmark_outline;
        title = 'blog';
        break;
      case Routes.account:
        iconData = Icons.account_circle_outlined;
        title = 'account';
        break;
      default:
        iconData = Icons.home_outlined;
        title = 'home';
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
        children: <Widget>[Home(), WishList(), Blog(), Account()],
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
                route: Routes.home,
              ),
              _buildMenuItem(
                route: Routes.wishList,
              ),
              const SizedBox(width: 56),
              _buildMenuItem(
                route: Routes.blog,
              ),
              _buildMenuItem(
                route: Routes.account,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          GetBuilder<PropertyController>(builder: (popularPropertiesData) {
        return FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            //popularPropertiesData.getAllProperties();
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
