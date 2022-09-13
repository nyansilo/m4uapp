import '../api/madalali_api.dart';
import '../models/model.dart';

class BlogCommentRepository {
  Future<List<BlogCommentModel>> loadAllCommentsByBlogId(int blogId) async {
    final response = await Api.requestAllCommentByBlogId(blogId: blogId);

    List temp = response.data['data'];

    List<BlogCommentModel> comments =
        temp.map((item) => BlogCommentModel.fromJson(item)).toList();

    return comments;
  }
}
