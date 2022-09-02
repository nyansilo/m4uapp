import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../../../config/config.dart';
import '../../../models/model.dart';
import '../../../utils/utils.dart';
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
      Size size = MediaQuery.of(context).size;
      return Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
        height: size.height * 0.25,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Swiper(
            itemCount: item!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => _onPropertyDetail(context, item![index]),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: item![index].images!.isNotEmpty
                          ? item![index].images!.first.imgUrl!
                          : '${Application.defaultImage}',
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
                    ),
                    Positioned(
                      top: 30,
                      left: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AppTag(
                              "${item![index].type}",
                              type: TagType.rate,
                            ),
                            const SizedBox(width: 4),
                            Text("Tsh ${item![index].price}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Theme.of(context).cardColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                            const SizedBox(width: 3),
                            item![index].type! == 'Rent'
                                ? const Text(
                                    '/ mo',
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        child: Text(
                          "${item![index].category!.title}",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Theme.of(context).cardColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            autoplay: true,
            autoplayDelay: 3000,
            autoplayDisableOnInteraction: false,
            pagination: const SwiperPagination(
                alignment: Alignment.bottomCenter,
                //builder: DotSwiperPaginationBuilder(
                //  color: Colors.white, activeColor: Colors.red)),
                builder: SwiperPagination.dots),
            // control: const SwiperControl(),
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

  void _onPropertyDetail(BuildContext context, PropertyModel item) {
    Navigator.pushNamed(context, Routes.propertyDetailRoute, arguments: item);
  }
}
