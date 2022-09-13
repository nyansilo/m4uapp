import 'package:get/get.dart';

import '../models/model.dart';
import '../repositories/repository.dart';

class BlogCommentController extends GetxController {
  BlogCommentController({
    required this.blogCommentRepository,
  });
  final BlogCommentRepository blogCommentRepository;

  final RxList<BlogCommentModel> _blogComments =
      List<BlogCommentModel>.empty(growable: true).obs;

  RxBool isProductLoading = false.obs;
  var isloading = true;
  var blogId = 0.obs;

  updateBlogId(var postID) async {
    blogId.value = postID;
    //print('im print ${catId.value}');
    await getCommentsByBlogId(postID);
  }

  //List<PropertyModel> _categoryProperties = [];
  //List<PropertyModel> get categoryProperties => [..._categoryProperties];
  RxList<BlogCommentModel> get blogComments => _blogComments;
  //Get Properties by CategoryId
  Future getCommentsByBlogId(int blogId) async {
    final blogCommentsList =
        await blogCommentRepository.loadAllCommentsByBlogId(blogId);
    _blogComments.assignAll(blogCommentsList);
    isloading = false;
    //update();
  }

  @override
  void onInit() {
    getCommentsByBlogId(blogId.value);
    super.onInit();
  }
}
