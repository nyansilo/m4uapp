import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../classes/language_constant.dart';
import '../../../models/model.dart';
import '../../widgets/widget.dart';

class HomeCategoryItem extends StatelessWidget {
  final CategoryDisplayModel? item;
  final Function(CategoryDisplayModel)? onPressed;

  const HomeCategoryItem({
    Key? key,
    this.item,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return AppPlaceholder(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.21,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                width: 48,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.21,
      child: GestureDetector(
        onTap: () => onPressed!(item!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item!.backgroundColor,
              ),
              child: FaIcon(
                item!.icon,
                size: 25,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            if (item!.title == 'Apartment') ...[
              Text(
                translation(context).cat_apartment,
                overflow: TextOverflow.ellipsis,
                style:
                    Theme.of(context).textTheme.button!.copyWith(fontSize: 12),
              ),
            ] else if (item!.title == 'Land') ...[
              Text(
                translation(context).cat_land,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    Theme.of(context).textTheme.button!.copyWith(fontSize: 12),
              ),
            ] else if (item!.title == 'Commercial') ...[
              Text(
                translation(context).cat_commercial,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    Theme.of(context).textTheme.button!.copyWith(fontSize: 12),
              ),
            ] else ...[
              Text(
                translation(context).cat_vehicle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    Theme.of(context).textTheme.button!.copyWith(fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
