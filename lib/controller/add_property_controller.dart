import 'package:get/get.dart';

import '../models/model.dart';
import '../repositories/repository.dart';
import '../repositories/repository.dart';

class AddPropertyController extends GetxController {
  @override
  void onInit() {
    getAllRegions();
    super.onInit();
  }

  var isloading = true;
  var regionId = 1.obs;

  final AddPropertyRepository addPropertyRepository;

  AddPropertyController({required this.addPropertyRepository});

  updateRegionId(var postID) async {
    regionId.value = postID;

    //print('im print ${regionId.value}');
    await getDistrictByRegionId(postID);
  }

  List<PropertyDistrictModel> _relatedDistricts = [];
  List<PropertyDistrictModel> get relatedDistricts => [..._relatedDistricts];
  //Get Related Properties by propertyId
  Future getDistrictByRegionId(int regionId) async {
    print('District by region has been called');
    _relatedDistricts =
        await addPropertyRepository.loadDistrictByRegionId(regionId);
    print('District: ${_relatedDistricts}');
    isloading = false;
    update();
  }

  List<PropertyRegionModel> _allRegions = [];
  List<PropertyRegionModel> get allRegions => [..._allRegions];

  Future getAllRegions() async {
    _allRegions = await addPropertyRepository.loadAllRegions();
    isloading = false;

    update();
  }
}
