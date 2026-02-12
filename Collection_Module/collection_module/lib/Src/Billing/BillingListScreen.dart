import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/core/helper/route_helper.dart';
import 'controller/BillingController.dart';

class BillingListScreen extends StatefulWidget {
  const BillingListScreen({Key? key}) : super(key: key);

  @override
  State<BillingListScreen> createState() => _BillingListScreenState();
}

class _BillingListScreenState extends State<BillingListScreen> {
  final BillingController controller = Get.find<BillingController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializeBillingList();
    });

    // Add scroll listener for load more
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more when user is 200px from bottom
      controller.loadMoreBillings();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Billing List',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color(0xFF6C63FF)),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteHelper.getBillCreateScreen());
        },
        backgroundColor: Colors.green,
        tooltip: 'Clear Filters',
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.allBillingData.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF6C63FF),
                  ),
                );
              }

              if (controller.allBillingData.isEmpty) {
                return _buildEmptyState();
              }

              return RefreshIndicator(
                onRefresh: () => controller.refreshBillingList(),
                color: const Color(0xFF6C63FF),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.allBillingData.length + 1,
                  itemBuilder: (context, index) {
                    if (index == controller.allBillingData.length) {
                      // Show loading indicator at bottom or "No more data" message
                      return _buildBottomLoader();
                    }
                    final item = controller.allBillingData[index];
                    return _buildBillingCard(item, index);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomLoader() {
    return Obx(() {
      if (controller.isLoadingMore.value) {
        return Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: Color(0xFF6C63FF),
          ),
        );
      }

      if (controller.hasMoreData.value) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.grey[400],
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'No more records',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Total: ${controller.allBillingData.length} records',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildFilterChips() {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(
                        icon: Icons.calendar_today,
                        label: controller.getDateRangeText(),
                        onTap: () => _showDateRangePicker(context),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        icon: Icons.store,
                        label: controller.getSelectedBranchesText(),
                        onTap: () => _showBranchSelector(context),
                      ),
                      if (controller.allBillingData.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        _buildInfoChip(
                          icon: Icons.receipt_long,
                          label: '${controller.allBillingData.length} records',
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (controller.hasActiveFilters()) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: controller.clearFilters,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red[50],
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ],
          ),
        ));
  }

  Widget _buildFilterChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF6C63FF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: const Color(0xFF6C63FF)),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6C63FF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.green),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingCard(dynamic item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showBillingDetails(item),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.invNo ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.branchName ?? 'N/A',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildInvoiceTypeBadge(item.invNo ?? ''),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(
                        Icons.person_outline,
                        item.customerName ?? 'N/A',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoRow(
                        Icons.phone_outlined,
                        item.customerMobile ?? 'N/A',
                      ),
                    ),
                    Expanded(
                      child: _buildInfoRow(
                        Icons.access_time,
                        item.date ?? 'N/A',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceTypeBadge(String invNo) {
    String type = 'SA';
    Color color = const Color(0xFF6C63FF);
    String label = 'Sales';

    if (invNo.startsWith('PU')) {
      type = 'PU';
      color = Colors.orange;
      label = 'Purchase';
    } else if (invNo.startsWith('SA')) {
      type = 'SA';
      color = const Color(0xFF6C63FF);
      label = 'Sales';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No Billing Records Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Filters'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading:
                  const Icon(Icons.calendar_today, color: Color(0xFF6C63FF)),
              title: const Text('Date Range'),
              onTap: () {
                Navigator.pop(context);
                _showDateRangePicker(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.store, color: Color(0xFF6C63FF)),
              title: const Text('Select Branches'),
              onTap: () {
                Navigator.pop(context);
                _showBranchSelector(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showDateRangePicker(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: DateTimeRange(
        start: controller.fromDate.value,
        end: controller.toDate.value,
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6C63FF),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.updateDateRange(picked.start, picked.end);
    }
  }

  void _showBranchSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Select Branches'),
        content: Obx(() => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: controller.availableBranches.map((branch) {
                  final isSelected =
                      controller.selectedBranches.contains(branch.idBranch);
                  return CheckboxListTile(
                    title: Text(branch.name ?? 'Unnamed Branch'),
                    value: isSelected,
                    activeColor: const Color(0xFF6C63FF),
                    onChanged: (bool? value) {
                      controller.toggleBranchSelection(branch.idBranch ?? 0);
                    },
                  );
                }).toList(),
              ),
            )),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              controller.applyBranchFilter();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
            ),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showBillingDetails(dynamic item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.invNo ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      _buildInvoiceTypeBadge(item.invNo ?? ''),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow('Branch', item.branchName ?? 'N/A'),
                  _buildDetailRow('Customer', item.customerName ?? 'N/A'),
                  _buildDetailRow('Mobile', item.customerMobile ?? 'N/A'),
                  _buildDetailRow('Date & Time', item.date ?? 'N/A'),
                  _buildDetailRow(
                      'Invoice ID', item.erpInvoiceId?.toString() ?? 'N/A'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
