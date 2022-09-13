import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m4uapp/utils/image_string.dart';

import '../../../utils/branding_color.dart';
import '../../../config/config.dart';
import '../../../controller/controller.dart';
import '../../../models/model.dart';
import '../../../utils/utils.dart';

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
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          //backgroundColor: AppColor.whiteColor,
          centerTitle: true,
          elevation: 0,
          title: Text('Blog', style: Theme.of(context).textTheme.headline6),
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
                  Navigator.pushNamed(context, Routes.blogDetailRoute,
                      arguments: blogs[index]);
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
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                        Spacer(),
                        Text(
                          blog!.category!.title,
                          style: const TextStyle(
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
                      const SizedBox(width: 5.0),
                      Text(
                        "${blog!.createdBy!.firstName} ${blog!.createdBy!.lastName}",
                        style: const TextStyle(
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
