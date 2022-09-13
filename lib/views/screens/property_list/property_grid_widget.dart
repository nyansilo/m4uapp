import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../controller/controller.dart';
import '../../../models/model.dart';
import 'property_grid_item.dart';

class PropertiesGridWidget extends StatelessWidget {
  final List<PropertyModel>? properties;
  PropertiesGridWidget({this.properties});
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PropertyController>();
    //controller.updateCategoryId(category!.categoryId);
    //var properties = controller.categoryProperties;

    return properties!.isEmpty
        ? Container(child: const Center(child: Text('No property to display')))
        : Obx(
            () => GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              //crossAxisCount: 2,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 4,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(properties!.length, (index) {
                return PropertyGridItem(
                  property: properties![index],
                  onTap: () {
                    //Navigate to poste detail
                    Navigator.pushNamed(context, Routes.propertyDetailRoute,
                        arguments: properties![index]);
                    //If you use pushReplacementNamed, PostsService will be unregistered and
                    //You can not get it using Injector.get or ReactiveModel.get.
                    //If you want keep PostsService you have to reinject it. See not bellow.
                  },
                );
              }),
            ),
          );
  }
}
