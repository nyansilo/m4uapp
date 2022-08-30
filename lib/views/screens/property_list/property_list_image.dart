import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../config/config.dart';
import '../../../models/model.dart';
import '../../../utils/utils.dart';

class PropertyListImageDisplay extends StatelessWidget {
  PropertyListImageDisplay({this.property, this.onTap});
  final PropertyModel? property;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        //imageUrl: "http://via.placeholder.com/200x150",
        imageUrl: '${Application.defaultImage}',
        imageBuilder: (context, imageProvider) => ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(property!.images!.isNotEmpty
                    ? property!.images!.first.imgUrl!
                    : '${Application.defaultImage}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
