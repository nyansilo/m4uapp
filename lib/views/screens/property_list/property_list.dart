import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m4uapp/views/screens/category/category.dart';

import '../../../controller/controller.dart';
import '../../../models/model.dart';

import 'property_grid_widget.dart';
import 'property_list_widget.dart';

class PropertyList extends StatefulWidget {
  const PropertyList({Key? key, this.category}) : super(key: key);

  final CategoryDisplayModel? category;

  @override
  _PropertyListState createState() => _PropertyListState();
}

class _PropertyListState extends State<PropertyList> {
  // @override
  //void initState() {
  /// super.initState();
  //var controller = Get.find<PropertyController>();
  //controller.updateCategoryId(widget.category!.categoryId);
  //controller.categoryProperties;
  //}

  String layout = 'grid';
  @override
  Widget build(BuildContext context) {
    final Color bgColor = Color(0xffF3F3F3);

    var controller = Get.find<PropertyController>();
    controller.updateCategoryId(widget.category!.categoryId);
    var properties = controller.categoryProperties;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        elevation: 0,
        //automaticallyImplyLeading: false,
        title: Text(
          "${widget.category!.title} Properties",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.view_day,
                  color: Theme.of(context).hintColor,
                ),
                title: const Text(
                  "All Properies",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          this.layout = 'list';
                        });
                      },
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: this.layout == 'list'
                            ? Theme.of(context).accentColor
                            : Theme.of(context).focusColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          this.layout = 'grid';
                        });
                      },
                      icon: Icon(
                        Icons.apps,
                        color: this.layout == 'grid'
                            ? Theme.of(context).accentColor
                            : Theme.of(context).focusColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Offstage(
              offstage: this.layout != 'list',

              //controller.catId.value = widget.category!.categoryId!;

              //controller.updateCategoryId(widget.category!.categoryId!);

              //var properties = controller.categoryProperties;

              child: controller.isloading
                  ? const Center(child: CircularProgressIndicator())
                  : PropertiesListWidget(properties: properties),
            ),
            Offstage(
              offstage: this.layout != 'grid',

              //we are passing the value of the category id to the controller
              //to be use on getPropertiesByCategoryId(id) method

              //controller.updateCategoryId(widget.category!.categoryId!);

              //controller.catId.value = widget.category!.categoryId!;

              //var properties = controller.categoryProperties;

              child: controller.isloading
                  ? const Center(child: CircularProgressIndicator())
                  : PropertiesGridWidget(properties: properties),
            ),
          ],
        ),
      ),
    );
  }
}
