import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m4uapp/utils/image_string.dart';

import '../../../config/branding_color.dart';
import '../../../config/config.dart';
import '../../../controller/controller.dart';
import '../../../models/model.dart';

class Blogs extends StatefulWidget {
  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Color(0xffF3F3F3);

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            "Blog",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlogPostList());
  }
}

class BlogPostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 10.0),
        height: MediaQuery.of(context).size.height,
        child: GetBuilder<BlogController>(builder: (controller) {
          var blogs = controller.allBlogs;

          if (controller.isloading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: blogs.length,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) => PostListItem(
                blog: blogs[index],
                onTap: () {
                  //Navigate to poste detail
                  //Navigator.pushNamed(context, blogDetailRoute,
                  //arguments: blogs[index]);
                  //If you use pushReplacementNamed, PostsService will be unregistered and
                  //You can not get it using Injector.get or ReactiveModel.get.
                  //If you want keep PostsService you have to reinject it. See not bellow.
                },
              ),

              // padding: const EdgeInsets.only(left: 10, right: 10),
              // itemCount: orderData.posts.length,
              // itemBuilder: (ctx, i) => ProductItem(orderData.posts[i]),
            );
          }
        }),
      ),
    );
  }
}

class PostListItem extends StatelessWidget {
  final BlogModel? blog;
  final void Function()? onTap;
  const PostListItem({this.blog, this.onTap});
  @override
  Widget build(BuildContext context) {
    var titleTextStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  BlogImageDisplay(imageUrl: blog!.image),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      blog!.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: titleTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          blog!.createdAt!,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                        Spacer(),
                        Text(
                          blog!.category!.title,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
              Positioned(
                top: 190,
                left: 20.0,
                child: Container(
                  //color: Colors.green,

                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: brandingColor,
                  ),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        "Posted By:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "${blog!.createdBy!.firstName} ${blog!.createdBy!.lastName}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BlogImageDisplay extends StatelessWidget {
  BlogImageDisplay({this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: CachedNetworkImage(
        imageUrl: '${Application.defaultImage}',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            image: DecorationImage(
              image: imageUrl!.isNotEmpty
                  ? CachedNetworkImageProvider(imageUrl!)
                  : AssetImage(ImageString.defaultImage) as ImageProvider,
              fit: BoxFit.cover,
              // colorFilter: ColorFilter.mode(
              //   Colors.red,
              //   BlendMode.colorBurn,
              // ),
            ),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
