import 'package:get/get.dart';

import '../models/model.dart';
import '../repositories/repository.dart';
import '../repositories/repository.dart';

class BlogController extends GetxController {
  @override
  void onInit() {
    getAllBlogs();
    super.onInit();
  }

  var isloading = true;

  final BlogRepository blogRepository;

  BlogController({required this.blogRepository});

  List<BlogModel> _allBlogs = [];
  List<BlogModel> get allBlogs => [..._allBlogs];

  Future getAllBlogs() async {
    _allBlogs = await blogRepository.loadAllBlogs();
    isloading = false;

    update();
  }
}
