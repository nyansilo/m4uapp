import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/config.dart';
import '../../../controller/controller.dart';
import '../../../models/model.dart';
import '../../../utils/utils.dart';
import '../../widgets/widget.dart';

class PropertyDetail extends StatefulWidget {
  const PropertyDetail({Key? key, required this.property}) : super(key: key);

  //final int id;
  final PropertyModel property;

  @override
  _PropertyDetailState createState() {
    return _PropertyDetailState();
  }
}

class _PropertyDetailState extends State<PropertyDetail> {
  final _scrollController = ScrollController();

  Color? _iconColor = Colors.white;
  bool _showHour = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ///Handle icon theme
  void _onScroll() {
    Color? color;
    if (_scrollController.position.extentBefore < 110) {
      color = Colors.white;
    }
    if (color != _iconColor) {
      setState(() {
        _iconColor = color;
      });
    }
  }

  ///On navigate property detail
  void _onPropertyDetail(PropertyModel item) {
    Navigator.pushNamed(context, Routes.propertyDetailRoute, arguments: item);
  }

  ///On Preview Profile
  void _onProfile(UserModel user) {
    //Navigator.pushNamed(context, Routes.profile, arguments: user);
  }

  ///On navigate map
  void _onLocation(PropertyModel item) {
    //Navigator.pushNamed(
    //context,
    //Routes.location,
    //arguments: item.location,
    //);
  }

  ///On show message fail
  void _showMessage(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'explore_property',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            AppButton(
              'close',
              onPressed: () {
                Navigator.of(context).pop();
              },
              type: ButtonType.text,
            ),
          ],
        );
      },
    );
  }

  ///On Share
  void _onShare(PropertyModel item) {
    Share.share(
      //'Check out my item ${item.link}',
      'Check out my item whatsupp',
      subject: 'PassionUI',
    );
  }

  ///On navigate gallery
  void _onPhotoPreview(PropertyModel item) {
    if (item.images!.isEmpty) {
      _showMessage("galleries_empty");
    } else {
      Navigator.pushNamed(
        context,
        Routes.propertyGalleryRoute,
        arguments: item,
      );
    }
  }

  ///Phone action
  void _phoneAction(String phone) async {
    final result = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    Column(
                      children: [
                        AppListTitle(
                          title: 'WhatsApp',
                          leading: SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset(ImageString.whatsapp),
                          ),
                          onPressed: () {
                            Navigator.pop(context, "WhatsApp");
                          },
                        ),
                        AppListTitle(
                          title: 'Viber',
                          leading: SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset(ImageString.viber),
                          ),
                          onPressed: () {
                            Navigator.pop(context, "Viber");
                          },
                        ),
                        AppListTitle(
                          title: 'Telegram',
                          leading: SizedBox(
                            height: 32,
                            width: 32,
                            child: Image.asset(ImageString.telegram),
                          ),
                          onPressed: () {
                            Navigator.pop(context, "Telegram");
                          },
                          border: false,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    if (result != null) {
      String url = '';

      switch (result) {
        case "WhatsApp":
          if (Platform.isAndroid) {
            url = "whatsapp://wa.me/$phone";
          } else {
            url = "whatsapp://api.whatsapp.com/send?phone=$phone";
          }
          break;
        case "Viber":
          url = "viber://contact?number=$phone";
          break;
        case "Telegram":
          url = "tg://msg?to=$phone";
          break;
        default:
          break;
      }

      _makeAction(url);
    }
  }

  ///Make action
  void _makeAction(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showMessage('cannot_make_action');
    }
  }

  ///Build content UI
  Widget _buildContent(PropertyModel? property) {
    ///Build UI loading
    List<Widget> action = [];
    Widget background = AppPlaceholder(
      child: Container(
        color: Colors.white,
      ),
    );
    Widget phone = Container();

    Widget email = Container();
    ;
    Widget dateAndPrice = Container();
    Widget info = AppPlaceholder(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              height: 16,
              width: 150,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 16,
                      width: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 20,
                      width: 150,
                      color: Colors.white,
                    ),
                  ],
                ),
                Container(
                  height: 10,
                  width: 100,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 200,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 200,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 200,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 200,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 200,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 24),
            Container(height: 10, color: Colors.white),
            const SizedBox(height: 4),
            Container(height: 10, color: Colors.white),
            const SizedBox(height: 4),
            Container(height: 10, color: Colors.white),
            const SizedBox(height: 4),
            Container(height: 10, color: Colors.white),
            const SizedBox(height: 4),
            Container(height: 10, color: Colors.white),
            const SizedBox(height: 4),
            Container(height: 10, color: Colors.white),
          ],
        ),
      ),
    );
    Widget status = Container();
    Widget feature = AppPlaceholder(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 4),
            Container(height: 10, color: Colors.white),
            const SizedBox(height: 4),
            Container(height: 10, color: Colors.white),
            const SizedBox(height: 4),
            Container(height: 10, color: Colors.white),
            const SizedBox(height: 4),
            Container(height: 10, color: Colors.white),
            const SizedBox(height: 4),
            Container(height: 10, color: Colors.white),
          ],
        ),
      ),
    );
    Widget related = Container();

    ///UX change action color
    IconThemeData iconTheme = Theme.of(context).iconTheme;
    if (_iconColor != null) {
      iconTheme = Theme.of(context).iconTheme.copyWith(color: _iconColor);
    }

    /// Build Detail
    if (property != null) {
      if (property.type!.isNotEmpty) {
        status = AppTag(
          property.type!,
          type: TagType.status,
        );
      }

      ///we are passing the value of the property id to the controller
      //to be use on getRelatedPropertyByPropertyId(id) method
      var controller = Get.find<PropertyController>();
      controller.updatePropertyId(widget.property.id);
      var relatedList = controller.relatedProperties;

      if (relatedList.isNotEmpty) {
        feature = relatedList.isEmpty
            ? Container(
                child: const Center(child: Text('No property to display')))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Related',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        PropertyModel item =
                            controller.relatedProperties[index];
                        //final PropertyModel item = latest[index];
                        return Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: AppProductItem(
                            onPressed: () {
                              _onPropertyDetail(item);
                            },
                            item: item,
                            type: ProductViewType.grid,
                          ),
                        );
                      },
                      itemCount: relatedList.length,
                    ),
                  )
                ],
              );
      }

      ///BackgroundIcon
      Color? backgroundIcon;
      if (_iconColor == Colors.white) {
        backgroundIcon = Colors.grey.withOpacity(0.3);
      }

      ///Action
      action = [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundIcon,
          ),
          child: IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              _onShare(property);
            },
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundIcon,
          ),
          child: IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () {
              _onLocation(property);
            },
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundIcon,
          ),
          child: IconButton(
            icon: const Icon(Icons.photo_library_outlined),
            onPressed: () {
              _onPhotoPreview(property);
            },
          ),
        ),
        const SizedBox(width: 8),
      ];

      ///Background
      background = CachedNetworkImage(
        imageUrl: property.images!.isNotEmpty
            ? property.images!.first.imgUrl!
            : '${Application.defaultImage}',
        placeholder: (context, url) {
          return AppPlaceholder(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          );
        },
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
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
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Icon(Icons.error),
            ),
          );
        },
      );

      ///phone
      if (property.createdBy!.phoneNumber!.isNotEmpty) {
        phone = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                _phoneAction(property.createdBy!.phoneNumber!);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).dividerColor,
                    ),
                    child: const Icon(
                      Icons.phone_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'phone',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          property.createdBy!.phoneNumber!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }

      ///Email
      if (property.createdBy!.email!.isNotEmpty) {
        email = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                _makeAction('mailto:${property.createdBy!.email!}');
              },
              child: Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).dividerColor,
                    ),
                    child: const Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'email',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          property.createdBy!.email!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }

      ///Date and Price
      //Widget address = Container();
      //Widget phone = Container();
      // Widget email = Container();
      Widget dateEstablish = Container();
      Widget priceRange = Container();
      Widget booking = Container();
      if (property.createdAt!.isNotEmpty) {
        dateEstablish = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'date_established',
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 4),
            Text(
              property.createdAt!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        );
      }
      if (property.price!.toString().isNotEmpty) {
        priceRange = Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'price_range',
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 4),
            Text(
              "${property.price}",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        );
      }
      if (property.isBooking!) {
        booking = InkWell(
          onTap: () {}, //_onBooking,
          child: Container(
            height: 24,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
            child: Text(
              'book_now',
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        );
      }
      dateAndPrice = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              dateEstablish,
              priceRange,
            ],
          ),
        ],
      );

      ///Info
      info = Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    property.title!,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                booking,
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      property.category!.title!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: () {
                        //_onReview(property);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AppTag(
                            "${property.rate}",
                            type: TagType.rate,
                          ),
                          const SizedBox(width: 4),
                          RatingBar.builder(
                            initialRating: property.rate!,
                            unratedColor: Colors.amber.withAlpha(100),
                            itemCount: 5,
                            itemSize: 14.0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rate) {},
                            ignoreGestures: true,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(${property.numRate})",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                IconButton(
                  icon: Icon(
                    property.isFavorite!
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                  //onPressed: _onFavorite,
                ),
              ],
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                //_makeAction(
                //'https://www.google.com/maps/search/?api=1&query=${property.location!.latitude},${property.location!.longitude}',
                //);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).dividerColor,
                    ),
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'address',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          property.address!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            phone,
            email,
            const SizedBox(height: 16),
            Text(
              property.description!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    height: 1.3,
                  ),
            ),
            dateAndPrice,
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'facilities',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                /*Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: property.features.map((item) {
                    return IntrinsicWidth(
                      child: AppTag(
                        item.title,
                        type: TagType.chip,
                        icon: Icon(
                          item.icon,
                          size: 10,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    );
                  }).toList(),
                ),*/
                const SizedBox(height: 8),
              ],
            )
          ],
        ),
      );
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          pinned: true,
          actions: action,
          iconTheme: iconTheme,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.none,
            background: background,
          ),
        ),
        SliverToBoxAdapter(
          child: SafeArea(
            top: false,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppUserInfo(
                        user: property?.createdBy,
                        type: UserViewType.basic,
                        onPressed: () {
                          //_onProfile(property!.author!);
                        },
                      ),
                      status
                    ],
                  ),
                ),
                info,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Divider(),
                ),
                feature,
                const SizedBox(height: 8),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //PropertyModel? property  = Get.find<PropertyController>().popularProperties[widget.id];

    return Scaffold(
      body: _buildContent(widget.property),
    );
  }
}
