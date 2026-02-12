// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tn_jewellery_admin/features/CollectionApp/Dashboard/controller/Collection_Dashboard_Controller.dart';
// import 'package:tn_jewellery_admin/utils/core/helper/route_helper.dart';
// import 'package:tn_jewellery_admin/utils/widgets/custom_app_bar.dart';

// class PendingCreditsDetails extends StatefulWidget {
//   const PendingCreditsDetails({Key? key}) : super(key: key);

//   @override
//   State<PendingCreditsDetails> createState() => _PendingCreditsDetailsState();
// }

// class _PendingCreditsDetailsState extends State<PendingCreditsDetails> {
//   final collectionController = Get.find<CollectionDashboardController>();
//   final TextEditingController _searchController = TextEditingController();
//   int? areaId;
//   String _searchQuery = '';
//   final CollectionDashboardController controller =
//       Get.find<CollectionDashboardController>();
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.initializePendingCreditDetailsList(areaId!);
//     });

//     // Add scroll listener for load more
//     _scrollController.addListener(_onScroll);

//     // Get area_id from navigation arguments
//     final args = Get.arguments as Map<String, dynamic>?;
//     areaId = args?['areaId'] ?? 0;

//     // Fetch details for this area
//     if (areaId != null && areaId! > 0) {
//       collectionController.getAreaWisePendingCreditsDetails(areaId!);
//     }
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//         _scrollController.position.maxScrollExtent - 200) {
//       // Load more when user is 200px from bottom
//       controller.loadMorePendingCreditDetails(areaId!);
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     collectionController.clearAllData();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   List _filterCredits(List credits) {
//     if (_searchQuery.isEmpty) {
//       return credits;
//     }
//     return credits.where((credit) {
//       final mobile = credit.mobile?.toLowerCase() ?? '';
//       final name = credit.name?.toLowerCase() ?? '';
//       final query = _searchQuery.toLowerCase();
//       return mobile.contains(query) || name.contains(query);
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(50),
//         child: CustomAppBar(
//           title: 'Pending Credit Details',
//           isBackButtonExist: true,
//         ),
//       ),
//       body: GetBuilder<CollectionDashboardController>(
//         builder: (controller) {
//           if (controller.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final allCredits = controller.pendingCreditsDetailsModel?.data ?? [];
//           final filteredCredits = _filterCredits(allCredits);

//           if (allCredits.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No pending credits found',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             );
//           }

//           if (controller.allPendingCreditDetailsData.isEmpty) {
//             return _buildEmptyState();
//           }

//           return RefreshIndicator(
//             onRefresh: () async {
//               if (areaId != null && areaId! > 0) {
//                 await controller.refreshPendingCreditList(areaId!);
//               }
//             },
//             color: const Color(0xFF6C63FF),

//             child: SingleChildScrollView(
//               controller: _scrollController,
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Search Bar
//                     _buildSearchBar(),
//                     const SizedBox(height: 16),

//                     // Summary Card
//                     _buildSummaryCard(filteredCredits),
//                     const SizedBox(height: 20),

//                     // No results message
//                     if (filteredCredits.isEmpty && _searchQuery.isNotEmpty)
//                       const Center(
//                         child: Padding(
//                           padding: EdgeInsets.all(32.0),
//                           child: Text(
//                             'No customers found matching your search',
//                             style: TextStyle(fontSize: 16, color: Colors.grey),
//                           ),
//                         ),
//                       )
//                     else
//                       // Credits Table
//                       _buildCreditsTable(filteredCredits),
//                   ],
//                 ),
//               ),
//             ),

//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (value) {
//           setState(() {
//             _searchQuery = value;
//           });
//         },
//         decoration: InputDecoration(
//           hintText: 'Search by mobile number or name...',
//           hintStyle: TextStyle(
//             color: Colors.grey[400],
//             fontSize: 14,
//             fontFamily: 'JosefinSans',
//           ),
//           prefixIcon: Icon(
//             Icons.search,
//             color: Colors.grey[600],
//           ),
//           suffixIcon: _searchQuery.isNotEmpty
//               ? IconButton(
//                   icon: Icon(
//                     Icons.clear,
//                     color: Colors.grey[600],
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _searchController.clear();
//                       _searchQuery = '';
//                     });
//                   },
//                 )
//               : null,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 12,
//           ),
//           filled: true,
//           fillColor: Colors.white,
//         ),
//         style: const TextStyle(
//           fontSize: 14,
//           fontFamily: 'JosefinSans',
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryCard(List credits) {
//     final totalAmount = credits.fold<double>(
//       0.0,
//       (sum, item) => sum + ((item.dueAmount ?? 0).toDouble()),
//     );

//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _summaryItem('Total Credits', '${credits.length}', Icons.credit_card),
//           Container(
//             width: 1,
//             height: 30,
//             color: Colors.white.withOpacity(0.3),
//           ),
//           _summaryItem(
//             'Total Amount',
//             '₹${collectionController.formatAmount(totalAmount)}',
//             Icons.account_balance_wallet,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _summaryItem(String label, String value, IconData icon) {
//     return Column(
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 12,
//             fontFamily: 'JosefinSans',
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'JosefinSans',
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCreditsTable(List credits) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Table Header
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//             ),
//             child: const Row(
//               children: [
//                 Expanded(flex: 3, child: _TableHeaderCell('Customer')),
//                 Expanded(flex: 2, child: _TableHeaderCell('Invoice')),
//                 Expanded(flex: 2, child: _TableHeaderCell('Due Date')),
//                 Expanded(flex: 2, child: _TableHeaderCell('Amount')),
//               ],
//             ),
//           ),

//           // Table Rows
//           ...credits.asMap().entries.map((entry) {
//             final index = entry.key;
//             final credit = entry.value;
//             final isLast = index == credits.length - 1;

//             return _buildCreditRow(credit, isLast);
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildCreditRow(dynamic credit, bool isLast) {
//     return InkWell(
//       onTap: () {
//         // Handle row tap if needed

//         collectionController.credit = credit;
//         Get.toNamed(RouteHelper.pendingCreditPayment);
//       },
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           border: isLast
//               ? null
//               : Border(
//                   bottom: BorderSide(color: Colors.grey[200]!, width: 1),
//                 ),
//           borderRadius: isLast
//               ? const BorderRadius.only(
//                   bottomLeft: Radius.circular(12),
//                   bottomRight: Radius.circular(12),
//                 )
//               : null,
//           color: Colors.white,
//         ),
//         child: Row(
//           children: [
//             // Avatar
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: const Color(0xFF1565C0),
//               child: credit.image != null && credit.image!.isNotEmpty
//                   ? ClipOval(
//                       child: Image.network(
//                         credit.image!,
//                         width: 40,
//                         height: 40,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return _buildAvatarText(
//                             credit.imageText ?? credit.name ?? 'U',
//                           );
//                         },
//                       ),
//                     )
//                   : _buildAvatarText(
//                       credit.imageText ?? credit.name ?? 'U',
//                     ),
//             ),
//             const SizedBox(width: 12),
//             // Name and mobile vertically
//             SizedBox(
//               width: 80,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     credit.name ?? 'Unknown',
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'JosefinSans',
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.visible,
//                   ),
//                   Text(
//                     credit.mobile ?? '',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                       fontFamily: 'JosefinSans',
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//             // Invoice Number
//             Expanded(
//               flex: 2,
//               child: Text(
//                 credit.invoiceNo ?? '-',
//                 style: const TextStyle(
//                   fontSize: 13,
//                   fontFamily: 'JosefinSans',
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             // Due Date
//             Expanded(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     collectionController.formatDate(credit.creditDueDate ?? ''),
//                     style: const TextStyle(
//                       fontSize: 13,
//                       fontFamily: 'JosefinSans',
//                     ),
//                   ),
//                   if (collectionController.isOverdue(credit.creditDueDate))
//                     Container(
//                       margin: const EdgeInsets.only(top: 4),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 6, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: Colors.red[50],
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         'Overdue',
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: Colors.red[700],
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             // Amount
//             Expanded(
//               flex: 2,
//               child: Text(
//                 '₹${collectionController.formatAmount((credit.dueAmount ?? 0).toDouble())}',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFFF57C00),
//                   fontFamily: 'JosefinSans',
//                 ),
//               ),
//             ),
//             // Chevron icon
//             const SizedBox(width: 8),
//             Icon(
//               Icons.chevron_right,
//               size: 20,
//               color: Colors.grey[500],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAvatarText(String text) {
//     return Text(
//       text.isNotEmpty ? text[0].toUpperCase() : 'U',
//       style: const TextStyle(
//         color: Colors.white,
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Widget _buildBottomLoader() {
//     return Obx(() {
//       if (controller.isLoadingMore.value) {
//         return Container(
//           padding: const EdgeInsets.all(16),
//           alignment: Alignment.center,
//           child: const CircularProgressIndicator(
//             color: Color(0xFF6C63FF),
//           ),
//         );
//       }

//       if (controller.hasMoreData.value) {
//         return const SizedBox.shrink();
//       }

//       return Container(
//         padding: const EdgeInsets.all(16),
//         alignment: Alignment.center,
//         child: Column(
//           children: [
//             Icon(
//               Icons.check_circle_outline,
//               color: Colors.grey[400],
//               size: 32,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'No more records',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               'Total: ${controller.allPendingCreditDetailsData.length} records',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey[500],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.receipt_long_outlined,
//             size: 80,
//             color: Colors.grey[300],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'No Records Found',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Try adjusting your filters',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[500],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _TableHeaderCell extends StatelessWidget {
//   final String text;

//   const _TableHeaderCell(this.text);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 13,
//         fontWeight: FontWeight.bold,
//         color: Colors.black87,
//         fontFamily: 'JosefinSans',
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/core/helper/route_helper.dart';
import '../../../utils/widgets/custom_app_bar.dart';
import '../controller/Collection_Dashboard_Controller.dart';


class PendingCreditsDetails extends StatefulWidget {
  const PendingCreditsDetails({Key? key}) : super(key: key);

  @override
  State<PendingCreditsDetails> createState() => _PendingCreditsDetailsState();
}

class _PendingCreditsDetailsState extends State<PendingCreditsDetails> {
  final collectionController = Get.find<CollectionDashboardController>();
  final TextEditingController _searchController = TextEditingController();
  int? areaId;
  String _searchQuery = '';
  final CollectionDashboardController controller =
      Get.find<CollectionDashboardController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Get area_id from navigation arguments
    final args = Get.arguments as Map<String, dynamic>?;
    areaId = args?['areaId'] ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializePendingCreditDetailsList(areaId!);
    });

    // Add scroll listener for load more
    _scrollController.addListener(_onScroll);

    // Fetch details for this area
    if (areaId != null && areaId! > 0) {
      collectionController.getAreaWisePendingCreditsDetails(areaId!);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more when user is 200px from bottom
      controller.loadMorePendingCreditDetails(areaId!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    collectionController.clearAllData();
    _scrollController.dispose();
    super.dispose();
  }

  List _filterCredits(List credits) {
    if (_searchQuery.isEmpty) {
      return credits;
    }
    return credits.where((credit) {
      final mobile = credit.mobile?.toLowerCase() ?? '';
      final name = credit.name?.toLowerCase() ?? '';
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
          title: 'Pending Credit Details',
          isBackButtonExist: true,
        ),
      ),
      body: GetBuilder<CollectionDashboardController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.allPendingCreditDetailsData.isEmpty) {
            return _buildEmptyState();
          }

          final filteredCredits =
              _filterCredits(controller.allPendingCreditDetailsData);

          return RefreshIndicator(
            onRefresh: () async {
              if (areaId != null && areaId! > 0) {
                await controller.refreshPendingCreditList(areaId!);
              }
            },
            color: const Color(0xFF6C63FF),
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: filteredCredits.isEmpty && _searchQuery.isNotEmpty
                  ? 3 // Search bar + Summary + No results message
                  : filteredCredits.isEmpty
                      ? 2 // Search bar + Summary only
                      : 4, // Search bar + Summary + Table + Loader
              itemBuilder: (context, index) {
                // Search Bar
                if (index == 0) {
                  return Column(
                    children: [
                      _buildSearchBar(),
                      const SizedBox(height: 16),
                    ],
                  );
                }

                // Summary Card
                if (index == 1) {
                  return Column(
                    children: [
                      _buildSummaryCard(filteredCredits),
                      const SizedBox(height: 20),
                    ],
                  );
                }

                // No results message for search
                if (filteredCredits.isEmpty &&
                    _searchQuery.isNotEmpty &&
                    index == 2) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(
                        'No customers found matching your search',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  );
                }

                // Credits Table
                if (index == 2 && filteredCredits.isNotEmpty) {
                  return _buildCreditsTable(filteredCredits);
                }

                // Bottom Loader (last item)
                if (index == 3 && filteredCredits.isNotEmpty) {
                  return _buildBottomLoader();
                }

                return const SizedBox.shrink();
              },
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

  Widget _buildSummaryCard(List credits) {
    final totalAmount = credits.fold<double>(
      0.0,
      (sum, item) => sum + ((item.dueAmount ?? 0).toDouble()),
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
          _summaryItem('Total Credits', '${credits.length}', Icons.credit_card),
          Container(
            width: 1,
            height: 30,
            color: Colors.white.withOpacity(0.3),
          ),
          _summaryItem(
            'Total Amount',
            '₹${collectionController.formatAmount(totalAmount)}',
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

  Widget _buildCreditsTable(List credits) {
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
          // Table Header
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
                Expanded(flex: 2, child: _TableHeaderCell('Invoice')),
                Expanded(flex: 2, child: _TableHeaderCell('Due Date')),
                Expanded(flex: 2, child: _TableHeaderCell('Amount')),
              ],
            ),
          ),

          // Table Rows
          ...credits.asMap().entries.map((entry) {
            final index = entry.key;
            final credit = entry.value;
            final isLast = index == credits.length - 1;

            return _buildCreditRow(credit, isLast);
          }),
        ],
      ),
    );
  }

  Widget _buildCreditRow(dynamic credit, bool isLast) {
    return InkWell(
      onTap: () {
        collectionController.credit = credit;
        Get.toNamed(RouteHelper.pendingCreditPayment);
      },
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
              child: credit.image != null && credit.image!.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        credit.image!,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildAvatarText(
                            credit.imageText ?? credit.name ?? 'U',
                          );
                        },
                      ),
                    )
                  : _buildAvatarText(
                      credit.imageText ?? credit.name ?? 'U',
                    ),
            ),
            const SizedBox(width: 12),
            // Name and mobile vertically
            SizedBox(
              width: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    credit.name ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'JosefinSans',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                  ),
                  Text(
                    credit.mobile ?? '',
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
            // Invoice Number
            Expanded(
              flex: 2,
              child: Text(
                credit.invoiceNo ?? '-',
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'JosefinSans',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Due Date
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collectionController.formatDate(credit.creditDueDate ?? ''),
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'JosefinSans',
                    ),
                  ),
                  if (collectionController.isOverdue(credit.creditDueDate))
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Overdue',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.red[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Amount
            Expanded(
              flex: 2,
              child: Text(
                '₹${collectionController.formatAmount((credit.dueAmount ?? 0).toDouble())}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF57C00),
                  fontFamily: 'JosefinSans',
                ),
              ),
            ),
            // Chevron icon
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.grey[500],
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
              'Total: ${controller.allPendingCreditDetailsData.length} records',
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
            'No Records Found',
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
}

class _TableHeaderCell extends StatelessWidget {
  final String text;

  const _TableHeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
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
}
