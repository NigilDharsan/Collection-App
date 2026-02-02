import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/data/provider/client_api.dart';


class CollectionreportRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  CollectionreportRepo(
      {required this.apiClient, required this.sharedPreferences});

  Future<Response?> getCreditCollectionReport(Map<String, dynamic> body) async {
    return await apiClient.postData(
      AppConstants.getCreditCollectionReport,
      body,
    );
  }

  Future<Response?> getChitCollectionReport(Map<String, dynamic> body) async {
    return await apiClient.postData(
      AppConstants.getChitCollectionReport,
      body,
    );
  }

  Future<Response?> getAreaList() async {
    return await apiClient.getData(AppConstants.getActiveAreas);
  }

  Future<Response?> generateChitCollectionReportPdf(int paymentID) async {
    return await apiClient
        .getData("${AppConstants.getPaymentReceipt}$paymentID/?print_type=1");
  }
}
