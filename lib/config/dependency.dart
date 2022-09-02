import 'package:get/get.dart';
import 'package:m4uapp/api/madalali_api.dart';

import '../controller/controller.dart';
import '../repositories/repository.dart';

Future<void> init() async {
  Get.lazyPut(() => Api());

  //Repository
  Get.lazyPut(() => PropertyCategoryRepositoryImpl());
  Get.lazyPut(() => PropertyRepository());
  Get.lazyPut(() => BlogRepository());

  //Controllers
  Get.lazyPut(
      () => PropertyCategoryController(propertyCategoryRepository: Get.find()));
  Get.lazyPut(() => PropertyController(propertyRepository: Get.find()));
  Get.lazyPut(() => BlogController(blogRepository: Get.find()));
}
