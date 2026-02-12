// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tn_jewellery_admin/features/CollectionApp/SchemeJoin/model/BranchModel.dart';
// import 'package:tn_jewellery_admin/features/CollectionApp/SchemeJoin/model/Customer_Account_Model.dart';
// import 'package:tn_jewellery_admin/features/CollectionApp/SchemeJoin/model/Mobile_Number_List.dart';
// import 'package:tn_jewellery_admin/features/CollectionApp/SchemeJoin/model/SchemeModel.dart';
// import 'package:tn_jewellery_admin/features/CollectionApp/SchemeJoin/repo/Scheme_Payment_Repo.dart';
// import 'package:tn_jewellery_admin/features/auth/repository/auth_repo.dart';
// import 'package:tn_jewellery_admin/utils/Loader/loader_utils.dart';

// class SchemePaymentController extends GetxController implements GetxService {
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   final SchemePaymentRepo schemePaymentRepo;

//   SchemePaymentController({
//     required this.schemePaymentRepo,
//   });

//   BranchModel? branchModel;
//   MobileListModel? mobileListModel;
//   SchemeModel? schemeModel;
//   CustomerAccountModel? customerAccountModel;
//   CustomerAccountData? selectedAccount;

//   List<Data> searchResults = [];
//   List<Data> mobileList = [];
//   List<SchemeData> schemeList = [];
//   List<CustomerAccountData> customerAccountList = [];

//   int? selectedBranchId;
//   String? selectedBranchName;

//   int? selectedCustomerId;
//   String? selectedCustomerName;
//   String? selectedCustomerMobile;

//   int? selectedSchemeId;
//   String? selectedSchemeName;

//   String? minPayableAmountText;
//   String? canPayText;
//   String? todaysRateText;

//   void searchMobile(String input) {
//     if (input.length >= 5) {
//       searchResults = mobileList
//           .where((item) => (item.mobile ?? "").contains(input))
//           .toList();
//     } else {
//       searchResults.clear();
//     }
//     update();
//   }

//   void clearSelection() {
//     selectedCustomerId = null;
//     selectedCustomerMobile = null;
//     selectedCustomerName = null;
//     update();
//   }

//   void clearOldSelection() {
//     searchResults.clear();
//     update();
//   }

//   void clearSchemeSelection() {
//     selectedSchemeId = null;
//     selectedSchemeName = null;
//     schemeList.clear();
//     update();
//   }

//   Future<void> getBranchList() async {
//     _isLoading = true;
//     loaderController.showLoaderAfterBuild(_isLoading);
//     Response? response = await schemePaymentRepo.getBranchList();
//     if (response != null && response.statusCode == 200) {
//       branchModel = BranchModel.fromJson(response.body);
//       if (branchModel?.data != null && branchModel!.data!.isNotEmpty) {
//         selectedBranchId = branchModel?.data?[0].idBranch;
//         selectedBranchName = branchModel?.data?[0].name;
//       }
//     } else {
//       print('Failed to load branch list');
//     }
//     _isLoading = false;
//     loaderController.showLoaderAfterBuild(_isLoading);
//     update();
//   }

//   Future<void> customerList({String? mobNum, String? name}) async {
//     _isLoading = true;
//     loaderController.showLoaderAfterBuild(_isLoading);
//     update();
//     final body = <String, dynamic>{
//       "is_employee_wise_search": true,
//     };
//     if (mobNum != null && mobNum.isNotEmpty) {
//       body["mob_num"] = mobNum;
//     } else if (name != null && name.isNotEmpty) {
//       body["name"] = name;
//     }
//     Response? response = await schemePaymentRepo.customerSearch(body);
//     if (response != null && response.statusCode == 200) {
//       mobileListModel = MobileListModel.fromJson(response.body);
//       mobileList = mobileListModel?.data ?? [];
//       searchResults = mobileList;
//       print('Loaded Mobiles: ${mobileList.length}');
//     } else {
//       searchResults = [];
//       print('Invalid User: ${response?.body}');
//     }
//     _isLoading = false;
//     loaderController.showLoaderAfterBuild(_isLoading);
//     update();
//   }

//   Future<void> getSchemeList(int customerId) async {
//     _isLoading = true;
//     loaderController.showLoaderAfterBuild(_isLoading);
//     update();
//     final body = {"customer_id": customerId};
//     Response? response = await schemePaymentRepo.getSchemeList(body);
//     if (response != null && response.statusCode == 200) {
//       schemeModel = SchemeModel.fromJson(response.body);
//       schemeList = schemeModel?.data ?? [];
//       // Auto-select first scheme if available
//       if (schemeList.isNotEmpty) {
//         selectedSchemeId = schemeList[0].idAccScheme;
//         selectedSchemeName = schemeList[0].schemeName;
//       }
//       print('Loaded Schemes: ${schemeList.length}');
//     } else {
//       schemeList = [];
//       print('Failed to load schemes: ${response?.body}');
//     }
//     _isLoading = false;
//     loaderController.showLoaderAfterBuild(_isLoading);
//     update();
//   }

//   Future<void> getCustomerAccountsList(int customerId) async {
//     _isLoading = true;
//     loaderController.showLoaderAfterBuild(_isLoading);
//     update();
//     final body = {"customer": customerId};
//     Response? response = await schemePaymentRepo.getCustomerAccounts(body);
//     if (response != null && response.statusCode == 200) {
//       customerAccountModel = CustomerAccountModel.fromJson(response.body);
//       customerAccountList = customerAccountModel?.data ?? [];
//       print('Loaded customer accounts : ${customerAccountList.length}');
//     } else {
//       customerAccountList = [];
//       print('Failed to load schemes: ${response?.body}');
//     }
//     _isLoading = false;
//     loaderController.showLoaderAfterBuild(_isLoading);
//     update();
//   }

//   void selectAccount(CustomerAccountData acc) {
//     selectedAccount = acc;
//     minPayableAmountText = acc.minimumPayable?.minAmount?.toStringAsFixed(0);
//     canPayText = (acc.allowPay ?? false) ? 'Yes' : 'No';
//     todaysRateText = acc.todaysRate?.toString();

//     update();
//   }

//   Future<void> createPayment({
//     required String accountName,
//     // String? refNo,
//     required String startDate,
//   }) async {
//     final loginModel = await AuthRepo.getUserModel();

//     _isLoading = true;
//     loaderController.showLoaderAfterBuild(_isLoading);
//     update();

//     final body = {
//       "acc_scheme_id": selectedSchemeId,
//       "account_name": accountName,
//       "id_branch": selectedBranchId,
//       "id_customer": selectedCustomerId,
//       "ref_no": "",
//       "refer_customer_id": null,
//       "refer_employee_id": loginModel?.employee?.idEmployee,
//       "scheme_acc_number": null,
//       "start_date": startDate,
//     };

//     Response? response = await schemePaymentRepo.createPayment(body);

//     _isLoading = false;
//     loaderController.showLoaderAfterBuild(_isLoading);
//     if (response != null && response.statusCode == 201) {
//       Get.snackbar(
//         'Success',
//         'Payment created successfully',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//       Get.offAllNamed('/collectionDashboard');
//     } else {
//       Get.snackbar(
//         'Error',
//         response?.body['message'] ?? 'Failed to create scheme',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Get.theme.colorScheme.error,
//         colorText: Colors.white,
//       );
//     }

//     update();
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../utils/Loader/loader_utils.dart';
import '../../Billing/model/ActivebankModel.dart';
import '../../Billing/model/PayDeviceModel.dart';
import '../../Billing/model/PaymentModeModel.dart';
import '../../Dashboard/controller/Collection_Dashboard_Controller.dart';
import '../model/BranchModel.dart';
import '../model/Customer_Account_Model.dart';
import '../model/Mobile_Number_List.dart';
import '../model/SchemeModel.dart';
import '../repo/Scheme_Payment_Repo.dart';

class SchemePaymentController extends GetxController implements GetxService {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final SchemePaymentRepo schemePaymentRepo;

  SchemePaymentController({
    required this.schemePaymentRepo,
  });

  BranchModel? branchModel;
  MobileListModel? mobileListModel;
  SchemeModel? schemeModel;
  CustomerAccountModel? customerAccountModel;
  CustomerAccountData? selectedAccount;

  List<Data> searchResults = [];
  List<Data> mobileList = [];
  List<SchemeData> schemeList = [];
  List<CustomerAccountData> customerAccountList = [];

  PayDeviceModel? payDeviceModel;
  PaymentModeModel? paymentModeModel;
  ActivebankModel? activebankModel;

  var paymentModes = <Map<String, dynamic>>[].obs;
  final selectedMode = PaymentModeData().obs;
  final cardNameController = TextEditingController();
  final deviceType = PayDeviceData().obs;
  final cardNoController = TextEditingController();
  final approvalNoController = TextEditingController();
  final bankController = ActiveBankData().obs;
  final payDateController = TextEditingController();
  final nbTypeController = ''.obs;

  final amountController = TextEditingController();
  final totalReceivedAmount = 0.0.obs;
  final totalPaidAmount = 0.0.obs;
  final remainingAmount = 0.0.obs;
  final advanceInstallment = 1.obs;

  int? selectedBranchId;
  String? selectedBranchName;

  int? selectedCustomerId;
  String? selectedCustomerName;
  String? selectedCustomerMobile;

  int? selectedSchemeId;
  String? selectedSchemeName;

  String? minPayableAmountText;
  String? maxPayableAmountText;
  String? canPayText;
  String? todaysRateText;

  // Payment breakdown fields
  String? bonusMetalWeight;
  String? totalWeight;
  String? discountAmount;
  String? netAmount;
  String? receivedAmount;
  String? totalNetPayment;
  String? taxAmount;
  String? balance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getPaymentMode();
    getActiveBankList();
    getPayDeviceList();
    getBranchList();

    ever(paymentModes, (_) => calculateTotalPaid());
  }

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
    selectedAccount = null;
    customerAccountList.clear();
    _resetPaymentFields();
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
    _resetPaymentFields();
    update();
  }

  void _resetPaymentFields() {
    minPayableAmountText = null;
    maxPayableAmountText = null;
    canPayText = null;
    todaysRateText = null;
    bonusMetalWeight = null;
    totalWeight = null;
    discountAmount = null;
    netAmount = null;
    receivedAmount = null;
    totalNetPayment = null;
    taxAmount = null;
    balance = null;
  }

  Future<void> getPaymentMode() async {
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    Response? response = await schemePaymentRepo.getPaymentMode();
    if (response != null && response.statusCode == 200) {
      paymentModeModel = PaymentModeModel.fromJson(response.body);
      paymentModeModel?.data = paymentModeModel?.data
          ?.where((mode) => mode.showToPay == true)
          .toList();
    } else {
      print('Invalid User');
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
  }

  Future<void> getActiveBankList() async {
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    Response? response = await schemePaymentRepo.getActiveBank();
    if (response != null && response.statusCode == 200) {
      activebankModel = ActivebankModel.fromJson(response.body);
    } else {
      print('Invalid User');
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
  }

  Future<void> getPayDeviceList() async {
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    Response? response = await schemePaymentRepo.getPayDevice();
    if (response != null && response.statusCode == 200) {
      payDeviceModel = PayDeviceModel.fromJson(response.body);
    } else {
      print('Invalid User');
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
  }

  Future<void> getBranchList() async {
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    Response? response = await schemePaymentRepo.getBranchList();
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
    final body = <String, dynamic>{
      "is_employee_wise_search": true,
    };
    if (mobNum != null && mobNum.isNotEmpty) {
      body["mob_num"] = mobNum;
    } else if (name != null && name.isNotEmpty) {
      body["name"] = name;
    }
    Response? response = await schemePaymentRepo.customerSearch(body);
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
    Response? response = await schemePaymentRepo.getSchemeList(body);
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

  Future<void> getCustomerAccountsList(int customerId) async {
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
    final body = {"customer": customerId};
    Response? response = await schemePaymentRepo.getCustomerAccounts(body);
    if (response != null && response.statusCode == 200) {
      customerAccountModel = CustomerAccountModel.fromJson(response.body);
      customerAccountList = customerAccountModel?.data ?? [];
      print('Loaded customer accounts : ${customerAccountList.length}');

      // Auto-select first account if available
      if (customerAccountList.isNotEmpty) {
        selectAccount(customerAccountList[0]);
      }
    } else {
      customerAccountList = [];
      print('Failed to load customer accounts: ${response?.body}');
    }
    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();
  }

  void selectAccount(CustomerAccountData acc) {
    selectedAccount = acc;

    // Determine which values to show based on scheme_type
    final schemeType = acc.schemeType ?? 0;
    final showAmount = schemeType == 0 || schemeType == 2;

    if (showAmount) {
      minPayableAmountText = acc.minimumPayable?.minAmount?.toStringAsFixed(0);
      maxPayableAmountText = acc.maximumPayable?.maxAmount?.toStringAsFixed(0);
    } else {
      minPayableAmountText = acc.minimumPayable?.minWeight?.toStringAsFixed(3);
      maxPayableAmountText = acc.maximumPayable?.maxWeight?.toStringAsFixed(3);
    }

    canPayText = (acc.allowPay ?? false) ? 'Yes' : 'No';
    todaysRateText = acc.todaysRate?.toStringAsFixed(0) ?? '0';

    // Reset payment breakdown
    _resetPaymentBreakdown();

    update();
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
                                "type": 2,
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

  void _resetPaymentBreakdown() {
    bonusMetalWeight = '0';
    totalWeight = '0.000';
    discountAmount = '0.00';
    netAmount = '0.00';
    receivedAmount = '0.00';
    totalNetPayment = '0.00';
    taxAmount = '0.00';
    balance = '0.00';
  }

  void calculatePaymentBreakdown({String? amount, String? weight}) {
    if (selectedAccount == null) return;

    final acc = selectedAccount!;
    double amountValue = double.tryParse(amount ?? '0') ?? 0;
    double weightValue = double.tryParse(weight ?? '0') ?? 0;

    // Calculate based on scheme type
    final schemeType = acc.schemeType ?? 0;

    if (schemeType == 0 || schemeType == 2) {
      // Amount-based scheme
      if (amountValue > 0 && (acc.todaysRate ?? 0) > 0) {
        weightValue = amountValue / (acc.todaysRate ?? 1);
      }
    } else if (schemeType == 1) {
      // Weight-based scheme
      if (weightValue > 0 && (acc.todaysRate ?? 0) > 0) {
        amountValue = weightValue * (acc.todaysRate ?? 0);
      }
    }

    // Calculate discount
    double discount = 0;
    if (acc.discountType != null && acc.discountValue != null) {
      if (acc.discountType == 1) {
        // Percentage discount
        discount = (amountValue * (acc.discountValue ?? 0)) / 100;
      } else if (acc.discountType == 2) {
        // Fixed discount
        discount = acc.discountValue?.toDouble() ?? 0;
      }
    }

    // Calculate net amount
    double netAmountValue = amountValue - discount;

    // Calculate tax amount
    double tax = 0;
    if (acc.taxPercentage != null && acc.taxPercentage! > 0) {
      tax = (netAmountValue * (acc.taxPercentage ?? 0)) / 100;
    }

    // Calculate total net payment
    double totalNetPaymentValue = netAmountValue + tax;

    // Calculate received and balance
    double received = totalNetPaymentValue * advanceInstallment.value;
    double balanceValue = 0;

    // Update fields
    netAmount = netAmountValue.toStringAsFixed(2);
    taxAmount = tax.toStringAsFixed(2);
    totalNetPayment = totalNetPaymentValue.toStringAsFixed(2);
    receivedAmount = received.toStringAsFixed(2);
    balance = balanceValue.toStringAsFixed(2);

    totalReceivedAmount.value = amountValue * advanceInstallment.value;
    // Remaining = Total Received Amount - Total Paid
    remainingAmount.value = totalReceivedAmount.value - totalPaidAmount.value;

    update();
  }

  Future<void> createPayment() async {
    _isLoading = true;
    loaderController.showLoaderAfterBuild(_isLoading);
    update();

    final body = [
      {
        "actual_trans_amt": 0, // static
        "advance": advanceInstallment.value,
        "date_payment":
            DateTime.now().toIso8601String().split('T')[0], //today’s date
        "discountAmt": "0.00", //input
        "id_branch": selectedBranchId, // can get from account data
        "id_payGateway": null, // static
        "id_scheme_account":
            selectedAccount?.idSchemeAccount, // can get from account data
        "installment":
            selectedAccount?.paidInstallments, // can get from account data
        "metal_rate": selectedAccount?.todaysRate, // can get from account data
        "metal_weight": (selectedAccount?.schemeType != 0 ||
                selectedAccount?.convertToWeight == true)
            ? (totalReceivedAmount.value / (selectedAccount?.todaysRate ?? 1))
                .toStringAsFixed(2)
            : 0, // calculated
        "net_amount": totalReceivedAmount.value, //input
        "paid_through": 3, // static for collection app
        "payment_amount": totalReceivedAmount.value, // input
        "payment_charges": 0, //static
        "payment_mode_details": paymentModes.toList(),
        "payment_status": 1, // static
        "ref_trans_id": null, // static
        "tax_amount": 0, // static
        "tax_id": null, // static
        "tax_type": 3, // static
        "total_net_amount": totalReceivedAmount.value, //input
        "trans_date":
            DateTime.now().toIso8601String().split('T')[0], // today’s date
        "trans_id": null, // static
        "is_collection_agent_user": true,
      }
    ];

    Response? response = await schemePaymentRepo.createPayment(body);

    _isLoading = false;
    loaderController.showLoaderAfterBuild(_isLoading);
    if (response != null && response.statusCode == 201) {
      Get.snackbar(
        'Success',
        'Payment created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.find<CollectionDashboardController>().getCollectionDashboardCount();

      Get.back();
      Get.toNamed('/chit-collection-report');
    } else {
      Get.snackbar(
        'Error',
        response?.body['message'] ?? 'Failed to create payment',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    }

    update();
  }

  Widget buildBranchDropdown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Select Branch',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          value: selectedBranchId,
          items: branchModel?.data?.map((branch) {
            return DropdownMenuItem<int>(
              value: branch.idBranch,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(branch.name ?? ''),
              ),
            );
          }).toList(),
          onChanged: (value) {
            selectedBranchId = value;
            selectedBranchName =
                branchModel?.data?.firstWhere((b) => b.idBranch == value).name;
            update();
          },
          icon: const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ),
    );
  }
}
