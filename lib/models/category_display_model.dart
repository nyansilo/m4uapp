import 'package:flutter/material.dart';


class CategoryDisplayModel {
  final int? categoryId;
  final Color? backgroundColor;
  final IconData? icon;
  final String? title;

  CategoryDisplayModel(
      {this.categoryId, this.backgroundColor, this.icon, this.title});
}

 final categoriesDisplayList = [
   CategoryDisplayModel(
     categoryId: 1,
     backgroundColor: Colors.pink,
     icon: Icons.local_hotel,
     title: "Apartment",
   ),
   CategoryDisplayModel(
     categoryId: 2,
     backgroundColor: Colors.blue,
     icon: Icons.landscape,
     title: "Land",
   ),
   CategoryDisplayModel(
     categoryId: 3,
     icon: Icons.local_convenience_store,
     backgroundColor: Colors.orange,
     title: "Commercial",
   ),
   CategoryDisplayModel(
     categoryId: 4,
     icon: Icons.local_shipping,
     backgroundColor: Colors.purple,
     title: "Vehicle",
   ),
 ];
