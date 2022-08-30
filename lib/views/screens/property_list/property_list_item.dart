import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../../models/model.dart';
import '../../../utils/utils.dart';
import 'property_list_image.dart';

class PropertyListItem extends StatelessWidget {
  final PropertyModel? property;
  final void Function()? onTap;
  PropertyListItem({this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.0,
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 90.0,
            height: 95.0,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 12.0,
                  bottom: 12.0,
                  child: PropertyListImageDisplay(
                      property: property, onTap: onTap),
                ),
                Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: Card(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: kBlue,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(property!.type!, style: kRatingStyle)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(property!.title!, style: kTitleStyle, maxLines: 1),
                  Text('${property!.district!.name} ${property!.region!.name}',
                      maxLines: 1, style: kSubtitleStyle),
                  const Spacer(),
                  Row(
                    children: <Widget>[
                      Text(
                        "\$ ${property!.price}",
                        style: kTitleStyle.copyWith(color: kBlue),
                      ),
                      const Spacer(),
                      Icon(
                        property!.isFavorite!
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: property!.isFavorite!
                            ? brandingColor
                            : brandingColor,
                        size: 20.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
