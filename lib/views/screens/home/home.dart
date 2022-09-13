import 'package:flutter/material.dart';
import 'package:circle_flags/circle_flags.dart';
import 'package:get/get.dart';
import 'package:m4uapp/views/screens/home/home_category_list.dart';
import 'package:m4uapp/views/screens/home/home_recent_properties.dart';
import 'dart:math' as math;

import '../../../app.dart';
import '../../../classes/language.dart';
import '../../../classes/language_constant.dart';
import '../../../config/routes.dart';
import '../../../controller/controller.dart';
import '../../../controller/language_controller.dart';
import '../../../models/model.dart';
import '../../../utils/utils.dart';
import '../../widgets/widget.dart';

import 'home_category_item.dart';
import 'home_popular_header.dart';
import 'home_popular_properties.dart';
import 'home_recent_header.dart';
import 'home_swiper.dart';
import 'search_field.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LanguageController langController = Get.put(LanguageController());

  //Action OnActionLang
  void _onActionlanguage(BuildContext context) async {
    var _listLanguage = Language.languageList();

    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.25,
            ),
            child: Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Widget? trailing;
                          final selected = langController.languageName;
                          final item = _listLanguage[index];
                          if (item.name == selected) {
                            trailing = Icon(
                              Icons.check,
                              color: Theme.of(context).primaryColor,
                            );
                          }

                          return AppListTitle(
                            isButton: false,
                            title: item.name,
                            trailing: trailing,
                            onPressed: () async {
                              if (item.toString().isNotEmpty) {
                                Locale locale =
                                    await setLocale(item.languageCode);
                                App.setLocale(context, locale);
                              }
                              langController.updateLanguageName(item.name);
                              Navigator.pop(context);
                            },
                            border: index != 2,
                            leading: CircleFlag(
                              item.countryCode,
                              size: 25,
                            ),
                          );
                        },
                        itemCount: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  SliverPersistentHeader makeHeader(Widget header) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 55.0,
        maxHeight: 55.0,
        child: Container(
          color: Colors.transparent,
          child: header,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          /*actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<Language>(
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  onChanged: (Language? language) async {
                    if (language != null) {
                      Locale locale = await setLocale(language.languageCode);
                      App.setLocale(context, locale);
                    }
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize: 30),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],*/
          //leading: IconButton(icon: const Icon(Icons.list), onPressed: () {}),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 35, maxWidth: 200),
                child: Text(
                  translation(context).home_title,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    //fontFamily: 'Merriweather',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: <Widget>[
          PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight - 10.0),
            child: SliverAppBar(
              elevation: 0.0,
              title: GestureDetector(
                onTap: (() => _onActionlanguage(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.language_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 15.0,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Obx(
                      () => Text(
                        langController.languageName,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).primaryColor,
                      size: 25.0,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.notifications,
                      color: Theme.of(context).primaryColor,
                      size: 25.0,
                    ),
                  ],
                ),
              ),
              //backgroundColor: Theme.of(context).primaryColor,
              floating: false,
              centerTitle: false,
            ),
          ),
          makeHeader(
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              // All languages header
              height: 55.0,

              child: SearchField(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SafeArea(
                  top: false,
                  bottom: false,
                  child: Column(
                    children: [
                      GetBuilder<PropertyController>(
                        builder: (featuredPropertiesData) {
                          var featured =
                              featuredPropertiesData.popularProperties;

                          return HomeSwipe(height: 300.0, item: featured);
                        },
                      ),
                      //Build Categories
                      const HomeCategoryList(),
                      //Build popular properties
                      GetBuilder<PropertyController>(
                        builder: (popularPropertiesData) {
                          var popular = popularPropertiesData.popularProperties;
                          return HomePopularProperties(popular: popular);
                        },
                      ),
                      //Build recent properties
                      GetBuilder<PropertyController>(
                        builder: (recentPropertiesData) {
                          var recent = recentPropertiesData.recentProperties;
                          return HomeRecentProperties(recent: recent);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
