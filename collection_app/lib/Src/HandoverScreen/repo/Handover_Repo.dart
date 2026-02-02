import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/data/provider/client_api.dart';


class HandoverRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  HandoverRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> getModeWiseSummaryList(dynamic body) async {
    return await apiClient.postData(
      AppConstants.getModeWiseSummary,
      body,
    );
  }

  Future<Response?> getHandoverCollection(dynamic body) async {
    return await apiClient.postData(
      AppConstants.getHandoverCollection,
      body,
    );
  }


}
