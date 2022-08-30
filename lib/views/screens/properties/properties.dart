import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';
import '../../../models/model.dart';

import 'property_grid_widget.dart';
import 'property_list_widget.dart';

class AllProperties extends StatefulWidget {
  @override
  _AllPropertiesState createState() => _AllPropertiesState();
}

class _AllPropertiesState extends State<AllProperties> {
  String layout = 'grid';
  @override
  Widget build(BuildContext context) {
    final Color bgColor = Color(0xffF3F3F3);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        elevation: 0,
        //automaticallyImplyLeading: false,
        title: const Text(
          "All Properties",
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
              child: GetBuilder<PropertyController>(
                builder: (controller) {
                  //controller.catId.value = widget.category!.categoryId!;

                  var properties = controller.allProperties;

                  if (controller.isloading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return PropertiesListWidget(properties: properties);
                  }
                },
              ),
            ),
            Offstage(
              offstage: this.layout != 'grid',
              child: GetBuilder<PropertyController>(
                builder: (controller) {
                  var properties = controller.allProperties;

                  if (controller.isloading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return PropertiesGridWidget(properties: properties);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
