import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../config/config.dart';
import '../../../models/model.dart';
import '../../../utils/utils.dart';

class PropertyGridItem extends StatelessWidget {
  final PropertyModel? property;
  final void Function()? onTap;
  PropertyGridItem({this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 200.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: property!.images!.isNotEmpty
                      ? CachedNetworkImageProvider(
                          property!.images!.first.imgUrl!)
                      : AssetImage(ImageString.defaultImage) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: kBlue,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        child:
                            Text("For ${property!.type!}", style: kRatingStyle),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Icon(
                      property!.isFavorite!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          property!.isFavorite! ? brandingColor : Colors.white,
                      // Icons.favorite_border,
                      // color: kWhite,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    property!.title!,
                    maxLines: 1,
                    style: kTitleStyle.copyWith(
                        fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    "Tsh ${property!.price}",
                    style: kTitleStyle.copyWith(color: kBlue),
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
