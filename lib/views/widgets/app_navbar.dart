import 'package:flutter/material.dart';

import '../../models/model.dart';

enum PageType { map, list }

class AppNavBar extends StatelessWidget {
  final PageType pageStyle;
  final SortModel? currentSort;
  final VoidCallback? onChangeSort;
  final VoidCallback onChangeView;
  final VoidCallback? onFilter;
  final IconData? iconModeView;

  const AppNavBar({
    Key? key,
    this.pageStyle = PageType.list,
    this.currentSort,
    this.onChangeSort,
    //required this.iconModeView,
    this.iconModeView,
    required this.onChangeView,
    this.onFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String sortTitle = 'sort';
    if (currentSort != null) {
      sortTitle = currentSort!.title;
    }
    return SafeArea(
      top: false,
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.swap_vert),
                onPressed: onChangeSort,
              ),
              Text(
                sortTitle,
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(iconModeView),
                    onPressed: onChangeView,
                  ),
                  SizedBox(
                    height: 24,
                    child: VerticalDivider(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.track_changes),
                onPressed: onFilter,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Text(
                  'filter',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
