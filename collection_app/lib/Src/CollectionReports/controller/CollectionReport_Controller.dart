import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/PDFHelper.dart';
import '../../../utils/widgets/custom_snackbar.dart';
import '../../CustomerJoin/model/AreaModel.dart';
import '../model/Chit_Collection_Report_Model.dart';
import '../model/Credit_Collection_Report_Model.dart';
import '../repo/CollectionReport_Repo.dart';


class CollectionreportController extends GetxController implements GetxService {
  final CollectionreportRepo collectionreportRepo;

  CollectionreportController({required this.collectionreportRepo});

  CreditCollectionReportModel? creditCollectionReportModel;
  ChitCollectionReportModel? chitCollectionReportModel;
  AreaModel? areaModel;
  final RxBool isLoading = false.obs;
  final RxBool isAreaLoading = true.obs;
  final Rx<DateTime> fromDate = DateTime.now().obs;
  final Rx<DateTime> toDate = DateTime.now().obs;
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  final RxInt selectedAreaId = 0.obs;
  final RxString selectedAreaName = 'All Branches'.obs;

  @override
  void onInit() {
    super.onInit();
    initializePage();
  }

  // Initialize theee page
  Future<void> initializePage() async {
    clearAllData();
    initializeDates();
    await loadAreas();
  }

  // Clear all data when entering the page
  void clearAllData() {
    selectedAreaId.value = 0;
    selectedAreaName.value = 'All Areas';
  }

  void initializeDates() {
    fromDate.value = DateTime.now();
    toDate.value = DateTime.now();
    fromDateController.text = dateFormat.format(fromDate.value);
    toDateController.text = dateFormat.format(toDate.value);
  }

  final currencyFormatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  void updateFromDate(DateTime date) {
    fromDate.value = date;
    fromDateController.text = dateFormat.format(date);
    if (fromDate.value.isAfter(toDate.value)) {
      toDate.value = fromDate.value;
      toDateController.text = dateFormat.format(toDate.value);
    }
  }

  void updateToDate(DateTime date) {
    toDate.value = date;
    toDateController.text = dateFormat.format(date);
    if (toDate.value.isBefore(fromDate.value)) {
      fromDate.value = toDate.value;
      fromDateController.text = dateFormat.format(fromDate.value);
    }
  }

  Future<void> loadAreas() async {
    try {
      isAreaLoading.value = true;
      final Response? response = await collectionreportRepo.getAreaList();
      if (response != null && response.statusCode == 200) {
        areaModel = AreaModel.fromJson(response.body);
        if (areaModel?.data != null && areaModel!.data!.isNotEmpty) {
          selectedAreaId.value = areaModel!.data!.first.areaId ?? 0;
          selectedAreaName.value =
              areaModel!.data!.first.areaName ?? 'All Areas';
        }
      } else {
        customSnackBar('Failed to load branches', isError: true);
      }
    } catch (e) {
      customSnackBar('Error loading branches: $e', isError: true);
    } finally {
      isAreaLoading.value = false;
    }
  }

  Future<void> loadReportList() async {
    try {
      isLoading.value = true;
      final int? areaIdToSend =
          selectedAreaId.value == 0 ? null : selectedAreaId.value;

      final Map<String, dynamic> requestBody = {
        "fromDate": dateFormat.format(fromDate.value),
        "toDate": dateFormat.format(toDate.value),
        "area_id": areaIdToSend,
        "customer_id": null
      };
      final Response? response =
          await collectionreportRepo.getCreditCollectionReport(requestBody);

      if (response != null && response.statusCode == 200) {
        creditCollectionReportModel =
            CreditCollectionReportModel.fromJson(response.body);
        update();
      } else {
        customSnackBar('Failed to load report', isError: true);
      }
    } catch (e) {
      customSnackBar('Error loading report: $e', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadChitCollectionReportList() async {
    try {
      isLoading.value = true;
      final int? areaIdToSend =
          selectedAreaId.value == 0 ? null : selectedAreaId.value;
      final Map<String, dynamic> requestBody = {
        "fromDate": dateFormat.format(fromDate.value),
        "toDate": dateFormat.format(toDate.value),
        "area_id": areaIdToSend,
        "customer_id": null
      };
      final Response? response =
          await collectionreportRepo.getChitCollectionReport(requestBody);

      if (response != null && response.statusCode == 200) {
        chitCollectionReportModel =
            ChitCollectionReportModel.fromJson(response.body);
        update();
      } else {
        customSnackBar('Failed to load report', isError: true);
      }
    } catch (e) {
      customSnackBar('Error loading report: $e', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> generateChitCollectionReportPdf(int paymentID) async {
    try {
      isLoading.value = true;

      final Response? response =
          await collectionreportRepo.generateChitCollectionReportPdf(
        paymentID,
      );

      if (response != null && response.statusCode == 200) {
        // Handle PDF generation success if needed
        PDFHelper.downloadAndSharePDF(response.body['pdf_url'] ?? "");
      } else {
        customSnackBar('Failed to generate PDF', isError: true);
      }
    } catch (e) {
      customSnackBar('Error generating PDF: $e', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fromDateController.dispose();
    toDateController.dispose();
    super.onClose();
  }
}
