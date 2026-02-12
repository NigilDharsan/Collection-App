import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/Loader/loader_utils.dart';
import '../../SchemeJoin/model/BranchModel.dart';
import '../../auth/repository/auth_repo.dart';
import '../model/ActivebankModel.dart';
import '../model/BillingListModel.dart';
import '../model/EstDetailsModel.dart';
import '../model/PayDeviceModel.dart';
import '../model/PaymentModeModel.dart';
import '../repository/BillingRepo.dart';
import 'Dasboard_Controller.dart';


class BillingController extends GetxController implements GetxService {
  final BillingRepo billingRepo;

  BillingController({required this.billingRepo});

  final dashboardController = Get.find<DashboardController>();

  var isLoading = false.obs;
  var selectedBranch = ''.obs;
  var selectedTab = 0.obs;
  var isReceivedAmountEditable = false.obs;
  var isSettingbilltype = false.obs;

  var paymentModes = <Map<String, dynamic>>[].obs;

  final estNoController = TextEditingController();
  final receivedAmountController = TextEditingController();
  final amountController = TextEditingController();
  final netAmountController = TextEditingController();

  final FocusNode netAmountFocusNode = FocusNode();

  EstDetailsModel? estDetails;
  PayDeviceModel? payDeviceModel;
  PaymentModeModel? paymentModeModel;
  ActivebankModel? activebankModel;
  BillingListModel? billingListModel;

  final selectedMode = PaymentModeData().obs;
  final cardNameController = TextEditingController();
  final deviceType = PayDeviceData().obs;
  final cardNoController = TextEditingController();
  final approvalNoController = TextEditingController();
  final bankController = ActiveBankData().obs;
  final payDateController = TextEditingController();
  final nbTypeController = ''.obs;

  // Calculated values
  var billAmount = 0.0.obs;
  var discountAmount = 0.0.obs;
  var netAmount = 0.0.obs;
  var receivedAmount = 0.0.obs;
  var refundAmount = 0.0.obs;
  var totalPaidAmount = 0.0.obs;
  var remainingAmount = 0.0.obs;
  double totalPurchaseAmount = 0.0;
  double totalSalesAmount = 0.0;
  double totalreturnAmount = 0.0;

  var roundOff = 0;
  var paymentType = 1;

// Variables for Billing List (Add to the top of your controller)
  var currentPage = 1.obs;
  var fromDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  var toDate = DateTime.now().obs;
  var selectedBranches = <int>[].obs;
  var isLoadingMore = false.obs;
  var hasMoreData = true.obs;
  var allBillingData = <BillingListData>[].obs; // Store all loaded data

// Available branches - modify according to your actual branches
  List<BranchData> availableBranches = <BranchData>[].obs;
//  final branches = controller.branchModel?.data ?? [];

  @override
  void onInit() {
    super.onInit();
    getPaymentMode();
    getActiveBankList();
    getPayDeviceList();

    // Listen to net amount changes
    netAmountController.addListener(() {
      calculateAmounts();
    });

    // Listen to payment modes changes
    ever(paymentModes, (_) => calculateTotalPaid());

    availableBranches = dashboardController.branchModel?.data ?? [];

    netAmountFocusNode.addListener(() {
      if (!netAmountFocusNode.hasFocus) {
        // Keyboard dismissed
        onKeyboardDismiss();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clearBillingDetails();
  }

  void onKeyboardDismiss() {
    print("Keyboard dismissed");

    if (discountAmount.value <= 0.0) {
    } else {
      calculateItemDetails();
    }
  }

  bool isPaymentSufficient() {
    if (billAmount.value >= 0) {
      return totalPaidAmount.value >= receivedAmount.value;
    } else {
      return totalPaidAmount.value >= refundAmount.value;
    }
  }

  Future<void> fetchEstDetails() async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);

    final body = {
      "est_no": estNoController.text,
      "id_branch": dashboardController.selectedEstimateBranchId.value
    };

    Response? response = await billingRepo.estDetails(body);
    if (response != null && response.statusCode == 200) {
      final estResults = EstDetailsModel.fromJson(response.body);

      if (estDetails != null) {
        // --- SALES ---
        estDetails!.salesDetails?.addAll(
          estResults.salesDetails!.where(
            (newItem) => !estDetails!.salesDetails!.any((oldItem) =>
                ((oldItem.tagCode == newItem.tagCode) ||
                    (oldItem.estItemId == newItem.estItemId))),
          ),
        );

        // --- PURCHASE ---
        estDetails!.purchaseDetails!.addAll(estResults.purchaseDetails!.where(
          (newItem) => !estDetails!.purchaseDetails!.any(
            (oldItem) => oldItem.estOldMetalItemId == newItem.estOldMetalItemId,
          ),
        ));
      } else {
        estDetails = estResults;
      }

      calculateInitialAmounts();
      print("Loaded Sub Data: $estDetails");
    } else {
      print("Invalid Response: ${response?.body}");
      estDetails = null;
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  Future<void> calculateItemDetails() async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);

    final body = {
      "item_details": estDetails?.salesDetails!.toList(),
      "discount_amount": discountAmount.value.toStringAsFixed(2),
    };

    Response? response = await billingRepo.calculateItemDetails(body);
    if (response != null && response.statusCode == 200) {
      print("Loaded Sub Data: $response?.body");

      List<SalesDetails> newItems = [];
      for (var item in response.body['data']) {
        newItems.add(SalesDetails.fromJson(item));
      }

      estDetails?.salesDetails = newItems;
      calculateInitialAmounts();
      update();
    } else {
      print("Invalid Response: ${response?.body}");
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  Future<void> submitBillingDetails() async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    final loginModel = await AuthRepo.getUserModel();

    final body = {
      "invoice": {
        "id_branch": dashboardController.selectedEstimateBranchId.value,
        "id_customer": estDetails?.idCustomer ?? 0,
        "refered_customer": null,
        "is_credit": isReceivedAmountEditable.value ? 1 : 0,
        "invoice_for": "1",
        "invoice_to": "1",
        "pan_number": null,
        "gst_number": null,
        "sales_amount": totalSalesAmount.toStringAsFixed(2),
        "purchase_amount": totalPurchaseAmount.toStringAsFixed(2),
        "return_amount": totalreturnAmount.toStringAsFixed(2),
        "total_discount_amount": discountAmount.value.toStringAsFixed(2),
        "total_adjusted_amount": 0,
        "total_loyality_amount": 0,
        "total_chit_amount": 0,
        "total_deposit_amount": 0,
        "net_amount": netAmount.value.toStringAsFixed(2),
        "received_amount": receivedAmount.value.toStringAsFixed(2),
        "deposit_amount": 0,
        "refund_amount": refundAmount.value.toStringAsFixed(2),
        "charges_amount": 0,
        "due_amount": receivedAmount.value - netAmount.value,
        "round_off": roundOff,
        "id_employee": loginModel?.employee?.idEmployee ?? 0,
        "customer_name": estDetails?.customerName ?? "",
        "metal": estDetails?.salesDetails?.isNotEmpty == true
            ? estDetails?.salesDetails![0].idMetal ?? ""
            : "",
        "is_promotional_billing": "0",
        "delivery_location": 1,
        "setting_bill_type": isSettingbilltype.value ? 1 : 0,
        "return_cash_amount": 0,
        "repair_amount": "0.00"
      },
      "loyality_details": {
        "loyality_points": 0,
        "used_points": 0,
        "redemption_rate_per_point": 0,
        "loyality_amount": 0,
        "loyality_total_amount": 0
      },
      "repair_details": [],
      "isDateChangeded": false,
      "entryDate": "",
      "allow_bill_date_change": false,
      "sales_details": estDetails?.salesDetails!.toList(),
      "purchase_details": estDetails?.purchaseDetails!.toList(),
      "payment_details": paymentModes.toList(),
      "return_details": estDetails?.returnDetails!.toList(),
      "advance_adjusted_details": [],
      "deposit_details": [],
      "scheme_details": [],
      "gift_details": [],
      "item_delivered_details": []
    };

    Response? response = await billingRepo.billingCreate(body);
    if (response != null && response.statusCode == 201) {
      print("Loaded Sub Data: $response?.body");
      Get.snackbar(
        'Success',
        response.body['message'] ?? 'Billing created successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      clearBillingDetails();
    } else {
      print("Invalid Response: ${response?.body}");
      estDetails = null;
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  void calculateInitialAmounts() {
    totalPaidAmount.value = 0.0;
    remainingAmount.value = 0.0;
    totalPurchaseAmount = 0.0;
    totalSalesAmount = 0.0;
    totalreturnAmount = 0.0;

    if (estDetails == null) return;

    // Calculate total sales amount
    if (estDetails!.salesDetails != null) {
      for (var sale in estDetails!.salesDetails!) {
        totalSalesAmount += sale.itemCost ?? 0.0;
      }
    }

    // Calculate total purchase amount
    if (estDetails!.purchaseDetails != null) {
      for (var purchase in estDetails!.purchaseDetails!) {
        totalPurchaseAmount += purchase.amount ?? 0.0;
      }
    }

    if (estDetails!.returnDetails != null) {
      for (var returnItem in estDetails!.returnDetails!) {
        totalreturnAmount += returnItem.itemCost ?? 0.0;
      }
    }

    double difference =
        totalSalesAmount - (totalPurchaseAmount + totalreturnAmount);

// If you still want rounded billAmount:
    billAmount.value = difference.roundToDouble();

// Set type based on sign
    paymentType = difference >= 0 ? 1 : 2;

    // Bill Amount = Total Sales - Total Purchase
    billAmount.value = difference.roundToDouble();

    // Initial Net Amount same as Bill Amount
    netAmount.value = billAmount.value.roundToDouble();
    roundOff = ((netAmount.value - difference) * 100).round();
    netAmountController.text = netAmount.value.toStringAsFixed(2);

    // Calculate discount and received/refund
    calculateAmounts();
  }

  void calculateAmounts() {
    // Parse net amount from controller
    double enteredNetAmount =
        double.tryParse(netAmountController.text) ?? netAmount.value;

    // Discount = Bill Amount - Net Amount
    discountAmount.value = billAmount.value - enteredNetAmount;

    // Update net amount
    netAmount.value = enteredNetAmount;

    // If Bill Amount is positive (receiving money from customer)
    if (billAmount.value >= 0) {
      receivedAmount.value = netAmount.value;
      refundAmount.value = 0.0;
      receivedAmountController.text = receivedAmount.value.toStringAsFixed(2);
    } else {
      // If Bill Amount is negative (refunding money to customer)
      receivedAmount.value = 0.0;
      refundAmount.value = netAmount.value.abs();
      receivedAmountController.text = refundAmount.value.toStringAsFixed(2);
    }

    // Calculate remaining amount
    calculateTotalPaid();
  }

  void calculateTotalPaid() {
    double total = 0.0;
    for (var payment in paymentModes) {
      total += double.tryParse(payment['payment_amount'].toString()) ?? 0.0;
    }
    totalPaidAmount.value = total;

    // Remaining = Received/Refund Amount - Total Paid
    if (billAmount.value >= 0) {
      remainingAmount.value = receivedAmount.value - totalPaidAmount.value;
    } else {
      remainingAmount.value = refundAmount.value - totalPaidAmount.value;
    }
  }

  // Initialize billing list with default values
  void initializeBillingList() {
    // Reset all data
    allBillingData.clear();
    currentPage.value = 1;
    hasMoreData.value = true;

    // Set default branches if none selected
    if (selectedBranches.isEmpty) {
      selectedBranches.addAll([2, 4]); // Default branches
    }
    getBillingListModel();
  }

// Main method to get billing list
  Future<void> getBillingListModel() async {
    final body = {
      "branch": selectedBranches.toList(),
      "fromDate": DateFormat('yyyy-MM-dd').format(fromDate.value),
      "toDate": DateFormat('yyyy-MM-dd').format(toDate.value),
    };

    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);

    Response? response =
        await billingRepo.getBillingList(currentPage.value, body);

    if (response != null && response.statusCode == 200) {
      billingListModel = BillingListModel.fromJson(response.body);

      // Add new data to existing list
      if (billingListModel?.data != null) {
        allBillingData.addAll(billingListModel!.data!);
      }

      // Check if there's more data to load
      if (currentPage.value >= (billingListModel?.totalPages ?? 1)) {
        hasMoreData.value = false;
      } else {
        hasMoreData.value = true;
      }
    } else {
      print('Invalid Response');
      Get.snackbar(
        'Error',
        'Failed to load billing list',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

// Load more data when scrolling
  Future<void> loadMoreBillings() async {
    // Prevent multiple simultaneous requests
    if (isLoadingMore.value || !hasMoreData.value) return;

    // Check if we've reached the last page
    if (billingListModel != null &&
        currentPage.value >= (billingListModel!.totalPages ?? 1)) {
      hasMoreData.value = false;
      return;
    }

    isLoadingMore.value = true;
    currentPage.value++;

    final body = {
      "branch": selectedBranches.toList(),
      "fromDate": DateFormat('yyyy-MM-dd').format(fromDate.value),
      "toDate": DateFormat('yyyy-MM-dd').format(toDate.value),
    };

    try {
      Response? response =
          await billingRepo.getBillingList(currentPage.value, body);

      if (response != null && response.statusCode == 200) {
        final newData = BillingListModel.fromJson(response.body);

        if (newData.data != null && newData.data!.isNotEmpty) {
          // Add new data to existing list
          allBillingData.addAll(newData.data!);
          billingListModel = newData;

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

// Refresh list (pull to refresh)
  Future<void> refreshBillingList() async {
    // Reset everything
    allBillingData.clear();
    currentPage.value = 1;
    hasMoreData.value = true;

    await getBillingListModel();

    Get.snackbar(
      'Refreshed',
      'Billing list updated',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

// Date range methods
  void updateDateRange(DateTime start, DateTime end) {
    fromDate.value = start;
    toDate.value = end;

    // Reset and reload data
    allBillingData.clear();
    currentPage.value = 1;
    hasMoreData.value = true;
    getBillingListModel();
  }

  String getDateRangeText() {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    return '${formatter.format(fromDate.value)} - ${formatter.format(toDate.value)}';
  }

// Branch selection methods
  void toggleBranchSelection(int branchId) {
    if (selectedBranches.contains(branchId)) {
      selectedBranches.remove(branchId);
    } else {
      selectedBranches.add(branchId);
    }
  }

  void applyBranchFilter() {
    // Reset and reload data
    allBillingData.clear();
    currentPage.value = 1;
    hasMoreData.value = true;
    getBillingListModel();
  }

  String getSelectedBranchesText() {
    if (selectedBranches.isEmpty) {
      return 'All Branches';
    } else if (selectedBranches.length == 1) {
      final branch =
          (Get.find<DashboardController>().branchModel?.data)!.firstWhere(
        (b) => b.idBranch == selectedBranches.first,
        orElse: () => BranchData(name: 'Unknown'),
      );
      return branch.name ?? 'Unknown';
    } else {
      return '${selectedBranches.length} Branches';
    }
  }

// Filter management
  bool hasActiveFilters() {
    final now = DateTime.now();
    final defaultFromDate = now.subtract(const Duration(days: 30));

    final hasDateFilter = !_isSameDay(fromDate.value, defaultFromDate) ||
        !_isSameDay(toDate.value, now);
    final hasBranchFilter =
        selectedBranches.length != 2; // Changed from availableBranches.length

    return hasDateFilter || hasBranchFilter;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void clearFilters() {
    fromDate.value = DateTime.now().subtract(const Duration(days: 30));
    toDate.value = DateTime.now();
    selectedBranches.clear();
    selectedBranches.addAll([2, 4]); // Reset to default branches

    // Reset and reload data
    allBillingData.clear();
    currentPage.value = 1;
    hasMoreData.value = true;
    getBillingListModel();

    Get.snackbar(
      'Filters Cleared',
      'All filters have been reset',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  clearBillingDetails() {
    estNoController.clear();
    estDetails = null;
    paymentModes.clear();
    billAmount.value = 0.0;
    discountAmount.value = 0.0;
    netAmount.value = 0.0;
    receivedAmount.value = 0.0;
    refundAmount.value = 0.0;
    totalPaidAmount.value = 0.0;
    remainingAmount.value = 0.0;
    totalPurchaseAmount = 0.0;
    totalSalesAmount = 0.0;
    totalreturnAmount = 0.0;
    roundOff = 0;
    paymentType = 1;
    isReceivedAmountEditable.value = false;
    isSettingbilltype.value = false;
    update();
  }

// Search functionality (optional)
  void searchBillings(String query) {
    if (query.isEmpty) {
      // Reset to show all data
      allBillingData.clear();
      currentPage.value = 1;
      hasMoreData.value = true;
      getBillingListModel();
      return;
    }

    // You can implement local search or API search here
    // For local search:
    // final filtered = allBillingData.where((billing) {
    //   return billing.invNo?.toLowerCase().contains(query.toLowerCase()) ?? false ||
    //          billing.customerName?.toLowerCase().contains(query.toLowerCase()) ?? false ||
    //          billing.customerMobile?.contains(query) ?? false;
    // }).toList();
  }

// Get total records count
  int getTotalRecords() {
    return billingListModel?.noOfRecords ?? allBillingData.length;
  }

  Future<void> getPaymentMode() async {
    isLoading.value = true;
    loaderController.showLoaderAfterBuild(isLoading.value);
    Response? response = await billingRepo.getPaymentMode();
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
    Response? response = await billingRepo.getActiveBank();
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
    Response? response = await billingRepo.getPayDevice();
    if (response != null && response.statusCode == 200) {
      payDeviceModel = PayDeviceModel.fromJson(response.body);
    } else {
      print('Invalid User');
    }
    isLoading.value = false;
    loaderController.showLoaderAfterBuild(isLoading.value);
    update();
  }

  void showAddPaymentDialog(BuildContext context) {
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
                                "card_no": "",
                                "card_holder": "",
                                "payment_ref_number": "",
                                "card_type": 2,
                                "id_nb_type": null,
                                "id_bank": null,
                                "id_pay_device": ""
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
                                paymentData['id_pay_device'] =
                                    deviceType.value.idDevice;
                              }
                              if (selectedMode.value.cardNoVisibility == true &&
                                  cardNoController.text.isNotEmpty) {
                                paymentData['card_no'] = cardNoController.text;
                              }
                              if (selectedMode.value.approvalNoVisibility ==
                                      true &&
                                  approvalNoController.text.isNotEmpty) {
                                paymentData['payment_ref_number'] =
                                    approvalNoController.text;
                              }
                              if (selectedMode.value.bankVisibility == true &&
                                  bankController.value.bankName != null) {
                                paymentData['id_bank'] =
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
                                paymentData['id_nb_type'] =
                                    nbTypeController.value;
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
    estNoController.dispose();
    receivedAmountController.dispose();
    amountController.dispose();
    netAmountController.dispose();
    cardNameController.dispose();
    cardNoController.dispose();
    approvalNoController.dispose();
    payDateController.dispose();
    super.onClose();
  }
}
