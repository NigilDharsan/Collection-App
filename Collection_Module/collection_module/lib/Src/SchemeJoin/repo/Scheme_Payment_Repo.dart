import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/data/provider/client_api.dart';

class SchemePaymentRepo {
  final CollectionApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SchemePaymentRepo({required this.apiClient, required this.sharedPreferences});

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

  Future<Response?> getCustomerAccounts(dynamic body) async {
    return await apiClient.postData(
      AppConstants.getCustomerAccounts,
      body,
    );
  }

  Future<Response?> getBranchList() async {
    return await apiClient.getData(AppConstants.getBranchListUrl);
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

  Future<Response?> createPayment(dynamic body) async {
    return await apiClient.postData(
      AppConstants.getSchemePayment,
      body,
    );
  }
}
