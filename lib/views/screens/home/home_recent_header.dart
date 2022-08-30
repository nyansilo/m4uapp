import 'package:flutter/material.dart';

import '../../../config/config.dart';

class RecentHeader extends StatelessWidget {
  const RecentHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.view_day,
          color: Theme.of(context).primaryColor,
          size: 25.0,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          'Recent_location',
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
                'view_all',
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
