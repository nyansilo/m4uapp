import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../../../models/model.dart';
import '../../widgets/widget.dart';

class HomeSwipe extends StatelessWidget {
  final double height;
  final List<PropertyModel>? item;

  const HomeSwipe({
    Key? key,
    required this.item,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item != null) {
      return Container(
        height: 300.0,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              imageUrl: item![index].images!.first.imgUrl!,
              placeholder: (context, url) {
                return AppPlaceholder(
                  child: Container(
                    color: Colors.white,
                  ),
                );
              },
              imageBuilder: (context, imageProvider) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return AppPlaceholder(
                  child: Container(
                    color: Colors.white,
                    child: const Icon(Icons.error),
                  ),
                );
              },
            );
          },
          autoplayDelay: 3000,
          autoplayDisableOnInteraction: false,
          autoplay: true,
          itemCount: item!.length,
          pagination: const SwiperPagination(
            alignment: Alignment(0.0, 0.4),
            builder: SwiperPagination.dots,
          ),
        ),
      );
    }

    ///Loading
    return Container(
      color: Theme.of(context).backgroundColor,
      child: AppPlaceholder(
        child: Container(
          margin: const EdgeInsets.only(bottom: 2),
          color: Colors.white,
        ),
      ),
    );
  }
}