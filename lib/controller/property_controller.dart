import 'package:get/get.dart';

import '../models/model.dart';
import '../repositories/repository.dart';

class PropertyController extends GetxController {
  @override
  void onInit() {
    getFeaturedProperties();
    getPopularProperties();
    getRecentProperties();
    getAllProperties();
    super.onInit();
  }

  var isloading = true;

  var catId = 0.obs;
  var propertyId = 0.obs;

  final PropertyRepository propertyRepository;

  PropertyController({required this.propertyRepository});

  List<PropertyModel> _allProperties = [];
  List<PropertyModel> get allProperties => [..._allProperties];
  Future getAllProperties() async {
    _allProperties = await propertyRepository.loadAllProperties();
    isloading = false;
    print('popular: $_allProperties');
    update();
  }

  List<PropertyModel> _popularProperties = [];
  List<PropertyModel> get popularProperties => [..._popularProperties];

  //Get Pupolar Properties
  Future getPopularProperties() async {
    _popularProperties = await propertyRepository.loadPopularProperties();
    isloading = false;
    // print('popular: $_popularProperties');
    update();
  }

  List<PropertyModel> _recentProperties = [];
  List<PropertyModel> get recentProperties => [..._recentProperties];

  //Get Recent Properties
  Future getRecentProperties() async {
    _recentProperties = await propertyRepository.loadRecentProperties();
    update();
  }

  List<PropertyModel> _featuredProperties = [];
  List<PropertyModel> get featuredProperties => [..._featuredProperties];

  //Get Featured Properties
  Future getFeaturedProperties() async {
    _featuredProperties = await propertyRepository.loadFeaturedProperties();
    update();
  }

  updateCategoryId(var postID) async {
    catId.value = postID;
    //print('im print ${catId.value}');
    await getPropertyByCategoryId(postID);
  }

  //final RxList<PropertyModel> categoryProperties = <PropertyModel>[].obs;
  final RxList<PropertyModel> _categoryProperties =
      List<PropertyModel>.empty(growable: true).obs;

  RxBool isProductLoading = false.obs;
  //List<PropertyModel> _categoryProperties = [];
  //List<PropertyModel> get categoryProperties => [..._categoryProperties];
  RxList<PropertyModel> get categoryProperties => _categoryProperties;
  //Get Properties by CategoryId
  Future getPropertyByCategoryId(int catId) async {
    final categoryPropertiesList =
        await propertyRepository.loadPropertiesByCategoryId(catId);
    _categoryProperties.assignAll(categoryPropertiesList);
    isloading = false;
    //update();
  }

  updatePropertyId(var postID) async {
    propertyId.value = postID;
    print('im print ${propertyId.value}');
    await getRelatedPropertyByPropertyId(postID);
  }

  List<PropertyModel> _relatedProperties = [];
  List<PropertyModel> get relatedProperties => [..._relatedProperties];
  //Get Related Properties by propertyId
  Future getRelatedPropertyByPropertyId(int propertyId) async {
    _relatedProperties =
        await propertyRepository.loadRelatedPropertiesByPropertyId(propertyId);
    isloading = false;
    update();
  }
}
