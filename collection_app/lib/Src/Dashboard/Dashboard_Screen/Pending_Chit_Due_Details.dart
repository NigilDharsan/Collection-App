import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/widgets/custom_app_bar.dart';
import '../Model/PendingChitDueDetailsModel.dart';
import '../controller/Collection_Dashboard_Controller.dart';

class PendingChitDueDetails extends StatefulWidget {
  const PendingChitDueDetails({super.key});

  @override
  State<PendingChitDueDetails> createState() => _PendingChitDueDetailsState();
}

class _PendingChitDueDetailsState extends State<PendingChitDueDetails> {
  final collectionController = Get.find<CollectionDashboardController>();
  final TextEditingController _searchController = TextEditingController();
  int? areaId;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    areaId = args?['areaId'] ?? 0;

    if (areaId != null && areaId! > 0) {
      collectionController.getAreaWisePendingChitDueDetails(areaId!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    collectionController.clearAllData();
    super.dispose();
  }

  List<Data> _filterDues(List<Data> dues) {
    if (_searchQuery.isEmpty) {
      return dues;
    }
    return dues.where((due) {
      final mobile = due.mobile?.toLowerCase() ?? '';
      final name = due.name?.toLowerCase() ?? '';
      final query = _searchQuery.toLowerCase();
      return mobile.contains(query) || name.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Pending Chit-Due Details',
          isBackButtonExist: true,
        ),
      ),
      body: GetBuilder<CollectionDashboardController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final allDues = controller.pendingChitDueDetailsModel?.data ?? [];
          final filteredDues = _filterDues(allDues);

          if (allDues.isEmpty) {
            return const Center(
              child: Text(
                'No pending chit-dues found',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              if (areaId != null && areaId! > 0) {
                await controller.getAreaWisePendingChitDueDetails(areaId!);
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    _buildSearchBar(),
                    const SizedBox(height: 16),

                    // Summary Card
                    _buildSummaryCard(filteredDues),
                    const SizedBox(height: 20),

                    // No results message
                    if (filteredDues.isEmpty && _searchQuery.isNotEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text(
                            'No customers found matching your search',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      )
                    else
                      // Chit Table
                      _buildChitTable(filteredDues),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search by mobile number or name...',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            fontFamily: 'JosefinSans',
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[600],
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'JosefinSans',
        ),
      ),
    );
  }

  Widget _buildSummaryCard(List<Data> dues) {
    final totalAmount = dues.fold<double>(
      0.0,
      (sum, item) => sum + ((item.payableAmount ?? 0).toDouble()),
    );

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _summaryItem('Total Chits', '${dues.length}', Icons.description),
          Container(
            width: 1,
            height: 30,
            color: Colors.white.withOpacity(0.3),
          ),
          _summaryItem(
            'Total Amount',
            '₹${_formatAmount(totalAmount)}',
            Icons.account_balance_wallet,
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'JosefinSans',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'JosefinSans',
          ),
        ),
      ],
    );
  }

  Widget _buildChitTable(List<Data> dues) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: const Row(
              children: [
                Expanded(flex: 3, child: _TableHeaderCell('Customer')),
                Expanded(flex: 3, child: _TableHeaderCell('Scheme / A/c')),
                Expanded(flex: 2, child: _TableHeaderCell('Amount')),
              ],
            ),
          ),
          // Rows
          ...dues.asMap().entries.map((entry) {
            final index = entry.key;
            final due = entry.value;
            final isLast = index == dues.length - 1;
            return _buildChitRow(due, isLast);
          }),
        ],
      ),
    );
  }

  Widget _buildChitRow(Data due, bool isLast) {
    return InkWell(
      onTap: () => _showChitDetails(due),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(color: Colors.grey[200]!, width: 1),
                ),
          borderRadius: isLast
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )
              : null,
          color: Colors.white,
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFF1565C0),
              child: due.image != null && due.image!.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        due.image!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildAvatarText(
                            due.imageText ?? due.name ?? 'U',
                          );
                        },
                      ),
                    )
                  : _buildAvatarText(
                      due.imageText ?? due.name ?? 'U',
                    ),
            ),
            const SizedBox(width: 12),

            // Customer
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    due.name ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'JosefinSans',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    due.mobile ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontFamily: 'JosefinSans',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Scheme / account
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    due.schemeName ?? '-',
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'JosefinSans',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    (due.accountNo != null && due.accountNo!.isNotEmpty)
                        ? '${due.accountName ?? ''} ${due.accountNo}'
                        : (due.accountName ?? ''),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                      fontFamily: 'JosefinSans',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Amount + chevron
            const SizedBox(width: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '₹${_formatAmount((due.payableAmount ?? 0).toDouble())}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                    fontFamily: 'JosefinSans',
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Colors.grey[500],
                ),
              ],
            ),
          ],
        ),
      ),
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

  void _showChitDetails(Data due) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFF1565C0),
                  child: due.image != null && due.image!.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            due.image!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildAvatarText(
                                due.imageText ?? due.name ?? 'U',
                              );
                            },
                          ),
                        )
                      : _buildAvatarText(
                          due.imageText ?? due.name ?? 'U',
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        due.name ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'JosefinSans',
                        ),
                      ),
                      Text(
                        due.mobile ?? '',
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
            _detailRow('Area', due.areaName ?? '-'),
            _detailRow('Scheme', due.schemeName ?? '-'),
            _detailRow('Account Name', due.accountName ?? '-'),
            _detailRow('Account No', due.accountNo ?? '-'),
            _detailRow('Due Date', _formatDate(due.dueDate ?? '')),
            _detailRow(
              'Payable Amount',
              '₹${_formatAmount((due.payableAmount ?? 0).toDouble())}',
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  padding: const EdgeInsets.symmetric(vertical: 14),
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
          ],
        ),
      ),
    );
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

  String _formatDate(String date) {
    if (date.isEmpty) return '-';
    try {
      final parsedDate = DateTime.parse(date);
      return '${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}';
    } catch (e) {
      return date;
    }
  }

  String _formatAmount(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(2)}Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(2)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(2)}K';
    }
    return amount.toStringAsFixed(0);
  }
}

class _TableHeaderCell extends StatelessWidget {
  final String text;

  const _TableHeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontFamily: 'JosefinSans',
        ),
      ),
    );
  }
}
