import 'package:flutter/material.dart';

import '../../../classes/language_constant.dart';
import '../../../config/routes.dart';

class PopularHeader extends StatelessWidget {
  const PopularHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.trending_up,
          color: Theme.of(context).primaryColor,
          size: 25.0,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          translation(context).popular_header,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.propertiesRoute);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                translation(context).view_all,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
              ),
              Icon(
                Icons.play_arrow,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
