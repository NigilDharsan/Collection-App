import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/BillingController.dart';

Widget buildAmountSummarySection(BillingController controller) {
  return Obx(() => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Amount Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                Spacer(),
                Obx(() => Switch(
                    value: controller.isSettingbilltype.value,
                    onChanged: (value) {
                      controller.isSettingbilltype.value = value;
                    }))
              ],
            ),
            const SizedBox(height: 16),

            // Bill Amount (Non-editable)
            _buildAmountRowNonEditable(
              'Bill Amount',
              '₹${controller.billAmount.value.toStringAsFixed(2)}',
              controller.billAmount.value >= 0 ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 12),

            // Discount Amount (Calculated)
            _buildAmountRowNonEditable(
              'Discount Amount',
              '₹${controller.discountAmount.value.toStringAsFixed(2)}',
              controller.discountAmount.value >= 0
                  ? Colors.orange
                  : Colors.green,
            ),
            const SizedBox(height: 12),

            // Net Amount (Editable with restrictions)
            _buildNetAmountRow(controller),
            const SizedBox(height: 12),

            // Received Amount or Refund Amount
            if (controller.billAmount.value >= 0)
              _buildReceivedAmountRow(controller)
            else
              _buildRefundAmountRow(controller),

            // Payment Summary
            if (controller.paymentModes.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Paid',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    '₹${controller.totalPaidAmount.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6C63FF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Remaining',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    '₹${controller.remainingAmount.value.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: controller.remainingAmount.value > 0
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ));
}

Widget _buildAmountRowNonEditable(
    String label, String amount, Color? textColor) {
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
      Text(
        amount,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor ?? const Color(0xFF1A1A1A),
        ),
      ),
    ],
  );
}

Widget _buildNetAmountRow(BillingController controller) {
  return Row(
    children: [
      Expanded(
        child: Text(
          'Net Amount',
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
          controller: controller.netAmountController,
          focusNode: controller.netAmountFocusNode, // ← IMPORTANT
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          onEditingComplete: () {
            print("object");
          },
          onSubmitted: (value) {
            double enteredValue = double.tryParse(value) ?? 0.0;

            if (controller.billAmount.value >= 0) {
              if (enteredValue > controller.billAmount.value) {
                controller.netAmountController.text =
                    controller.billAmount.value.toStringAsFixed(2);
                Get.snackbar(
                  'Invalid Amount',
                  'Net amount cannot be greater than bill amount',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                );
              } else {
                controller.netAmount.value = enteredValue;

                double enteredNetAmount = controller.netAmount.value;

                controller.discountAmount.value =
                    controller.billAmount.value - enteredNetAmount;

                controller.calculateItemDetails();
              }
            }
          },
          decoration: const InputDecoration(
            hintText: '₹0.00',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6C63FF),
          ),
        ),
      ),
    ],
  );
}

Widget _buildReceivedAmountRow(BillingController controller) {
  return Obx(() => Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  'Received Amount',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                    value: controller.isReceivedAmountEditable.value,
                    onChanged: (value) {
                      controller.isReceivedAmountEditable.value = value!;
                    },
                    activeColor: const Color(0xFF6C63FF),
                  ),
                ),
                Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 150,
            decoration: BoxDecoration(
              color: controller.isReceivedAmountEditable.value
                  ? Colors.grey[100]
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: controller.isReceivedAmountEditable.value
                    ? const Color(0xFF6C63FF).withOpacity(0.3)
                    : Colors.grey[300]!,
              ),
            ),
            child: TextField(
              controller: controller.receivedAmountController,
              enabled: controller.isReceivedAmountEditable.value,
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                double enteredValue = double.tryParse(value) ?? 0.0;

                // Validation: Received amount cannot be greater than net amount
                if (enteredValue > controller.netAmount.value) {
                  controller.receivedAmountController.text =
                      controller.netAmount.value.toStringAsFixed(2);
                  Get.snackbar(
                    'Invalid Amount',
                    'Received amount cannot be greater than net amount',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                  );
                } else {
                  controller.receivedAmount.value = enteredValue;
                  controller.calculateTotalPaid();
                }
              },
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
                color: controller.isReceivedAmountEditable.value
                    ? const Color(0xFF6C63FF)
                    : Colors.grey[500],
              ),
            ),
          ),
        ],
      ));
}

Widget _buildRefundAmountRow(BillingController controller) {
  return Obx(() => Row(
        children: [
          Expanded(
            child: Text(
              'Refund Amount',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 150,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red[200]!),
            ),
            child: Text(
              '₹${controller.refundAmount.value.toStringAsFixed(2)}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ));
}
