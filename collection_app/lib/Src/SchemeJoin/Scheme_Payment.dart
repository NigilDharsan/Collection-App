// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tn_jewellery_admin/features/CollectionApp/SchemeJoin/controller/Scheme_Payment_Controller.dart';
// import 'package:tn_jewellery_admin/features/CollectionApp/SchemeJoin/model/Customer_Account_Model.dart';
// import 'package:tn_jewellery_admin/utils/widgets/custom_app_bar.dart';

// class SchemePayment extends StatefulWidget {
//   const SchemePayment({super.key});

//   @override
//   State<SchemePayment> createState() => _SchemePaymentState();
// }

// class _SchemePaymentState extends State<SchemePayment> {
//   final schemeController = Get.find<SchemePaymentController>();

//   final TextEditingController _customerSearchController =
//       TextEditingController();

//   bool _showCustomerDropdown = false;

//   @override
//   void dispose() {
//     _customerSearchController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(50),
//         child: CustomAppBar(
//           title: 'Scheme Payment',
//           isBackButtonExist: true,
//         ),
//       ),
//       body: GetBuilder<SchemePaymentController>(
//         builder: (controller) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Customer Field
//                 _buildLabel('Customer', isRequired: true),
//                 const SizedBox(height: 8),
//                 _buildCustomerSearchField(controller),
//                 const SizedBox(height: 5),
//                 if (controller.customerAccountList.isNotEmpty)
//                   _buildAccountDropdown(controller),

//                 const SizedBox(height: 20),

//                 // here build the right‑side “Payment Breakdown” etc.
//                 _buildPaymentSummary(controller),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPaymentSummary(SchemePaymentController controller) {
//     final acc = controller.selectedAccount;
//     if (acc == null) {
//       return const SizedBox.shrink();
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Can pay?
//         Row(
//           children: [
//             const Text('Can pay? :  '),
//             Text(
//               controller.canPayText ?? '',
//               style: const TextStyle(
//                   color: Colors.green, fontWeight: FontWeight.w600),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),

//         // Min Payable Amount
//         Row(
//           children: [
//             const Text('Min Payable Amount :  '),
//             Expanded(
//               child: TextFormField(
//                 enabled: false,
//                 initialValue: controller.minPayableAmountText ?? '',
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(height: 16),

//         // Example: Today’s rate from account
//         Row(
//           children: [
//             const Text('Today\'s Rate :  '),
//             Expanded(
//               child: TextFormField(
//                 enabled: false,
//                 initialValue: controller.todaysRateText ?? '',
//               ),
//             ),
//           ],
//         ),

//         // Continue: amount, weight, total weight, net amount,
//         // tax amount, balance etc. using acc fields.
//       ],
//     );
//   }

//   Widget _buildAccountDropdown(SchemePaymentController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildLabel('Scheme A/C No', isRequired: true),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<CustomerAccountData>(
//           isExpanded: true,
//           value: controller.selectedAccount,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           ),
//           hint: const Text('Select scheme account'),
//           items: controller.customerAccountList
//               .map((acc) => DropdownMenuItem<CustomerAccountData>(
//                     value: acc,
//                     child: Text(acc.forSearch ?? ''),
//                   ))
//               .toList(),
//           onChanged: (val) {
//             if (val != null) {
//               controller.selectAccount(val);
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildLabel(String text, {bool isRequired = false}) {
//     return Row(
//       children: [
//         Text(
//           text,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         if (isRequired)
//           const Text(
//             '*',
//             style: TextStyle(
//               color: Colors.red,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildCustomerSearchField(SchemePaymentController controller) {
//     return Column(
//       children: [
//         TextField(
//           controller: _customerSearchController,
//           decoration: InputDecoration(
//             hintText: 'Choose a customer...',
//             hintStyle: TextStyle(color: Colors.grey[400]),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Colors.grey[300]!),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(color: Theme.of(context).primaryColor),
//             ),
//             suffixIcon: controller.selectedCustomerId != null
//                 ? IconButton(
//                     icon: const Icon(Icons.clear),
//                     onPressed: () {
//                       setState(() {
//                         _customerSearchController.clear();
//                         _showCustomerDropdown = false;
//                       });
//                       controller.clearSelection();
//                       controller.clearSchemeSelection();
//                     },
//                   )
//                 : null,
//           ),
//           onChanged: (value) {
//             if (value.length >= 3) {
//               controller.customerList(mobNum: value);
//               setState(() {
//                 _showCustomerDropdown = true;
//               });
//             } else {
//               setState(() {
//                 _showCustomerDropdown = false;
//               });
//               controller.clearOldSelection();
//             }
//           },
//           readOnly: controller.selectedCustomerId != null,
//         ),
//         if (_showCustomerDropdown && controller.searchResults.isNotEmpty)
//           Container(
//             margin: const EdgeInsets.only(top: 4),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey[300]!),
//               borderRadius: BorderRadius.circular(8),
//               color: Colors.white,
//             ),
//             constraints: const BoxConstraints(maxHeight: 200),
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: controller.searchResults.length,
//               itemBuilder: (context, index) {
//                 final customer = controller.searchResults[index];
//                 return ListTile(
//                   title: Text(customer.firstname ?? ''),
//                   subtitle: Text(customer.mobile ?? ''),
//                   onTap: () {
//                     setState(() {
//                       _customerSearchController.text =
//                           ' ${customer.firstname}- ${customer.mobile}';
//                       _showCustomerDropdown = false;
//                     });
//                     controller.selectedCustomerId = customer.value;
//                     controller.selectedCustomerName = customer.firstname;
//                     controller.selectedCustomerMobile = customer.mobile;
//                     controller.update();
//                     // Load customer accounts for selected customer
//                     controller.getCustomerAccountsList(customer.value!);
//                   },
//                 );
//               },
//             ),
//           ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/widgets/custom_app_bar.dart';
import 'controller/Scheme_Payment_Controller.dart';
import 'model/Customer_Account_Model.dart';


class SchemePayment extends StatefulWidget {
  const SchemePayment({super.key});

  @override
  State<SchemePayment> createState() => _SchemePaymentState();
}

class _SchemePaymentState extends State<SchemePayment> {
  final schemeController = Get.find<SchemePaymentController>();

  final TextEditingController _customerSearchController =
      TextEditingController();
  final TextEditingController _entryDateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _advanceController =
      TextEditingController(text: '1');

  bool _showCustomerDropdown = false;

  @override
  void initState() {
    super.initState();
    // Set today's date
    _entryDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  void dispose() {
    _customerSearchController.dispose();
    _entryDateController.dispose();
    _amountController.dispose();
    _weightController.dispose();
    _advanceController.dispose();
    schemeController.advanceInstallment.value = 1;
    schemeController.paymentModes.clear();
    schemeController.selectedAccount = null;
    schemeController.customerAccountList.clear();
    schemeController.clearSelection();
    schemeController.clearOldSelection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Scheme Payment',
          isBackButtonExist: true,
        ),
      ),
      body: GetBuilder<SchemePaymentController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Customer', isRequired: true),
                const SizedBox(height: 8),
                _buildCustomerSearchField(controller),

                const SizedBox(height: 20),
                // Second Row - Scheme Account and Branch
                controller.customerAccountList.isNotEmpty
                    ? _buildAccountDropdown(controller)
                    : const SizedBox.shrink(),
                const SizedBox(height: 20),

                controller.customerAccountList.isNotEmpty
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Select Branch
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Branch'),
                                const SizedBox(height: 8),
                                controller.buildBranchDropdown(),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Today's Rate
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel(
                                  'Rate',
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  enabled: false,
                                  initialValue:
                                      controller.todaysRateText ?? '0',
                                  key: ValueKey(
                                      '${controller.selectedAccount?.idSchemeAccount}_rate'),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    fillColor: Colors.grey[50],
                                    filled: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                // Divider
                const Divider(thickness: 0.2),
                const SizedBox(height: 10),

                // Payment Details Section
                if (controller.selectedAccount != null)
                  _buildPaymentDetailsSection(controller),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentDetailsSection(SchemePaymentController controller) {
    final acc = controller.selectedAccount!;
    final schemeType = acc.schemeType ?? 0;
    final showAmount = schemeType == 0 || schemeType == 2;
    final int maxValue = (acc.advanceMonths == null || acc.advanceMonths == 0)
        ? 1
        : acc.advanceMonths!;

    void _onAccountChanged(CustomerAccountData acc) {
      final int maxValue = (acc.advanceMonths == null || acc.advanceMonths == 0)
          ? 1
          : acc.advanceMonths!;
      _advanceController.text = '1'; // default
      controller.advanceInstallment.value = 1;
      // store maxValue in state if needed
      controller.calculatePaymentBreakdown(
        amount: _amountController.text,
        weight: _weightController.text,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row 1: Can Pay and Advance
        Row(
          children: [
            Expanded(
              child: _buildInfoField(
                'Can pay ?',
                controller.canPayText ?? 'No',
                valueColor: (acc.allowPay ?? false) ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Advance', isRequired: false),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          int currentValue =
                              int.tryParse(_advanceController.text) ?? 1;
                          if (currentValue > 1) {
                            setState(() {
                              _advanceController.text =
                                  (currentValue - 1).toString();
                            });
                            controller.advanceInstallment.value =
                                currentValue - 1;
                            controller.calculatePaymentBreakdown(
                              amount: _amountController.text,
                              weight: _weightController.text,
                            );
                          }
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                        color: Colors.red,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _advanceController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          int currentValue =
                              int.tryParse(_advanceController.text) ?? 1;
                          int maxValue = (acc.advanceMonths == null ||
                                  acc.advanceMonths == 0)
                              ? 1
                              : acc.advanceMonths!;
                          if (currentValue < maxValue) {
                            setState(() {
                              _advanceController.text =
                                  (currentValue + 1).toString();
                            });
                            controller.advanceInstallment.value =
                                currentValue + 1;
                            controller.calculatePaymentBreakdown(
                              amount: _amountController.text,
                              weight: _weightController.text,
                            );
                          }
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Row 2: Min and Max Payable
        Row(
          children: [
            Expanded(
              child: _buildInfoField(
                showAmount ? 'Min Payable Amount' : 'Min Payable Weight',
                showAmount
                    ? (acc.minimumPayable?.minAmount?.toStringAsFixed(0) ?? '0')
                    : (acc.minimumPayable?.minWeight?.toStringAsFixed(3) ??
                        '0.000'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoField(
                showAmount ? 'Max Payable Amount' : 'Max Payable Weight',
                showAmount
                    ? (acc.maximumPayable?.maxAmount?.toStringAsFixed(0) ?? '0')
                    : (acc.maximumPayable?.maxWeight?.toStringAsFixed(3) ??
                        '0.000'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),

        // Payment Breakdown Title
        const Text(
          'Payment Breakdown ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),

        // Row 3: Amount and Weight
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Amount', isRequired: false),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                    ),
                    onChanged: (value) {
                      controller.calculatePaymentBreakdown(
                        amount: value,
                        weight: _weightController.text,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Weight', isRequired: false),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '0',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                    ),
                    onChanged: (value) {
                      controller.calculatePaymentBreakdown(
                        amount: _amountController.text,
                        weight: value,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Row 5: Discount and Net Amount
        Row(
          children: [
            Expanded(
              child: _buildInfoField(
                'Discount',
                controller.discountAmount ?? '0.00',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoField(
                'Net Amount',
                controller.netAmount ?? '0.00',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Row 6: Received and Total Net Payment

        // vishnu asked to hide this
        // Row(
        //   children: [
        //     Expanded(
        //       child: _buildInfoField(
        //         'Received',
        //         controller.receivedAmount ?? '0.00',
        //       ),
        //     ),
        //     const SizedBox(width: 16),
        //     Expanded(
        //       child: _buildInfoField(
        //         'Total Net Payment',
        //         controller.totalNetPayment ?? '0.00',
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 16),

        // Row 7: Tax Amount and Balance
        Row(
          children: [
            Expanded(
              child: _buildInfoField(
                'Tax Amount',
                controller.taxAmount ?? '0.00',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildInfoField(
                'Balance',
                controller.balance ?? '0.00',
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Total Summary Card
        Container(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Discount',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    '₹0.00',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Received',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Obx(() => Text(
                        '₹${controller.totalReceivedAmount.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Payment Details Section
        (acc.allowPay ?? false) == true
            ? Obx(() => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Payment Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6C63FF), Color(0xFF5A52D5)],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  controller.showAddPaymentDialog(context);
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Add Payment',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Display added payment modes
                      if (controller.paymentModes.isEmpty)
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.payment,
                                  size: 48,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'No payment modes added',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ...controller.paymentModes.asMap().entries.map((entry) {
                          int index = entry.key;
                          var payment = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildPaymentModeCard(
                                payment, index, controller),
                          );
                        }).toList(),
                      const SizedBox(height: 24),

                      if (controller.paymentModes.isNotEmpty)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.createPayment();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1565C0),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Submit Payment',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ))
            : SizedBox.shrink(),

        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildInfoField(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[50],
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: valueColor ?? Colors.black87,
              fontWeight:
                  valueColor != null ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountDropdown(SchemePaymentController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(
          'Scheme A/C No',
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<CustomerAccountData>(
          isExpanded: true,
          value: controller.selectedAccount,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          hint: const Text('Select scheme account'),
          items: controller.customerAccountList
              .map((acc) => DropdownMenuItem<CustomerAccountData>(
                    value: acc,
                    child: Text(acc.forSearch ?? ''),
                  ))
              .toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() {
                controller.selectAccount(val);
                // Reset amount and weight fields
                _amountController.clear();
                _weightController.clear();

                controller.calculatePaymentBreakdown(
                  amount: '',
                  weight: '',
                );
                controller.paymentModes.clear();
                _advanceController.text = '1';
                controller.advanceInstallment.value = 1;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        if (isRequired)
          const Text(
            ' *',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget _buildCustomerSearchField(SchemePaymentController controller) {
    return Column(
      children: [
        TextField(
          controller: _customerSearchController,
          decoration: InputDecoration(
            hintText: 'Choose a customer...',
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            suffixIcon: controller.selectedCustomerId != null
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _customerSearchController.clear();
                        _showCustomerDropdown = false;
                        _amountController.clear();
                        _weightController.clear();
                        _advanceController.clear();
                        controller.advanceInstallment.value = 1;
                      });
                      controller.clearSelection();
                      controller.clearSchemeSelection();
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            if (value.length >= 3) {
              controller.customerList(mobNum: value);
              setState(() {
                _showCustomerDropdown = true;
              });
            } else {
              setState(() {
                _showCustomerDropdown = false;
              });
              controller.clearOldSelection();
            }
          },
          readOnly: controller.selectedCustomerId != null,
        ),
        if (_showCustomerDropdown && controller.searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.searchResults.length,
              itemBuilder: (context, index) {
                final customer = controller.searchResults[index];
                return ListTile(
                  title: Text(customer.firstname ?? ''),
                  subtitle: Text(customer.mobile ?? ''),
                  onTap: () {
                    setState(() {
                      _customerSearchController.text =
                          '${customer.firstname} - ${customer.mobile}';
                      _showCustomerDropdown = false;
                    });
                    controller.selectedCustomerId = customer.value;
                    controller.selectedCustomerName = customer.firstname;
                    controller.selectedCustomerMobile = customer.mobile;
                    controller.update();
                    // Load customer accounts for selected customer
                    controller.getCustomerAccountsList(customer.value!);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}

Widget _buildPaymentModeCard(Map<String, dynamic> payment, int index,
    SchemePaymentController controller) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          const Color(0xFF6C63FF).withOpacity(0.05),
          const Color(0xFF5A52D5).withOpacity(0.02),
        ],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getPaymentIcon(payment['short_code']),
                      color: const Color(0xFF6C63FF),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          payment['short_code'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        Text(
                          '₹${payment['payment_amount']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6C63FF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                controller.removePaymentMode(index);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
                size: 20,
              ),
            ),
          ],
        ),
        if (payment['details'] != null && payment['details'].isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: payment['details'].entries.map<Widget>((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "${entry.value}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    ),
  );
}

IconData _getPaymentIcon(String mode) {
  switch (mode.toLowerCase()) {
    case 'cash':
      return Icons.money;
    case 'card':
      return Icons.credit_card;
    case 'upi':
      return Icons.qr_code;
    case 'net banking':
      return Icons.account_balance;
    default:
      return Icons.payment;
  }
}
