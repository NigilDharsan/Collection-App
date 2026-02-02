import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:collection_app/utils/Loader/loader_utils.dart';
import 'package:collection_app/utils/widgets/custom_snackbar.dart';

import '../../Billing/model/ActivebankModel.dart';
import '../../Billing/model/PayDeviceModel.dart';
import '../../Billing/model/PaymentModeModel.dart';
import '../../auth/repository/auth_repo.dart';
import '../Model/CollectionDashboardModel.dart';
import '../Model/CollectionSummaryModel.dart';
import '../Model/CustomerDueListModel.dart';
import '../Model/PendingChitDueDetailsModel.dart';
import '../Model/PendingChitDueModel.dart';
import '../Model/PendingCreditsDetails.dart';
import '../Model/PendingCreditsModel.dart';
import '../repo/Collection_Dashboard_repo.dart';





class CollectionDashboardController extends GetxController
    implements GetxService {
  final CollectionDashboardRepo collectionDashboardRepo;

  CollectionDashboardController({required this.collectionDashboardRepo});

  var isLoading = false.obs;

  final receivedAmountController = TextEditingController();
  final amountController = TextEditingController();
  final discountAmountController = TextEditingController();

  final FocusNode discountAmountFocusNode = FocusNode();

  PendingCreditsModel? pendingCreditsModel;
  PendingChitDueModel? pendingChitDueModel;
  PendingCreditsDetails? pendingCreditsDetailsModel;
  PendingChitDueDetailsModel? pendingChitDueDetailsModel;
  CustomerDueListModel? customerDueListModel;
  CollectionSummaryModel? collectionSummaryModel;
  CollectionDashboardModel? collectionDashboardModel;

  PayDeviceModel? payDeviceModel;
  PaymentModeModel? paymentModeModel;
  ActivebankModel? activebankModel;

  var allPendingCreditDetailsData =
      <PendingCreditData>[].obs; // Store all loaded data

  var currentPage = 1.obs;
  var isLoadingMore = false.obs;
  var hasMoreData = true.obs;
  var paymentModes = <Map<String, dynamic>>[].obs;

  final selectedMode = PaymentModeData().obs;
  final cardNameController = TextEditingController();
  final deviceType = PayDeviceData().obs;
  final cardNoController = TextEditingController();
  final approvalNoController = TextEditingController();
  final bankController = ActiveBankData().obs;
  final payDateController = TextEditingController();
  final nbTypeController = ''.obs;

  var totalPaidAmount = 0.0.obs;
  var receivedAmount = 0.0.obs;
  var refundAmount = 0.0.obs;
  var billAmount = 0.0.obs;
  var remainingAmount = 0.0.obs;
  var netAmount = 0.0.obs;
  var discountAmount = 0.0.obs;
  var totalDiscount = 0.0.obs;
  var totalReceivedAmount = 0.0.obs;

  // Lists for multiple credit items
  List<TextEditingController> discountControllers = [];
  List<TextEditingController> receivedControllers = [];

  dynamic credit;

  @override
  void onInit() {
    super.onInit();
    initializePage();

    getPaymentMode();
    getActiveBankList();
    getPayDeviceList();

    // Listen to net amount changes
    discountAmountController.addListener(() {
      calculateAmounts();
    });

    // Listen to payment modes changes
    ever(paymentModes, (_) => calculateTotalPaid());
  }

  // Initialize the page
  Future<void> initializePage() async {
    await getCollectionDashboardCount();
  }

  void initializePendingCreditDetailsList(int areaId) {
    // Reset all data
    allPendingCreditDetailsData.clear();
    currentPage.value = 1;
    hasMoreData.value = true;
    getAreaWisePendingCreditsDetails(areaId);
  }

  // Clear all data
  void clearAllData() {
    pendingCreditsModel = null;
    pendingChitDueModel = null;
    collectionSummaryModel = null;
    customerDueListModel = null;
    discountControllers.clear();
    receivedControllers.clear();
    paymentModes.clear();
  }

  String formatDate(String date) {
    if (date.isEmpty) return '-';
    try {
      final parsedDate = DateTime.parse(date);
      return '${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}';
    } catch (e) {
      return date;
    }
  }

  bool isOverdue(String? dueDate) {
    if (dueDate == null || dueDate.isEmpty) return false;
    try {
      final due = DateTime.parse(dueDate);
      return due.isBefore(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  String formatAmount(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(2)}Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(2)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(2)}K';
    }
    return amount.toStringAsFixed(0);
  }

// Collection app
  Future<void> getCollectionDashboardCount() async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    try {
      Response? response =
          await collectionDashboardRepo.getCollectionDashboard();

      if (response != null && response.statusCode == 200) {
        collectionDashboardModel =
            CollectionDashboardModel.fromJson(response.body);
      } else {
        print("Invalid Response: ${response?.statusCode}");
        print("Response Body: ${response?.body}");
        collectionDashboardModel = null;
        customSnackBar('Failed to load pending credits', isError: true);
      }
    } catch (e, stackTrace) {
      print("Error loading pending credits: $e");
      print("StackTrace: $stackTrace");
      collectionDashboardModel = null;
      customSnackBar('Error loading pending credits', isError: true);
    }

    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  //  area wise pending credits
  Future<void> getAreaWisePendingCredits() async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    try {
      Response? response =
          await collectionDashboardRepo.getAreaWisePendingCredits();

      if (response != null && response.statusCode == 200) {
        pendingCreditsModel = PendingCreditsModel.fromJson(response.body);
        print(
            "Loaded Pending Credits: ${pendingCreditsModel?.data?.length ?? 0} areas");
      } else {
        print("Invalid Response: ${response?.statusCode}");
        print("Response Body: ${response?.body}");
        pendingCreditsModel = null;
        customSnackBar('Failed to load pending credits', isError: true);
      }
    } catch (e, stackTrace) {
      print("Error loading pending credits: $e");
      print("StackTrace: $stackTrace");
      pendingCreditsModel = null;
      customSnackBar('Error loading pending credits', isError: true);
    }

    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  // area wise pending chit dues
  Future<void> getAreaWisePendingChitDues() async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    try {
      Response? response =
          await collectionDashboardRepo.getAreaWisePendingChitDues();
      if (response != null && response.statusCode == 200) {
        pendingChitDueModel = PendingChitDueModel.fromJson(response.body);
        print(
            "Loaded Pending Credits: ${pendingChitDueModel?.data?.length ?? 0} areas");
      } else {
        print("Invalid Response: ${response?.statusCode}");
        print("Response Body: ${response?.body}");
        pendingChitDueModel = null;
        customSnackBar('Failed to load pending credits', isError: true);
      }
    } catch (e, stackTrace) {
      print("Error loading pending credits: $e");
      print("StackTrace: $stackTrace");
      pendingChitDueModel = null;
      customSnackBar('Error loading pending credits', isError: true);
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  // collection summary
  Future<void> getCollectionSummaryList() async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    try {
      final loginModel = await AuthRepo.getUserModel();
      final idEmp = loginModel?.employee?.idEmployee;
      final body = {"id_employee": idEmp};
      Response? response =
          await collectionDashboardRepo.getCollectionSummary(body);
      if (response != null && response.statusCode == 200) {
        collectionSummaryModel = CollectionSummaryModel.fromJson(response.body);
        print(
            "Loaded collection summary: ${collectionSummaryModel?.data?.length ?? 0} areas");
      } else {
        print("Invalid Response: ${response?.statusCode}");
        print("Response Body: ${response?.body}");
        collectionSummaryModel = null;
        customSnackBar('Failed to load collection summary', isError: true);
      }
    } catch (e, stackTrace) {
      print("Error loading collection summary: $e");
      print("StackTrace: $stackTrace");
      collectionSummaryModel = null;
      customSnackBar('Error loading collection summary', isError: true);
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  Future<void> submitBillingDetails() async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    final loginModel = await AuthRepo.getUserModel();

    // Build credit_details array from all credit items
    List<Map<String, dynamic>> creditDetailsList = [];

    if (customerDueListModel?.data != null) {
      for (int i = 0; i < customerDueListModel!.data!.length; i++) {
        var creditItem = customerDueListModel!.data![i];
        double receivedAmt =
            double.tryParse(receivedControllers[i].text) ?? 0.0;
        double discountAmt =
            double.tryParse(discountControllers[i].text) ?? 0.0;

        // Only add if there's a received amount
        if (receivedAmt > 0) {
          creditDetailsList.add({
            "discount_amount": discountAmt.toString(),
            "issue_id": creditItem.id,
            "received_amount": receivedAmt.toString()
          });
        }
      }
    }

    if (creditDetailsList.isEmpty) {
      customSnackBar('Please enter received amount for at least one credit',
          isError: true);
      isLoading.value = false;
      loaderController.showLoaderAfterBuild(isLoading.value);
      return;
    }

    final body = {
      "amount": totalReceivedAmount.value, //total receiving amount
      "bill_date":
          DateTime.now().toIso8601String().split('T')[0], //collecting date
      "branch": customerDueListModel!.data![0].branchId, //select from dropdown
      "id_counter": 1, //select from dropdown
      "employee": loginModel?.employee?.idEmployee, //logged in employee id
      "credit_type": 1,
      "setting_bill_type": 1, //static
      "weight": 0, //static
      "customer": credit.customerId, //selected customer id
      "receipt_type": 5,
      "remarks": "credit collection", //remarks text field
      "type": 2,
      "credit_details": creditDetailsList,
      "is_collection_agent_user": true,
      "payment_details": paymentModes.toList(),
    };

    print("Submitting body: $body");

    Response? response =
        await collectionDashboardRepo.createCollectionCreate(body);
    if (response != null && response.statusCode == 201) {
      print("Loaded Sub Data: ${response.body}");

      getCollectionDashboardCount();
      Get.back(); // Close the page
      Get.back(); // Close the page
      Get.toNamed('/credit-collection-report');

      customSnackBar('Payment submitted successfully', isError: false);
    } else {
      print("Invalid Response: ${response?.body}");
      customSnackBar('Failed to submit payment', isError: true);
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  // Get total pending amount across all areas
  double getTotalPendingAmount() {
    if (pendingCreditsModel?.data == null) return 0;
    return pendingCreditsModel!.data!.fold(
        0.0, (sum, item) => sum + ((item.creditPendingAmount ?? 0).toDouble()));
  }

  // Get total pending count across all areas
  int getTotalPendingCount() {
    if (pendingCreditsModel?.data == null) return 0;
    return pendingCreditsModel!.data!
        .fold(0, (sum, item) => sum + (item.creditPendingCount ?? 0));
  }

  // Get total customer count across all areas
  int getTotalCustomerCount() {
    if (pendingCreditsModel?.data == null) return 0;
    return pendingCreditsModel!.data!
        .fold(0, (sum, item) => sum + (item.customerCount ?? 0));
  }

  double getTotalPendingChitDueCount() {
    if (pendingChitDueModel?.data == null) return 0;
    return pendingChitDueModel!.data!.fold(0.0,
        (sum, item) => sum + ((item.pendingCollectionCount ?? 0).toDouble()));
  }

  Future<void> getAreaWisePendingCreditsDetails(int areaId) async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    final body = {"area_id": areaId};
    Response? response = await collectionDashboardRepo
        .getAreaWisePendingCreditsDetails(currentPage.value, body);
    if (response != null && response.statusCode == 200) {
      pendingCreditsDetailsModel =
          PendingCreditsDetails.fromJson(response.body);
      if (pendingCreditsDetailsModel?.data != null) {
        allPendingCreditDetailsData.addAll(pendingCreditsDetailsModel!.data!);
      }

      // Check if there's more data to load
      if (currentPage.value >= (pendingCreditsDetailsModel?.totalPages ?? 1)) {
        hasMoreData.value = false;
      } else {
        hasMoreData.value = true;
      }
      print("Loaded Sales: $pendingCreditsDetailsModel");
    } else {
      print("Invalid Response: ${response?.body}");
      pendingCreditsDetailsModel = null; // Clear data on error
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  Future<void> loadMorePendingCreditDetails(int areaId) async {
    // Prevent multiple simultaneous requests
    if (isLoadingMore.value || !hasMoreData.value) return;

    // Check if we've reached the last page
    if (pendingCreditsDetailsModel != null &&
        currentPage.value >= (pendingCreditsDetailsModel!.totalPages ?? 1)) {
      hasMoreData.value = false;
      return;
    }

    isLoadingMore.value = true;
    currentPage.value++;

    final body = {"area_id": areaId};

    try {
      Response? response = await collectionDashboardRepo
          .getAreaWisePendingCreditsDetails(currentPage.value, body);

      if (response != null && response.statusCode == 200) {
        final newData = PendingCreditsDetails.fromJson(response.body);

        if (newData.data != null && newData.data!.isNotEmpty) {
          // Add new data to existing list
          allPendingCreditDetailsData.addAll(newData.data!);
          pendingCreditsDetailsModel = newData;

          // Check if there's more data
          if (currentPage.value >= (newData.totalPages ?? 1)) {
            hasMoreData.value = false;
          }
        } else {
          hasMoreData.value = false;
          currentPage.value--; // Revert page increment if no data
        }
      } else {
        currentPage.value--; // Revert page increment on error
        Get.snackbar(
          'Error',
          'Failed to load more data',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      currentPage.value--; // Revert page increment on error
      print('Error loading more: $e');
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshPendingCreditList(int areaId) async {
    // Reset everything
    allPendingCreditDetailsData.clear();
    currentPage.value = 1;
    hasMoreData.value = true;

    await getAreaWisePendingCreditsDetails(areaId);

    Get.snackbar(
      'Refreshed',
      'Pending Credit details list updated',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> getAreaWisePendingChitDueDetails(int areaId) async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    final body = {"area_id": areaId};
    Response? response =
        await collectionDashboardRepo.getAreaWisePendingChitDueDetails(body);
    if (response != null && response.statusCode == 200) {
      pendingChitDueDetailsModel =
          PendingChitDueDetailsModel.fromJson(response.body);
      print("Loaded Sales: $pendingChitDueDetailsModel");
    } else {
      print("Invalid Response: ${response?.body}");
      pendingChitDueDetailsModel = null; // Clear data on error
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  Future<void> getCustomerCreditDueList(int customerId) async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    final body = {"id_customer": customerId};
    Response? response =
        await collectionDashboardRepo.getCustomerCreditDueList(body);
    if (response != null && response.statusCode == 201) {
      customerDueListModel = CustomerDueListModel.fromJson(response.body);
      print("Loaded Sales: $customerDueListModel");

      // Initialize controllers for each credit item
      initializeCreditControllers();
    } else {
      print("Invalid Response: ${response?.body}");
      customerDueListModel = null;
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  void initializeCreditControllers() {
    // Clear existing controllers
    for (var controller in discountControllers) {
      controller.dispose();
    }
    for (var controller in receivedControllers) {
      controller.dispose();
    }
    discountControllers.clear();
    receivedControllers.clear();

    // Create new controllers for each credit item
    if (customerDueListModel?.data != null) {
      for (var creditItem in customerDueListModel!.data!) {
        discountControllers.add(TextEditingController());
        receivedControllers.add(TextEditingController(
          text: creditItem.balanceAmount?.toStringAsFixed(2) ?? '0.00',
        ));
      }
    }
    updateTotalReceived();
  }

  TextEditingController getDiscountController(int index) {
    if (index < discountControllers.length) {
      return discountControllers[index];
    }
    return TextEditingController();
  }

  TextEditingController getReceivedController(int index) {
    if (index < receivedControllers.length) {
      return receivedControllers[index];
    }
    return TextEditingController();
  }

  void calculateItemAmounts(int index, dynamic creditItem) {
    if (index >= discountControllers.length ||
        index >= receivedControllers.length) return;

    double discount = double.tryParse(discountControllers[index].text) ?? 0.0;
    double balanceAmount = creditItem.balanceAmount?.toDouble() ?? 0.0;
    double receivedAmt = balanceAmount - discount;

    receivedControllers[index].text = receivedAmt.toStringAsFixed(2);

    updateTotalReceived();
  }

  void updateTotalReceived() {
    double totalReceived = 0.0;
    double totalDiscountAmt = 0.0;

    for (int i = 0; i < receivedControllers.length; i++) {
      totalReceived += double.tryParse(receivedControllers[i].text) ?? 0.0;
      totalDiscountAmt += double.tryParse(discountControllers[i].text) ?? 0.0;
    }

    totalReceivedAmount.value = totalReceived;
    totalDiscount.value = totalDiscountAmt;

    // Update remaining amount for payments
    remainingAmount.value = totalReceivedAmount.value - totalPaidAmount.value;
  }

  Future<void> getPaymentMode() async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    Response? response = await collectionDashboardRepo.getPaymentMode();
    if (response != null && response.statusCode == 200) {
      paymentModeModel = PaymentModeModel.fromJson(response.body);
      paymentModeModel?.data = paymentModeModel?.data
          ?.where((mode) => mode.showToPay == true)
          .toList();
    } else {
      print('Invalid User');
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  Future<void> getActiveBankList() async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    Response? response = await collectionDashboardRepo.getActiveBank();
    if (response != null && response.statusCode == 200) {
      activebankModel = ActivebankModel.fromJson(response.body);
    } else {
      print('Invalid User');
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  Future<void> getPayDeviceList() async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    Response? response = await collectionDashboardRepo.getPayDevice();
    if (response != null && response.statusCode == 200) {
      payDeviceModel = PayDeviceModel.fromJson(response.body);
    } else {
      print('Invalid User');
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  void calculateInitialAmounts(double totalSales) {
    // Bill Amount = Total Sales - Total Purchase
    billAmount.value = totalSales.roundToDouble();

    // Initial Net Amount same as Bill Amount
    netAmount.value = billAmount.value.roundToDouble();

    // Calculate discount and received/refund
    calculateAmounts();
  }

  void calculateAmounts() {
    // Parse discount amount from controller
    double enteredDiscountAmount =
        double.tryParse(discountAmountController.text) ?? 0.0;

    discountAmount.value = enteredDiscountAmount;

    // Calculate received amount based on discount
    // Received Amount = Due Amount - Discount
    double dueAmt = (credit.dueAmount ?? 0).toDouble();
    receivedAmount.value = dueAmt - discountAmount.value;

    // Update the received amount text field
    receivedAmountController.text = receivedAmount.value.toStringAsFixed(2);

    // Calculate remaining amount for payment
    calculateTotalPaid();
  }

  void calculateTotalPaid() {
    double total = 0.0;
    for (var payment in paymentModes) {
      total += double.tryParse(payment['payment_amount'].toString()) ?? 0.0;
    }
    totalPaidAmount.value = total;

    // Remaining = Total Received Amount - Total Paid
    remainingAmount.value = totalReceivedAmount.value - totalPaidAmount.value;
  }

  void showAddPaymentDialog(BuildContext context, dynamic credit) {
    // Reset fields
    amountController.clear();
    cardNameController.clear();
    cardNoController.clear();
    approvalNoController.clear();
    payDateController.clear();
    selectedMode.value = PaymentModeData();
    deviceType.value = PayDeviceData();
    bankController.value = ActiveBankData();
    nbTypeController.value = '';

    // Use the total received amount as the base for remaining calculation
    remainingAmount.value = totalReceivedAmount.value - totalPaidAmount.value;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Obx(() => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add Payment Mode',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.close),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Remaining Amount Display
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: remainingAmount.value > 0
                            ? Colors.orange[50]
                            : Colors.green[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: remainingAmount.value > 0
                              ? Colors.orange
                              : Colors.green,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Remaining Amount:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            '₹${remainingAmount.value.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: remainingAmount.value > 0
                                  ? Colors.orange[700]
                                  : Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Payment Mode Dropdown
                    _buildDialogDropdownPaymentMode(
                      'Payment Mode *',
                      paymentModeModel?.data ?? [],
                    ),
                    const SizedBox(height: 16),

                    // Amount Field
                    _buildDialogTextField(
                      'Amount *',
                      amountController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    // Conditional Fields based on Payment Mode
                    if (selectedMode.value.cardNameVisibility == true) ...[
                      _buildDialogTextField('Card Name *', cardNameController),
                      const SizedBox(height: 12),
                    ],
                    if (selectedMode.value.deviceTypeVisibility == true) ...[
                      _buildDialogDropdownDevice(
                        'Device Type *',
                        deviceType,
                        payDeviceModel?.data ?? [],
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (selectedMode.value.cardNoVisibility == true) ...[
                      _buildDialogTextField('Card Number *', cardNoController),
                      const SizedBox(height: 12),
                    ],
                    if (selectedMode.value.approvalNoVisibility == true) ...[
                      _buildDialogTextField(
                          'Approval Number *', approvalNoController),
                      const SizedBox(height: 12),
                    ],
                    if (selectedMode.value.bankVisibility == true) ...[
                      _buildDialogDropdownBank(
                        'Bank *',
                        bankController,
                        activebankModel?.data ?? [],
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (selectedMode.value.payDateVisibility == true) ...[
                      _buildDialogDateField(
                          'Payment Date *', payDateController, context),
                      const SizedBox(height: 12),
                    ],
                    if (selectedMode.value.nbTypeVisibility == true) ...[
                      _buildDialogDropdown(
                        'NB Type *',
                        nbTypeController,
                        ['RTGS', 'IMPS', 'NEFT'],
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Add Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF5A52D5)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C63FF).withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (selectedMode.value.modeName == null ||
                                  selectedMode.value.modeName!.isEmpty ||
                                  amountController.text.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  'Please fill required fields',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                return;
                              }

                              double enteredAmount =
                                  double.tryParse(amountController.text) ?? 0.0;

                              // Check if amount exceeds remaining amount
                              if (enteredAmount > remainingAmount.value) {
                                Get.snackbar(
                                  'Error',
                                  'Amount cannot exceed remaining amount: ₹${remainingAmount.value.toStringAsFixed(2)}',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                return;
                              }

                              Map<String, dynamic> paymentData = {
                                "payment_type": 1,
                                "id_mode": selectedMode.value.idMode,
                                "payment_mode_id": selectedMode.value.idMode,
                                "payment_mode": selectedMode.value.idMode,
                                "short_code": selectedMode.value.shortCode,
                                "payment_amount":
                                    enteredAmount.toStringAsFixed(2),
                                "card_no": null,
                                "card_holder": null,
                                "ref_no": null,
                                "card_type": 2,
                                "cheque_no": null,
                                "nb_type": null,
                                "bank": "",
                                "pay_device": "",
                                "type": 1
                              };

                              // Add conditional details

                              if (selectedMode.value.cardNameVisibility ==
                                      true &&
                                  cardNameController.text.isNotEmpty) {
                                paymentData['card_holder'] =
                                    cardNameController.text;
                              }
                              if (selectedMode.value.deviceTypeVisibility ==
                                      true &&
                                  deviceType.value.deviceName != null) {
                                paymentData['pay_device'] =
                                    deviceType.value.idDevice;
                              }
                              if (selectedMode.value.cardNoVisibility == true &&
                                  cardNoController.text.isNotEmpty) {
                                paymentData['card_no'] = cardNoController.text;
                              }
                              if (selectedMode.value.approvalNoVisibility ==
                                      true &&
                                  approvalNoController.text.isNotEmpty) {
                                paymentData['ref_no'] =
                                    approvalNoController.text;
                              }
                              if (selectedMode.value.bankVisibility == true &&
                                  bankController.value.bankName != null) {
                                paymentData['bank'] =
                                    bankController.value.idBank!;
                              }
                              // if (selectedMode.value.payDateVisibility ==
                              //         true &&
                              //     payDateController.text.isNotEmpty) {
                              //   details['Payment Date'] =
                              //       payDateController.text;
                              // }
                              if (selectedMode.value.nbTypeVisibility == true &&
                                  nbTypeController.value.isNotEmpty) {
                                paymentData['nb_type'] = nbTypeController.value;
                              }

                              paymentModes.add(paymentData);
                              Get.back();

                              Get.snackbar(
                                'Success',
                                'Payment mode added successfully',
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: const Center(
                              child: Text(
                                'Add Payment',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: 'Enter $label',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDialogDropdownPaymentMode(
      String label, List<PaymentModeData> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedMode.value.modeName,
                  hint: Text('Select $label'),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((PaymentModeData value) {
                    return DropdownMenuItem<String>(
                      value: value.modeName,
                      child: Text(value.modeName ?? ""),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedMode.value =
                        items.firstWhere((mode) => mode.modeName == value);
                  },
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildDialogDropdownDevice(String label,
      Rx<PayDeviceData> selectedValue, List<PayDeviceData> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue.value.deviceName,
                  hint: Text('Select $label'),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((PayDeviceData value) {
                    return DropdownMenuItem<String>(
                      value: value.deviceName,
                      child: Text(value.deviceName ?? ""),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedValue.value = items
                        .firstWhere((device) => device.deviceName == value);
                  },
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildDialogDropdownBank(String label,
      Rx<ActiveBankData> selectedValue, List<ActiveBankData> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue.value.bankName,
                  hint: Text('Select $label'),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((ActiveBankData value) {
                    return DropdownMenuItem<String>(
                      value: value.bankName,
                      child: Text(value.bankName ?? ""),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedValue.value =
                        items.firstWhere((bank) => bank.bankName == value);
                  },
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildDialogDateField(
      String label, TextEditingController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: TextField(
            controller: controller,
            readOnly: true,
            decoration: const InputDecoration(
              hintText: 'Select Date',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: Icon(Icons.calendar_today, size: 20),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                controller.text =
                    "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDialogDropdown(
      String label, RxString selectedValue, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value:
                      selectedValue.value.isEmpty ? null : selectedValue.value,
                  hint: Text('Select $label'),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedValue.value = value!;
                  },
                ),
              ),
            )),
      ],
    );
  }

  void removePaymentMode(int index) {
    paymentModes.removeAt(index);
    Get.snackbar(
      'Removed',
      'Payment mode removed',
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    receivedAmountController.dispose();
    amountController.dispose();
    discountAmountController.dispose();
    cardNameController.dispose();
    cardNoController.dispose();
    approvalNoController.dispose();
    payDateController.dispose();
    super.onClose();
  }
}
