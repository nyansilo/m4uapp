import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';
import '../../../models/model.dart';
import '../../../utils/utils.dart';
import 'Blog_modal_content.dart';
import 'blog_comment_item.dart';
import 'blog_message_composer.dart';

class BlogFirstComment extends StatelessWidget {
  final BlogModel? blog;

  BlogFirstComment({this.blog});

  _onTapCcomment(List<BlogCommentModel> comments, BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return BlogModelContent(blog: blog);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //var controller = Get.find<BlogCommentController>();
    //controller.updateBlogId(blogId);
    //var comments = controller.blogComments;

    return blog!.comments!.isNotEmpty
        ? GestureDetector(
            onTap: () {
              return _onTapCcomment(blog!.comments!, context);
            },
            child: BlogCommentItem(comment: blog!.comments![0], isFirst: true),
          )
        : Container(child: Center(child: Text('No Comment to Display')));
  }
}
