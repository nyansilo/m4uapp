import 'package:flutter/material.dart';
import 'package:m4uapp/models/property_model.dart';

import '../../../classes/language_constant.dart';
import '../../../config/config.dart';
import '../../widgets/widget.dart';
import 'home_recent_header.dart';

class HomeRecentProperties extends StatelessWidget {
  const HomeRecentProperties({Key? key, required this.recent})
      : super(key: key);
  final List<PropertyModel> recent;
  @override
  Widget build(BuildContext context) {
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
                  translation(context).what_happen,
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
