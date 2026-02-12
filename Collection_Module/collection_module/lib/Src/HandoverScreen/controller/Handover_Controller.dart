import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/Loader/loader_utils.dart';
import '../../../utils/widgets/custom_snackbar.dart';
import '../model/HandoverCollectionModel.dart';
import '../model/ModeWIseSummaryModel.dart';
import '../repo/Handover_Repo.dart';


class HandoverController extends GetxController implements GetxService {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final HandoverRepo handoverRepo;

  HandoverController({
    required this.handoverRepo,
  });

  ModeWIseSummaryModel? modeWIseSummaryModel;
  HandoverCollectionModel? handoverCollectionModel;

  // Selected handover date
  DateTime? selectedHandoverDate;

  get AuthRepo => null;

  // Method to set handover date
  void setHandoverDate(DateTime date) {
    selectedHandoverDate = date;
    update();
  }

  Future<void> getModeWiseSummaryList() async {
    // Validate that date is selected
    if (selectedHandoverDate == null) {
      customSnackBar('Please select a date', isError: true);
      return;
    }

    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();

    final loginModel = await AuthRepo.getUserModel();

    // Use selected date instead of today's date
    final formattedDate =
        DateFormat('yyyy-MM-dd').format(selectedHandoverDate!);

    final body = {
      "collected_date": formattedDate,
      "employee_id": loginModel?.employee?.idEmployee
    };

    print('Fetching mode wise summary for date: $formattedDate');

    Response? response = await handoverRepo.getModeWiseSummaryList(body);

    if (response != null && response.statusCode == 200) {
      modeWIseSummaryModel = ModeWIseSummaryModel.fromJson(response.body);
      print(
          'Loaded mode wise summary: ${modeWIseSummaryModel?.data?.totalCollectedAmount}');
    } else {
      print('Failed to load mode wise: ${response?.statusCode}');
      print('Response body: ${response?.body}');
      customSnackBar(
        'Failed to load collection details',
        isError: true,
      );
    }

    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
  }

  Future<void> generateHandoverOTP() async {
    if (modeWIseSummaryModel?.data == null) {
      customSnackBar('No collection data available', isError: true);
      return;
    }

    if (selectedHandoverDate == null) {
      customSnackBar('Please select a handover date', isError: true);
      return;
    }

    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();

    final loginModel = await AuthRepo.getUserModel();
    final data = modeWIseSummaryModel!.data!;

    // Use selected date for handover request
    final formattedDate =
        DateFormat('yyyy-MM-dd').format(selectedHandoverDate!);

    final body = {
      "handover_req_date": formattedDate,
      "employee_id": loginModel?.employee?.idEmployee,
      "generate_otp": true,
      "collection_amount": data.totalCollectedAmount,
    };

    print('Generating handover OTP...');
    print('Body: $body');
    print('Selected handover date: $formattedDate');

    Response? response = await handoverRepo.getHandoverCollection(body);

    if (response != null && response.statusCode == 200) {
      handoverCollectionModel = HandoverCollectionModel.fromJson(response.body);

      // Update the main model with the generated OTP
      if (handoverCollectionModel?.data != null) {
        // Update isHandoverReq and handoverOtp in modeWIseSummaryModel
        modeWIseSummaryModel?.data?.isHandoverReq =
            handoverCollectionModel?.data?.isHandoverReq ?? true;
        modeWIseSummaryModel?.data?.handoverOtp =
            handoverCollectionModel?.data?.handoverOtp;

        print(
            'Handover OTP generated: ${handoverCollectionModel?.data?.handoverOtp}');
        customSnackBar(
          handoverCollectionModel?.message ??
              'Handover OTP generated successfully',
          isError: false,
        );
      }
    } else {
      print('Failed to generate handover OTP: ${response?.statusCode}');
      print('Response body: ${response?.body}');
      customSnackBar(
        response?.body['message'] ?? 'Failed to generate handover OTP',
        isError: true,
      );
    }

    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
  }

  @override
  void onClose() {
    // Reset selected date when controller is closed
    selectedHandoverDate = null;
    super.onClose();
  }
}
