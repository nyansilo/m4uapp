import 'package:get/get.dart';
import 'package:m4uapp/api/madalali_api.dart';
import 'package:m4uapp/controller/property_category_controller.dart';

import '../controller/property_controller.dart';
import '../repositories/property_cateory_repository.dart';
import '../repositories/property_repository.dart';

Future<void> init() async {
  Get.lazyPut(()=>Api());


 
  Get.lazyPut(()=> PropertyCategoryRepositoryImpl());
  Get.lazyPut(()=> PropertyRepository());

  Get.lazyPut(()=> PropertyCategoryController(propertyCategoryRepository: Get.find()));
  Get.lazyPut(()=> PropertyController(propertyRepository: Get.find()));


}