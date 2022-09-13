import 'package:flutter/material.dart';

import '../../../classes/language_constant.dart';
import '../../../config/config.dart';
import '../../../models/model.dart';
import '../../widgets/widget.dart';
import 'home_popular_header.dart';

class HomePopularProperties extends StatelessWidget {
  const HomePopularProperties({Key? key, required this.popular})
      : super(key: key);

  final List<PropertyModel> popular;

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                translation(context).let_find_interesting,
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
}
