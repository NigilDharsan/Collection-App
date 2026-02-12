import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/data/provider/client_api.dart';


class BillingRepo {
  final CollectionApiClient apiClient;
  final SharedPreferences sharedPreferences;

  BillingRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response?> estDetails(Map<String, dynamic> body) async {
    return await apiClient.postData(
      AppConstants.getEstDetails,
      body,
    );
  }

  Future<Response?> getPaymentMode() async {
    return await apiClient.getData(AppConstants.getPaymentMode);
  }

  Future<Response?> getActiveBank() async {
    return await apiClient.getData(AppConstants.getActiveBank);
  }

  Future<Response?> getPayDevice() async {
    return await apiClient.getData(AppConstants.getActivePayDevice);
  }

  Future<Response?> calculateItemDetails(Map<String, dynamic> body) async {
    return await apiClient.postData(
      AppConstants.getBillingCalculateItemDetails,
      body,
    );
  }

  Future<Response?> getBillingList(int page, Map<String, dynamic> body) async {
    return await apiClient.postData(
        '${AppConstants.getBillingList}?page=$page', body);
  }

  Future<Response?> billingCreate(Map<String, dynamic> body) async {
    return await apiClient.postData(
      AppConstants.getBillingCreate,
      body,
    );
  }
}
