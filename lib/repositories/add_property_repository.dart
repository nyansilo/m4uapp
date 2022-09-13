import '../api/madalali_api.dart';
import '../models/model.dart';

class AddPropertyRepository {
  Future<List<PropertyRegionModel>> loadAllRegions() async {
    final response = await Api.requestAllRegions();
    List temp = response.data['regions'];
    List<PropertyRegionModel> allRegions =
        temp.map((item) => PropertyRegionModel.fromJson(item)).toList();
    return allRegions;
  }

  Future<List<PropertyDistrictModel>> loadDistrictByRegionId(
      int regionId) async {
    final response = await Api.requestDistrictByRegionId(regionId: regionId);
    List temp = response.data['cities'];
    List<PropertyDistrictModel> districtByRegion =
        temp.map((item) => PropertyDistrictModel.fromJson(item)).toList();
    //print('im print districts: ${districtByRegion}');
    return districtByRegion;
  }
}
