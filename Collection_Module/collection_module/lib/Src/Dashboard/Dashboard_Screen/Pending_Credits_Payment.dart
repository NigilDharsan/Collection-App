import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../controller/Collection_Dashboard_Controller.dart';

class PendingCreditsPayment extends StatefulWidget {
  const PendingCreditsPayment({super.key});

  @override
  State<PendingCreditsPayment> createState() => _PendingCreditsPaymentState();
}

class _PendingCreditsPaymentState extends State<PendingCreditsPayment> {
  final collectionController = Get.find<CollectionDashboardController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    collectionController.clearAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Credits Payment'),
      ),
      body: GetBuilder<CollectionDashboardController>(
        initState: (state) {
          collectionController
              .getCustomerCreditDueList(collectionController.credit.customerId);
        },
        builder: (controller) {
          return controller.isLoading.value
              ? const SizedBox.shrink()
              : Obx(() {
                  return KeyboardActions(
                    config: KeyboardActionsConfig(
                      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                      actions: [
                        KeyboardActionsItem(
                          focusNode: controller.discountAmountFocusNode,
                          onTapAction: () {
                            controller.discountAmountFocusNode.unfocus();
                          },
                          toolbarButtons: [
                            (node) {
                              return TextButton(
                                onPressed: () => node.unfocus(),
                                child: Text("Done"),
                              );
                            },
                          ],
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with Avatar and Name
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xFF1565C0),
                                  child: controller.credit.image != null &&
                                          controller.credit.image!.isNotEmpty
                                      ? ClipOval(
                                          child: Image.network(
                                            controller.credit.image!,
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return _buildAvatarText(
                                                  controller.credit.imageText ??
                                                      controller.credit.name ??
                                                      'U');
                                            },
                                          ),
                                        )
                                      : _buildAvatarText(
                                          controller.credit.imageText ??
                                              controller.credit.name ??
                                              'U'),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.credit.name ?? 'Unknown',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'JosefinSans',
                                        ),
                                      ),
                                      Text(
                                        controller.credit.mobile ?? '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                          fontFamily: 'JosefinSans',
                                        ),
                                      ),
                                      Text(
                                        controller.credit.areaName ?? '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                          fontFamily: 'JosefinSans',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Update the Design here

                            if (controller.customerDueListModel!.data != null &&
                                controller
                                    .customerDueListModel!.data!.isNotEmpty)
                              ...controller.customerDueListModel!.data!
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key;
                                var creditItem = entry.value;

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFF6C63FF)
                                            .withOpacity(0.05),
                                        const Color(0xFF5A52D5)
                                            .withOpacity(0.02),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFF6C63FF)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      // Header with Bill Info
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF6C63FF)
                                              .withOpacity(0.1),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  creditItem.billNo ?? '-',
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFF1A1A1A),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Bill Date: ${creditItem.billDate ?? '-'}',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                '₹${creditItem.balanceAmount?.toStringAsFixed(2) ?? '0.00'}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Editable Fields
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            // Discount Row
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Discount',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[700],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color: const Color(
                                                                0xFF6C63FF)
                                                            .withOpacity(0.3),
                                                      ),
                                                    ),
                                                    child: TextField(
                                                      controller: controller
                                                          .getDiscountController(
                                                              index),
                                                      textAlign:
                                                          TextAlign.right,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText: '₹0.00',
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          horizontal: 12,
                                                          vertical: 12,
                                                        ),
                                                      ),
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFF6C63FF),
                                                      ),
                                                      onChanged: (value) {
                                                        controller
                                                            .calculateItemAmounts(
                                                                index,
                                                                creditItem);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 12),

                                            // Received Amount Row
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Received Amount',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[700],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color: const Color(
                                                                0xFF6C63FF)
                                                            .withOpacity(0.3),
                                                      ),
                                                    ),
                                                    child: TextField(
                                                      controller: controller
                                                          .getReceivedController(
                                                              index),
                                                      textAlign:
                                                          TextAlign.right,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText: '₹0.00',
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          horizontal: 12,
                                                          vertical: 12,
                                                        ),
                                                      ),
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFF1A1A1A),
                                                      ),
                                                      onChanged: (value) {
                                                        controller
                                                            .updateTotalReceived();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),

                            const SizedBox(height: 16),

                            // Total Summary Card
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF6C63FF),
                                    Color(0xFF5A52D5)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF6C63FF)
                                        .withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total Discount',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Obx(() => Text(
                                            '₹${controller.totalDiscount.value.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                            Container(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            colors: [
                                              Color(0xFF6C63FF),
                                              Color(0xFF5A52D5)
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              controller.showAddPaymentDialog(
                                                  context, controller.credit);
                                            },
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                        border: Border.all(
                                            color: Colors.grey[200]!),
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
                                    ...controller.paymentModes
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      int index = entry.key;
                                      var payment = entry.value;
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: _buildPaymentModeCard(
                                            payment, index, controller),
                                      );
                                    }).toList(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            if (controller.paymentModes.isNotEmpty)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.submitBillingDetails();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1565C0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
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
                            const SizedBox(height: 24),

                            // Close Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1565C0),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  );
                });
        },
      ),
    );
  }
}

Widget _detailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontFamily: 'JosefinSans',
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'JosefinSans',
          ),
        ),
      ],
    ),
  );
}

Widget buildDiscountRow(
    String label, String amount, CollectionDashboardController controller) {
  return Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.3)),
        ),
        child: TextField(
          controller: controller.discountAmountController,
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: '₹0.00',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6C63FF)),
        ),
      )
    ],
  );
}

Widget _buildAvatarText(String text) {
  return Text(
    text.isNotEmpty ? text[0].toUpperCase() : 'U',
    style: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _buildPaymentModeCard(Map<String, dynamic> payment, int index,
    CollectionDashboardController controller) {
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
