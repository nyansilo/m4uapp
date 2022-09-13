import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';
import '../../../models/model.dart';
import '../../../utils/utils.dart';
import 'blog_comment_item.dart';
import 'blog_message_composer.dart';

class BlogModelContent extends StatelessWidget {
  const BlogModelContent({
    Key? key,
    required this.blog,
  }) : super(key: key);

  final BlogModel? blog;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
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
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 10, top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Comments ${blog!.commentNumber}",
                      style: kTitleStyle,
                    ),
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: kBlue,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              BlogMessageComposer(blog: blog),
              Container(
                child: Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GetBuilder<BlogController>(builder: (controller) {
                        return BlogCommentItem(comment: blog!.comments![index]);
                      });
                    },
                    itemCount: blog!.comments!.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
