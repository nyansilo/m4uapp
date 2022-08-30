import 'package:flutter/material.dart';
import 'package:circle_flags/circle_flags.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../../../config/routes.dart';
import '../../../controller/controller.dart';
import '../../../models/model.dart';
import '../../../utils/utils.dart';
import '../../widgets/widget.dart';

import 'home_category_item.dart';
import 'home_popular_header.dart';
import 'home_recent_header.dart';
import 'search_field.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  SliverPersistentHeader makeHeader(Widget header) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 50.0,
        maxHeight: 50.0,
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
            centerTitle: true,
            elevation: 0,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(),
                  ],
                ),
              ),
            ],
            //leading: IconButton(icon: const Icon(Icons.list), onPressed: () {}),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 35, maxWidth: 200),
                  child: const Text(
                    "Madalali4u",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'Quite Magica',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight - 10.0),
            child: SliverAppBar(
              elevation: 0.0,
              title: GestureDetector(
                onTap: (() => _onActionlanguage(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Icon(
                      Icons.language_outlined,
                      color: Colors.white,
                      size: 15.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'English',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    Spacer(),
                    Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ],
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              floating: false,
              centerTitle: false,
            ),
          ),
          makeHeader(
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              // All languages header
              height: 50.0,
              padding: const EdgeInsets.only(
                  bottom: 15.0, left: 15.0, right: 15.0, top: 0.0),
              child: SearchField(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              /*GetBuilder<PropertyController>(
                builder: (popularPropertiesData) {
                  var popular = popularPropertiesData.popularProperties;
                  return HomeSwipe(height: 300.0, item: popular);
                },
              ),*/
              _buildCategory(context),
              GetBuilder<PropertyController>(
                builder: (popularPropertiesData) {
                  var popular = popularPropertiesData.popularProperties;
                  return _buildPopular(context, popular);
                },
              ),
              GetBuilder<PropertyController>(
                builder: (recentPropertiesData) {
                  var recent = recentPropertiesData.recentProperties;
                  return _buildRecent(context, recent);
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }

  ///Build Category UI
  ///
  Widget _buildCategory(BuildContext context) {
    List<CategoryDisplayModel> categories = categoriesDisplayList;

    ///Loading
    Widget content = Wrap(
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: List.generate(4, (index) => index).map(
        (item) {
          return const HomeCategoryItem();
        },
      ).toList(),
    );

    content = Wrap(
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: categories.map(
        (item) {
          return HomeCategoryItem(
            item: item,
            onPressed: (item) {
              _onTapCategoryItem(item, context);
            },
          );
        },
      ).toList(),
    );

    return Container(
      padding: const EdgeInsets.all(15),
      child: content,
    );
  }

  ///Build list popular
  Widget _buildPopular(BuildContext context, List<PropertyModel> popular) {
    ///Loading
    final size = MediaQuery.of(context).size;
    final left = MediaQuery.of(context).padding.left;
    final right = MediaQuery.of(context).padding.right;
    const itemHeight = 220;
    final itemWidth = (size.width - 48 - left - right) / 2.8;
    //final itemWidth = MediaQuery.of(context).size.width * 1 / 2.1;
    final ratio = itemWidth / itemHeight;

    Widget content = GridView.count(
      //padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      crossAxisCount: 2,
      childAspectRatio: ratio,
      children: List.generate(8, (index) => index).map((item) {
        return Container(
          width: MediaQuery.of(context).size.width * 1 / 2.1,
          //padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const AppProductItem(
            type: ProductViewType.grid,
          ),
        );
      }).toList(),
    );

    if (popular.isNotEmpty) {
      ///On navigate property detail
      void _onPropertyDetail(PropertyModel item) {
        Navigator.pushNamed(context, Routes.propertyDetailRoute,
            arguments: item);
      }

      content = ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        itemBuilder: (context, index) {
          final item = popular[index];
          return Container(
            width: MediaQuery.of(context).size.width * 1 / 2.1,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AppProductItem(
              onPressed: () {
                _onPropertyDetail(item);
              },
              item: item,
              type: ProductViewType.grid,
            ),
          );
        },
        itemCount: popular.length,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const PopularHeader(),
              const SizedBox(height: 2),
              Text(
                'let_find_interesting',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        Container(
          height: 220,
          padding: const EdgeInsets.only(top: 4),
          child: content,
        ),
      ],
    );
  }

  ///Build list recent
  Widget _buildRecent(BuildContext context, List<PropertyModel> recent) {
    ///Loading
    Widget content = ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: AppProductItem(type: ProductViewType.small),
        );
      },
      itemCount: 8,
    );

    if (recent.isNotEmpty) {
      void _onPropertyDetail(PropertyModel item) {
        Navigator.pushNamed(context, Routes.propertyDetailRoute,
            arguments: item);
      }

      content = ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = recent[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppProductItem(
              onPressed: () {
                _onPropertyDetail(item);
              },
              item: item,
              type: ProductViewType.small,
            ),
          );
        },
        itemCount: recent.length,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const RecentHeader(),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'what_happen',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: content,
        ),
      ],
    );
  }
}

///Action OnActionLang
void _onActionlanguage(BuildContext context) async {
  final result = await showModalBottomSheet<String?>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      Widget bookingItem = Container();

      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: IntrinsicHeight(
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
                  Column(
                    children: [
                      bookingItem,
                      AppListTitle(
                        title: 'English',
                        leading: CircleFlag(
                          CountryCode.usa,
                          size: 25,
                        ),
                        onPressed: () {
                          //Navigator.pop(context, "remove");
                        },
                      ),
                      AppListTitle(
                        title: 'Swahili',
                        leading: CircleFlag(
                          CountryCode.tanzania,
                          size: 25,
                        ),
                        onPressed: () {
                          //Navigator.pop(context, "remove");
                        },
                      ),
                      AppListTitle(
                        title: "Chinese",
                        leading: CircleFlag(
                          CountryCode.china,
                          size: 25,
                        ),
                        onPressed: () {
                          //Navigator.pop(context, "share");
                        },
                        border: false,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void _onTapCategoryItem(CategoryDisplayModel item, BuildContext context) {
  Navigator.pushNamed(context, Routes.propertyListRoute, arguments: item);
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
