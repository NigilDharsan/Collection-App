import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/core/helper/route_helper.dart';
import '../../../utils/styles.dart';
import '../../HandoverScreen/Handover_Screen.dart';
import '../../SchemeJoin/Scheme_Join_Create.dart';
import '../../SchemeJoin/Scheme_Payment.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/Collection_Dashboard_Controller.dart';


class CollectionDashboard extends StatefulWidget {
  const CollectionDashboard({super.key});

  @override
  State<CollectionDashboard> createState() => _CollectionDashboardState();
}

class _CollectionDashboardState extends State<CollectionDashboard> {
  final collectionController = Get.find<CollectionDashboardController>();
  final AuthController authController = Get.find<AuthController>();

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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("object");
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: Colors.red, size: 24),
              const SizedBox(width: 10),
              Text(
                "Logout",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'JosefinSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              color: Colors.black87,
              fontFamily: 'JosefinSans',
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontFamily: 'JosefinSans',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {
                Get.find<AuthController>().clearSharedData();
                Navigator.pop(context); // Close the dialog
                Get.offAllNamed(RouteHelper.getSignInRoute());
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'JosefinSans',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          titleSpacing: 1,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('Welcome to', style: order_style2),
                const SizedBox(height: 2),
                Text("Collection App", style: jewellery_style),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                  size: 24,
                ),
                offset: const Offset(0, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                onSelected: (value) {
                  if (value == 'scheme_join') {
                    Get.to(() => const SchemeJoinCreate());
                  } else if (value == 'scheme_payment') {
                    Get.to(() => const SchemePayment());
                  } else if (value == 'logout') {
                    _showExitConfirmation(context);
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'scheme_join',
                    child: Row(
                      children: [
                        Icon(Icons.add_circle_outline,
                            color: Colors.black87, size: 20),
                        SizedBox(width: 12),
                        Text(
                          'Scheme Join',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'scheme_payment',
                    child: Row(
                      children: [
                        Icon(Icons.payment, color: Colors.black87, size: 20),
                        SizedBox(width: 12),
                        Text(
                          'Scheme Payment',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(height: 10),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.black, size: 20),
                        SizedBox(width: 2),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   iconTheme: const IconThemeData(color: Colors.black),
        //   automaticallyImplyLeading: true,
        //   titleSpacing: 1,
        //   title: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         const SizedBox(height: 4),
        //         Text('Welcome to', style: order_style2),
        //         const SizedBox(height: 2),
        //         Text("Collection App", style: jewellery_style),
        //       ],
        //     ),
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.only(right: 12),
        //       child: InkWell(
        //         onTap: () {
        //           Get.to(() => const SchemeJoinCreate());
        //         },
        //         child: Container(
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        //           decoration: BoxDecoration(
        //             color: Colors.black,
        //             borderRadius: BorderRadius.circular(20),
        //           ),
        //           child: const Text(
        //             'Scheme Join',
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 12,
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(right: 12),
        //       child: InkWell(
        //         onTap: () {
        //           Get.to(() => const SchemePayment());
        //         },
        //         child: Container(
        //           padding:
        //               const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        //           decoration: BoxDecoration(
        //             color: Colors.black,
        //             borderRadius: BorderRadius.circular(20),
        //           ),
        //           child: const Text(
        //             'S Payment',
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 12,
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        body: GetBuilder<CollectionDashboardController>(
          builder: (controller) {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            // final areas = controller.pendingCreditsModel?.data ?? [];
            // final chitDues = controller.pendingChitDueModel?.data ?? [];
            // final collectionSummaryList =
            //     controller.collectionSummaryModel?.data ?? [];

            if (controller.collectionDashboardModel == null) {
              return const Center(
                child: Text(
                  'No pending data found',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                await controller.getCollectionDashboardCount();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.1,
                  children: [
                    buildDashboardCard(
                      'Allocated Areas',
                      controller.collectionDashboardModel?.allocatedArea
                              .toString() ??
                          '0',
                      Icons.location_on,
                      Colors.blue,
                    ),
                    buildDashboardCard(
                      'Total Customers',
                      controller.collectionDashboardModel?.totalCustomers
                              .toString() ??
                          '0',
                      Icons.people,
                      Colors.green,
                    ),
                    buildDashboardCard(
                      'Sales Credit Amount',
                      '₹${_formatAmount(double.tryParse(controller.collectionDashboardModel?.salesCreditAmount?.toString() ?? '0') ?? 0)}',
                      Icons.credit_card,
                      Colors.orange,
                    ),
                    buildDashboardCard(
                      'Chit Unpaid Count',
                      controller.collectionDashboardModel?.chitUnpaidCount
                              .toString() ??
                          '0',
                      Icons.calendar_today,
                      Colors.red,
                    ),
                    buildDashboardCard(
                      'Today Chit Cash Collected',
                      '₹${_formatAmount(double.tryParse(controller.collectionDashboardModel?.todayChitCashCollected?.toString() ?? '0') ?? 0)}',
                      Icons.money,
                      Colors.brown,
                    ),
                    buildDashboardCard(
                      'Total Credit Cash Collection',
                      '₹${_formatAmount(double.tryParse(controller.collectionDashboardModel?.totalCreditCashCollection?.toString() ?? '0') ?? 0)}',
                      Icons.money_off,
                      Colors.cyan,
                    ),
                    buildDashboardCard(
                      'Total Cash Collection',
                      '₹${_formatAmount(double.tryParse(controller.collectionDashboardModel?.totalCashCollection?.toString() ?? '0') ?? 0)}',
                      Icons.attach_money_outlined,
                      Colors.indigo,
                    ),
                    handoverCard(),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Get.toNamed('/customerCreate');
          },
          // onPressed: () {
          //   Get.offAll(() => HandoverScreen());
          // },
          backgroundColor: const Color(0xFF8D3D5B),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget buildDashboardCard(
      String title, String count, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle card tap if needed
        Get.toNamed(RouteHelper.collectionDashboardDetails);
      },
      child: Container(
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
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'JosefinSans',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'JosefinSans',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget handoverCard() {
    return GestureDetector(
      onTap: () {
        Get.to(() => HandoverScreen());
      },
      child: Container(
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
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              "Hand Over ",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'JosefinSans',
              ),
            ),
          ],
        ),
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

  // String _formatAmount(double amount) {
  //   if (amount >= 10000000) {
  //     return '${(amount / 10000000).toStringAsFixed(2)}Cr';
  //   } else if (amount >= 100000) {
  //     return '${(amount / 100000).toStringAsFixed(2)}L';
  //   } else if (amount >= 1000) {
  //     return '${(amount / 1000).toStringAsFixed(2)}K';
  //   }
  //   return amount.toStringAsFixed(0);
  // }
  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##,###.##', 'en_IN');
    return formatter.format(amount);
  }
}
