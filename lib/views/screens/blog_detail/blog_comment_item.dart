import 'package:flutter/material.dart';

import '../../../models/model.dart';
import '../../../utils/utils.dart';
import '../../widgets/widget.dart';

class BlogCommentItem extends StatelessWidget {
  final BlogCommentModel? comment;
  final bool? isFirst;

  BlogCommentItem({this.comment, this.isFirst});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          const Divider(height: 15.0),
          ListTile(
            leading: CircleAvatar(
              radius: 24.0,
              backgroundImage: AssetImage(ImageString.defaultImage),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                children: <Widget>[
                  Text(comment!.authorName),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    comment!.createdAt,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            subtitle: comment!.commentBody.length >= 50
                ? ExpandableText(comment!.commentBody)
                : Text(comment!.commentBody),
          ),
          const SizedBox(height: 5.0),
          comment!.id == 1 && isFirst == true
              ? const SizedBox.shrink()
              : Container(
                  padding:
                      const EdgeInsets.only(left: 81, right: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.thumb_up,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "5",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Icon(
                            Icons.thumb_down,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.more_vert,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
