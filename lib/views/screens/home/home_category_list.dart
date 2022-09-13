import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../controller/controller.dart';
import '../../../models/model.dart';
import 'home_category_item.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

void _onTapCategoryItem(CategoryDisplayModel item, BuildContext context) {
  Navigator.pushNamed(context, Routes.propertyListRoute, arguments: item);
}
