import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/config.dart';
import '../../../controller/controller.dart';
import '../../../models/model.dart';
import 'property_list_item.dart';

class PropertiesListWidget extends StatelessWidget {
  final List<PropertyModel>? properties;
  PropertiesListWidget({this.properties});

  @override
  Widget build(BuildContext context) {
    //var controller = Get.find<PropertyController>();
    // controller.updateCategoryId(category!.categoryId);
    //var properties = controller.categoryProperties;

    return properties!.isEmpty
        ? Container(child: const Center(child: Text('No property to display')))
        : Obx(
            () => ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              primary: false,
              itemCount: properties!.length,
              itemBuilder: (context, index) {
                return PropertyListItem(
                  property: properties![index],
                  onTap: () {
                    Navigator.pushNamed(context, Routes.propertyDetailRoute,
                        arguments: properties![index]);
                  },
                );
              },
            ),
          );
  }
}
