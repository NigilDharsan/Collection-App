import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/data/provider/client_api.dart';

class SchemeJoinRepo {
  final CollectionApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SchemeJoinRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> customerSearch(dynamic body) async {
    return await apiClient.postData(
      AppConstants.getMobileNUmberSearchUrl,
      body,
    );
  }

  Future<Response?> getSchemeList(dynamic body) async {
    return await apiClient.postData(
      AppConstants.getSchemeDrop,
      body,
    );
  }

  Future<Response?> getBranchList() async {
    return await apiClient.getData(AppConstants.getBranchListUrl);
  }

  Future<Response?> schemeCreate(dynamic body) async {
    return await apiClient.postData(
      AppConstants.getSchemeJoinCreate,
      body,
    );
  }
}
