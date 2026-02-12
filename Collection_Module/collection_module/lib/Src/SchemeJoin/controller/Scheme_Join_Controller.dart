import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/Loader/loader_utils.dart';
import '../../auth/repository/auth_repo.dart';
import '../model/BranchModel.dart';
import '../model/Mobile_Number_List.dart';
import '../model/SchemeModel.dart';
import '../repo/Scheme_Join_Repo.dart';


class SchemeJoinController extends GetxController implements GetxService {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final SchemeJoinRepo schemeJoinRepo;

  SchemeJoinController({
    required this.schemeJoinRepo,
  });

  BranchModel? branchModel;
  MobileListModel? mobileListModel;
  SchemeModel? schemeModel;

  List<Data> searchResults = [];
  List<Data> mobileList = [];
  List<SchemeData> schemeList = [];

  int? selectedBranchId;
  String? selectedBranchName;

  int? selectedCustomerId;
  String? selectedCustomerName;
  String? selectedCustomerMobile;

  int? selectedSchemeId;
  String? selectedSchemeName;

  void searchMobile(String input) {
    if (input.length >= 5) {
      searchResults = mobileList
          .where((item) => (item.mobile ?? "").contains(input))
          .toList();
    } else {
      searchResults.clear();
    }
    update();
  }

  void clearSelection() {
    selectedCustomerId = null;
    selectedCustomerMobile = null;
    selectedCustomerName = null;
    update();
  }

  void clearOldSelection() {
    searchResults.clear();
    update();
  }

  void clearSchemeSelection() {
    selectedSchemeId = null;
    selectedSchemeName = null;
    schemeList.clear();
    update();
  }

  Future<void> getBranchList() async {
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    Response? response = await schemeJoinRepo.getBranchList();
    if (response != null && response.statusCode == 200) {
      branchModel = BranchModel.fromJson(response.body);
      if (branchModel?.data != null && branchModel!.data!.isNotEmpty) {
        selectedBranchId = branchModel?.data?[0].idBranch;
        selectedBranchName = branchModel?.data?[0].name;
      }
    } else {
      print('Failed to load branch list');
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
  }

  Future<void> customerList({String? mobNum, String? name}) async {
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
    final body = <String, dynamic>{"is_employee_wise_search": true};
    if (mobNum != null && mobNum.isNotEmpty) {
      body["mob_num"] = mobNum;
    } else if (name != null && name.isNotEmpty) {
      body["name"] = name;
    }
    Response? response = await schemeJoinRepo.customerSearch(body);
    if (response != null && response.statusCode == 200) {
      mobileListModel = MobileListModel.fromJson(response.body);
      mobileList = mobileListModel?.data ?? [];
      searchResults = mobileList;
      print('Loaded Mobiles: ${mobileList.length}');
    } else {
      searchResults = [];
      print('Invalid User: ${response?.body}');
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
  }

  Future<void> getSchemeList(int customerId) async {
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
    final body = {"customer_id": customerId};
    Response? response = await schemeJoinRepo.getSchemeList(body);
    if (response != null && response.statusCode == 200) {
      schemeModel = SchemeModel.fromJson(response.body);
      schemeList = schemeModel?.data ?? [];
      // Auto-select first scheme if available
      if (schemeList.isNotEmpty) {
        selectedSchemeId = schemeList[0].idAccScheme;
        selectedSchemeName = schemeList[0].schemeName;
      }
      print('Loaded Schemes: ${schemeList.length}');
    } else {
      schemeList = [];
      print('Failed to load schemes: ${response?.body}');
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
  }

  Future<void> createScheme({
    required String accountName,
    // String? refNo,
    required String startDate,
  }) async {
    final loginModel = await CollectionAuthRepo.getUserModel();

    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();

    final body = {
      "acc_scheme_id": selectedSchemeId,
      "account_name": accountName,
      "id_branch": selectedBranchId,
      "id_customer": selectedCustomerId,
      "ref_no": "",
      "refer_customer_id": null,
      "refer_employee_id": loginModel?.employee?.idEmployee,
      "scheme_acc_number": null,
      "start_date": startDate,
    };

    Response? response = await schemeJoinRepo.schemeCreate(body);

    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    if (response != null && response.statusCode == 201) {
      Get.snackbar(
        'Success',
        'Scheme created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed('/collectionDashboard');
    } else {
      Get.snackbar(
        'Error',
        response?.body['message'] ?? 'Failed to create scheme',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    }

    update();
  }
}
