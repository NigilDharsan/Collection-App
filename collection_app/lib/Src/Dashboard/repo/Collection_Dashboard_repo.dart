import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/data/provider/client_api.dart';

class CollectionDashboardRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  CollectionDashboardRepo(
      {required this.apiClient, required this.sharedPreferences});

  Future<Response?> getCollectionDashboard() async {
    return await apiClient.getData(AppConstants.getCollectionDashboardUrl);
  }

  Future<Response?> getAreaWisePendingCredits() async {
    return await apiClient.getData(AppConstants.getAreaWisePendingCredits);
  }

  Future<Response?> getAreaWisePendingChitDues() async {
    return await apiClient.getData(AppConstants.getAreaWiseChitDues);
  }

  Future<Response?> getAreaWisePendingCreditsDetails(
      int page, Map<String, dynamic> body) async {
    return await apiClient.postData(
        '${AppConstants.getAreaWisePendingCreditsDetails}?page=$page', body);
  }

  Future<Response?> getAreaWisePendingChitDueDetails(
      Map<String, dynamic> body) async {
    return await apiClient.postData(
        AppConstants.getAreaWisePendingChitDueDetails, body);
  }

  Future<Response?> getCustomerCreditDueList(Map<String, dynamic> body) async {
    return await apiClient.postData(
        AppConstants.getCustomerCreditDueList, body);
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

  Future<Response?> getCollectionSummary(Map<String, dynamic> body) async {
    return await apiClient.postData(AppConstants.getCollectionSummary, body);
  }

  Future<Response?> createCollectionCreate(Map<String, dynamic> body) async {
    return await apiClient.postData(
      AppConstants.getCreditCollectionCreate,
      body,
    );
  }
}
