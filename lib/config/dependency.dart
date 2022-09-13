import 'package:get/get.dart';
import 'package:m4uapp/api/madalali_api.dart';

import '../controller/controller.dart';
import '../data/datasource/impl.dart';
import '../repositories/repository.dart';

Future<void> init() async {
  Get.lazyPut(() => Api());

  //Repository
  Get.lazyPut<LocalRespositoryInterface>(() => LocalRepositoryImpl());
  Get.lazyPut(() => PropertyCategoryRepositoryImpl());
  Get.lazyPut(() => PropertyRepository());
  Get.lazyPut(() => BlogRepository());
  Get.lazyPut(() => AddPropertyRepository());
  Get.lazyPut(() => BlogCommentRepository());

  //Controllers
  Get.lazyPut(
      () => PropertyCategoryController(propertyCategoryRepository: Get.find()));
  Get.lazyPut(() => PropertyController(propertyRepository: Get.find()));
  Get.lazyPut(() => BlogController(blogRepository: Get.find()));
  Get.lazyPut(() => AddPropertyController(addPropertyRepository: Get.find()));
  Get.lazyPut(() => BlogCommentController(blogCommentRepository: Get.find()));
  Get.lazyPut(() => ThemeController(localRepositoryInterface: Get.find()));
}
