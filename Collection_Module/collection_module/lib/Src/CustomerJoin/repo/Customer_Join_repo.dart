import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/data/provider/client_api.dart';


class CustomerJoinRepo {
  final CollectionApiClient apiClient;
  final SharedPreferences sharedPreferences;

  CustomerJoinRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> getCountryList() async {
    return await apiClient.getData(AppConstants.getCountry);
  }

  Future<Response?> getStateList() async {
    return await apiClient.getData(AppConstants.getState);
  }

  Future<Response?> getCityList() async {
    return await apiClient.getData(AppConstants.getCity);
  }

  Future<Response?> getAreaList() async {
    return await apiClient.getData(AppConstants.getActiveAreas);
  }

  Future<Response?> customerCreate(dynamic body) async {
    return await apiClient.postData(
      AppConstants.getCustomerCreate,
      body,
    );
  }
}
