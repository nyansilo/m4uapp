import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m4uapp/config/application.dart';

import '../../../config/config.dart';
import '../../../controller/controller.dart';
import '../../../models/model.dart';
import '../../../utils/utils.dart';
import '../../widgets/widget.dart';
import 'Blog_modal_content.dart';
import 'blog_ first_comment.dart';

class BlogDetail extends StatelessWidget {
  BlogDetail({this.blog});
  final BlogModel? blog;

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
    String imageUrl = blog!.image!;
    return Scaffold(
      backgroundColor: AppColor.scaffoldBGColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        /*leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        */
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        elevation: 0,
        title: Text('Detail', style: Theme.of(context).textTheme.headline6),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: Application.defaultImage,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          image: DecorationImage(
                            image: imageUrl != ""
                                ? CachedNetworkImageProvider(imageUrl)
                                : AssetImage(ImageString.defaultImage)
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    bottom: 20.0,
                    left: 20.0,
                    right: 20.0,
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.slideshow,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          blog!.category!.title,
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 8),
                      child: Text(
                        blog!.title!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.person),
                          const SizedBox(width: 5.0),
                          Text(
                              "${blog!.createdBy!.firstName} ${blog!.createdBy!.lastName}"),
                          const SizedBox(width: 16.0),
                          const Icon(Icons.timer),
                          const SizedBox(width: 5.0),
                          Text(blog!.createdAt!),
                          const SizedBox(width: 16.0),
                          const Icon(Icons.comment),
                          const SizedBox(width: 5.0),
                          Text(blog!.commentNumber.toString()),
                          const SizedBox(width: 16.0),
                          // BuildLikeButton(
                          //   blogId: blog.id,
                          // ),
                        ],
                      ),
                    ),
                    const Divider(),
                    blog!.description!.length >= 50
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: ExpandableText(
                              blog!.description!,
                              trimLines: 4,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Text(blog!.description!),
                          ),
                    const Divider(),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 10, top: 2),
                child: GestureDetector(
                  onTap: () {
                    return _onTapCcomment(blog!.comments!, context);
                  },
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
                          Icons.unfold_more,
                          color: kBlue,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlogFirstComment(
                blog: blog,
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}



// class BuildLikeButton extends StatelessWidget {
//   BuildLikeButton({
//     @required this.blogId,
//   });
//   final int blogId;

//   @override
//   Widget build(BuildContext context) {
//     //NOTE1: get reactiveModel of blogsService
//     //final blogsServiceRM = RM.get<blogsService>();
//     final blogStateRM = Injector.getAsReactive<BlogState>();

//     return Row(
//       children: <Widget>[
//         InkWell(
//           child: Icon(Icons.thumb_up),
//           onTap: () {
//             //NOTE3: incrementLikes is a synchronous method so we do not expect errors
//             blogStateRM.setState((state) => state.incrementLikes(blogId));
//           },
//         ),
//         SizedBox(width: 5),
//         StateBuilder(
//           observe: () => blogStateRM,
//           builder: (_, __) {
//             //NOTE2: Optimizing rebuild. Only Text is rebuild
//             return Text('${blogStateRM.state.getblogLikes(blogId)}');
//           },
//         ),
//       ],
//     );
//   }
// }



