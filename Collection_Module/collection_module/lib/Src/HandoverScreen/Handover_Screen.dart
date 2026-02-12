import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/widgets/custom_app_bar.dart';
import 'controller/Handover_Controller.dart';

class HandoverScreen extends StatefulWidget {
  const HandoverScreen({super.key});

  @override
  State<HandoverScreen> createState() => _HandoverScreenState();
}

class _HandoverScreenState extends State<HandoverScreen> {
  @override
  void initState() {
    super.initState();
    final controller = Get.find<HandoverController>();
    // Set default date to today
    controller.setHandoverDate(DateTime.now());
    // Load data for today
    controller.getModeWiseSummaryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'HAND OVER CODE',
          isBackButtonExist: true,
        ),
      ),
      body: GetBuilder<HandoverController>(
        builder: (controller) {
          final data = controller.modeWIseSummaryModel?.data;
          final bool isHandoverRequired =
              !(data?.isHandoverReq ?? false) && !(data?.isCollected ?? false);
          final String handoverCode = data?.handoverOtp ?? '000000';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Date Picker Field
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate:
                            controller.selectedHandoverDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF8D3D5B),
                                onPrimary: Colors.white,
                                onSurface: Colors.black,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (picked != null) {
                        controller.setHandoverDate(picked);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.selectedHandoverDate != null
                                ? DateFormat('dd MMM yyyy')
                                    .format(controller.selectedHandoverDate!)
                                : 'Select Date',
                            style: TextStyle(
                              fontSize: 14,
                              color: controller.selectedHandoverDate != null
                                  ? Colors.black87
                                  : Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Get Details Button
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: controller.isLoading
                          ? null
                          : () async {
                              await controller.getModeWiseSummaryList();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8D3D5B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 1,
                      ),
                      child: controller.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Get Details',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Show content only if data is loaded
                  if (controller.modeWIseSummaryModel == null ||
                      controller.modeWIseSummaryModel?.data == null)
                    const SizedBox.shrink()
                  else ...[
                    // Summary Cards
                    _buildSummaryCard(
                      title: 'Chit Collection',
                      amount: (data!.chitCollection ?? 0).toDouble(),
                      icon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 16),

                    _buildSummaryCard(
                      title: 'Credit Collection',
                      amount: (data.creditCollection ?? 0).toDouble(),
                      icon: Icons.credit_card,
                    ),
                    const SizedBox(height: 24),

                    // Mode Wise Collection Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Mode Wise Collection',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8D3D5B),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Total: ₹${_formatAmount((data.totalCollectedAmount ?? 0).toDouble())}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Mode Wise Collection Cards - Dynamic from API
                    if (data.modeWiseCollections != null &&
                        data.modeWiseCollections!.isNotEmpty)
                      ...data.modeWiseCollections!.map((mode) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildModeCard(
                            title: mode.modeName ?? 'Unknown',
                            amount: (mode.amount ?? 0).toDouble(),
                          ),
                        );
                      }).toList()
                    else
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'No payments',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),

                    const SizedBox(height: 32),

                    if (isHandoverRequired)
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'Your Handover Code',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // 6-Digit Code Display
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ...handoverCode.split('').map((digit) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    width: 48,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.2),
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        digit,
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                            const SizedBox(height: 16),

                            Text(
                              'Share this code with the recipient',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),

                    // Handover Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: controller.isLoading
                            ? null
                            : () async {
                                await controller.generateHandoverOTP();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8D3D5B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: controller.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Handover Amount',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              icon,
              color: Colors.black,
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${_formatAmount(amount)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeCard({
    required String title,
    required double amount,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            '₹${_formatAmount(amount)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    // Format with commas (Indian numbering system)
    final formatter = NumberFormat('#,##,###.##', 'en_IN');
    return formatter.format(amount);
  }
}
