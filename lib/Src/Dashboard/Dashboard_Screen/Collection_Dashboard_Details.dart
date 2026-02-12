import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Collection_Dashboard_Controller.dart';

class CollectionDashboardDetails extends StatefulWidget {
  const CollectionDashboardDetails({super.key});

  @override
  State<CollectionDashboardDetails> createState() =>
      _CollectionDashboardDetailsState();
}

class _CollectionDashboardDetailsState
    extends State<CollectionDashboardDetails> {
  final collectionController = Get.find<CollectionDashboardController>();

  @override
  void initState() {
    super.initState();
  }

  // Navigate to area-wise credits list page
  void navigateToCreditsArea(int areaId) {
    Get.toNamed('/area-wise-credits-details', arguments: {
      'areaId': areaId,
    });
  }

  // Navigate to area-wise chit dues list page
  void navigateToChitDuesArea(int areaId) {
    Get.toNamed('/area-wise-chit-dues-details', arguments: {
      'areaId': areaId,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[50],
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   iconTheme: const IconThemeData(color: Colors.black),
      //   automaticallyImplyLeading: true,
      //   titleSpacing: 1,
      //   title: Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           const SizedBox(height: 4),
      //           Text('Welcome to', style: order_style2),
      //           const SizedBox(height: 2),
      //           Text("Collection App", style: jewellery_style),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        titleSpacing: 1,
        title: Text(
          "Collection Summary",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'JosefinSans',
          ),
        ),
      ),
      body: GetBuilder<CollectionDashboardController>(
        initState: (state) async {
          await collectionController.getAreaWisePendingCredits();
          await collectionController.getAreaWisePendingChitDues();
          await collectionController.getCollectionSummaryList();
        },
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final areas = controller.pendingCreditsModel?.data ?? [];
          final chitDues = controller.pendingChitDueModel?.data ?? [];
          final collectionSummaryList =
              controller.collectionSummaryModel?.data ?? [];

          if (areas.isEmpty && chitDues.isEmpty) {
            return const Center(
              child: Text(
                'No pending data found',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await controller.getAreaWisePendingCredits();
              await controller.getAreaWisePendingChitDues();
              await controller.getCollectionSummaryList();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Area-wise Pending Credits Section
                    if (areas.isNotEmpty) ...[
                      _buildCreditsTable(areas, controller),
                      const SizedBox(height: 32),
                    ],

                    // Area-wise Pending Chit-Dues Section
                    if (chitDues.isNotEmpty) ...[
                      _buildChitDuesTable(chitDues),
                    ],
                    const SizedBox(height: 32),

                    // collection summary
                    if (collectionSummaryList.isNotEmpty) ...[
                      _buildCollectionSummaryTable(collectionSummaryList),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreditsTable(
      List areas, CollectionDashboardController controller) {
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
              color: const Color(0xFFFFFFFF),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.credit_card, color: Colors.black, size: 24),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Pending Credits Summary',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JosefinSans',
                    ),
                  ),
                ),
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                //   decoration: BoxDecoration(
                //     color: const Color(0xFF8D3D5B),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: Text(
                //     (controller.getTotalPendingCount() ?? 0).toString(),
                //     style: const TextStyle(
                //       color: Colors.white,
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       fontFamily: 'JosefinSans',
                //     ),
                //   ),
                // ),
              ],
            ),
          ),

          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: _tableHeaderCell('Area'),
                ),
                Expanded(
                  flex: 2,
                  child: _tableHeaderCell('Credits'),
                ),
                Expanded(
                  flex: 3,
                  child: _tableHeaderCell('Customers'),
                ),
                Expanded(
                  flex: 3,
                  child: _tableHeaderCell('Amount'),
                ),
              ],
            ),
          ),

          // Table Rows
          ...areas.asMap().entries.map((entry) {
            final index = entry.key;
            final area = entry.value;
            final isLast = index == areas.length - 1;

            return InkWell(
              // onTap: () => navigateToCreditsArea(area.areaId ?? 1),
              onTap: () {
                if (area.areaId != null) {
                  navigateToCreditsArea(area.areaId!);
                } else {
                  // Optionally handle the missing case
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Area ID is missing')));
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: isLast
                      ? null
                      : Border(
                          bottom:
                              BorderSide(color: Colors.grey[200]!, width: 1),
                        ),
                  borderRadius: isLast
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        area.areaName ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'JosefinSans',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${area.creditPendingCount ?? 0}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'JosefinSans',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${area.customerCount ?? 0}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'JosefinSans',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '₹${_formatAmount((area.creditPendingAmount ?? 0).toDouble())}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'JosefinSans',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChitDuesTable(List chitDues) {
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
              color: const Color(0xFFFFFFFF),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.black, size: 24),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Pending Chit-Dues Summary',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JosefinSans',
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '33j',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: _tableHeaderCell('Area'),
                ),
                Expanded(
                  flex: 3,
                  child: _tableHeaderCell('Pending Collections'),
                ),
                Expanded(
                  flex: 3,
                  child: _tableHeaderCell('Customers'),
                ),
              ],
            ),
          ),

          // Table Rows
          ...chitDues.asMap().entries.map((entry) {
            final index = entry.key;
            final chitDue = entry.value;
            final isLast = index == chitDues.length - 1;

            return InkWell(
              onTap: () => navigateToChitDuesArea(
                chitDue.areaId ?? 0,
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: isLast
                      ? null
                      : Border(
                          bottom:
                              BorderSide(color: Colors.grey[200]!, width: 1),
                        ),
                  borderRadius: isLast
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        chitDue.areaName ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'JosefinSans',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${chitDue.pendingCollectionCount ?? 0}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'JosefinSans',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${chitDue.customerCount ?? 0}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'JosefinSans',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCollectionSummaryTable(List collectionSummaryList) {
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
              color: const Color(0xFFFFFFFF),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.black, size: 24),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Collection Summary',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JosefinSans',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: _tableHeaderCell('Area'),
                ),
                Expanded(
                  flex: 3,
                  child: _tableHeaderCell('Credit Collection'),
                ),
                Expanded(
                  flex: 3,
                  child: _tableHeaderCell('Chit Collection'),
                ),
              ],
            ),
          ),

          ...collectionSummaryList.asMap().entries.map((entry) {
            final index = entry.key;
            final collectionSum = entry.value;
            final isLast = index == collectionSummaryList.length - 1;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      collectionSum.areaName ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'JosefinSans',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        if (collectionSum.areaId != null) {
                          Get.toNamed('/credit-collection-report');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹${_formatAmount((collectionSum.creditCollectedAmount ?? 0).toDouble())}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'JosefinSans',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {
                        if (collectionSum.areaId != null) {
                          Get.toNamed('/chit-collection-report');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹${_formatAmount((collectionSum.chitCollectedAmount ?? 0).toDouble())}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'JosefinSans',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _tableHeaderCell(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontFamily: 'JosefinSans',
      ),
    );
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
