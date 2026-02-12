import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Src/Billing/controller/BillingController.dart';
import '../../../Src/Billing/controller/Dasboard_Controller.dart';
import '../../../Src/Billing/repository/BillingRepo.dart';
import '../../../Src/CollectionReports/controller/CollectionReport_Controller.dart';
import '../../../Src/CollectionReports/repo/CollectionReport_Repo.dart';
import '../../../Src/CustomerJoin/controller/Customer_Join_Controller.dart';
import '../../../Src/CustomerJoin/repo/Customer_Join_repo.dart';
import '../../../Src/Dashboard/controller/Collection_Dashboard_Controller.dart';
import '../../../Src/Dashboard/repo/Collection_Dashboard_repo.dart';
import '../../../Src/HandoverScreen/controller/Handover_Controller.dart';
import '../../../Src/HandoverScreen/repo/Handover_Repo.dart';
import '../../../Src/SchemeJoin/controller/Scheme_Join_Controller.dart';
import '../../../Src/SchemeJoin/controller/Scheme_Payment_Controller.dart';
import '../../../Src/SchemeJoin/repo/Scheme_Join_Repo.dart';
import '../../../Src/SchemeJoin/repo/Scheme_Payment_Repo.dart';
import '../../../Src/auth/controller/auth_controller.dart';
import '../../../Src/auth/repository/auth_repo.dart';
import '../../Loader/LoaderController.dart';
import '../../config.dart';
import '../../data/provider/client_api.dart';
import '../theme/controller/theme_controller.dart';

class InitialBinding extends Bindings {
  onInit() {
    initControllers();
  }

  @override
  void dependencies() async {
    //common controller
    Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));


    Get.lazyPut(() => AuthController(
        authRepo:
            AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find())));

    Get.lazyPut(() =>
        BillingController(billingRepo: BillingRepo(sharedPreferences: Get.find(),apiClient: Get.find())));



    Get.lazyPut(() => DashboardController(
        billingRepo: BillingRepo(
            sharedPreferences: Get.find(), apiClient: Get.find())));



    Get.lazyPut(() => CollectionDashboardController(
        collectionDashboardRepo: CollectionDashboardRepo(
            sharedPreferences: Get.find(), apiClient: Get.find())));

    Get.lazyPut(() => SchemeJoinController(
        schemeJoinRepo: SchemeJoinRepo(
            sharedPreferences: Get.find(), apiClient: Get.find())));

    Get.lazyPut(() => CustomerJoinController(
        customerJoinRepo: CustomerJoinRepo(
            sharedPreferences: Get.find(), apiClient: Get.find())));

    Get.lazyPut(() => SchemePaymentController(
        schemePaymentRepo: SchemePaymentRepo(
            sharedPreferences: Get.find(), apiClient: Get.find())));

    Get.lazyPut(() => CollectionreportController(
        collectionreportRepo: CollectionreportRepo(
            sharedPreferences: Get.find(), apiClient: Get.find())));

    Get.lazyPut(() => HandoverController(
        handoverRepo: HandoverRepo(
            sharedPreferences: Get.find(), apiClient: Get.find())));

  }
}

Future<void> initControllers() async {
  Get.put(LoaderController());
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPreferences); // Register it in GetX

  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));


  Get.lazyPut(() =>
      ApiClient(appBaseUrl: Config.baseUrl, sharedPreferences: Get.find()));
}
