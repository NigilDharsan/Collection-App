import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/widgets/custom_app_bar.dart';
import 'controller/CollectionReport_Controller.dart';


class CreditCollectionSummaryReport extends StatefulWidget {
  const CreditCollectionSummaryReport({super.key});

  @override
  State<CreditCollectionSummaryReport> createState() =>
      _CreditCollectionSummaryReportState();
}

class _CreditCollectionSummaryReportState
    extends State<CreditCollectionSummaryReport> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<CollectionreportController>();
      controller.initializePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionreportController>();
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'CREDIT COLLECTION REPORT',
          isBackButtonExist: true,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              _buildFilterSection(controller),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(height: 1, thickness: 1, color: Colors.black12),
              ),
              _buildSalesTable(controller),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSalesTable(CollectionreportController controller) {
    final dataList = controller.creditCollectionReportModel?.data ?? [];

    if (dataList.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
              'No credit collection records found for the selected criteria.'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              border: TableBorder.all(
                color: Colors.grey.shade200,
                width: 1,
                borderRadius: BorderRadius.circular(10),
              ),
              columnSpacing: 16,
              dataRowHeight: 50,
              headingRowHeight: 40,
              columns: _buildTableHeader(),
              rows: dataList.map((item) {
                final totalAmt =
                    controller.currencyFormatter.format(item.totalAmount ?? 0);
                final paidAmt =
                    controller.currencyFormatter.format(item.paidAmount ?? 0);
                final balanceAmt = controller.currencyFormatter
                    .format(item.balanceAmount ?? 0);
                return DataRow(
                  cells: [
                    DataCell(Text(item.customerName ?? '',
                        style: const TextStyle(fontSize: 14))),
                    DataCell(Text(item.invoiceNo?.toString() ?? '',
                        style: const TextStyle(fontSize: 14))),
                    DataCell(Text(totalAmt,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500))),
                    DataCell(Text(paidAmt,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.green))),
                    DataCell(Text(balanceAmt,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red))),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildTableHeader() {
    DataColumn buildColumn(String label, {TextAlign align = TextAlign.left}) {
      return DataColumn(
        label: Expanded(
          child: Text(
            label,
            textAlign: align,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      );
    }

    return [
      buildColumn("Name"),
      buildColumn("Inv No", align: TextAlign.center),
      buildColumn("Total Amt", align: TextAlign.center),
      buildColumn("Paid Amt", align: TextAlign.center),
      buildColumn("Balance Amt", align: TextAlign.center),
    ];
  }

  Widget _buildFilterSection(CollectionreportController controller) {
    return Obx(() {
      final areas = controller.areaModel?.data ?? [];
      final isAreaLoading = controller.isAreaLoading.value;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildDateField(
                    label: 'From Date',
                    controller: controller.fromDateController,
                    selectedDate: controller.fromDate.value,
                    onTap: () => _selectFromDate(context, controller),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateField(
                    label: 'To Date',
                    controller: controller.toDateController,
                    selectedDate: controller.toDate.value,
                    onTap: () => _selectToDate(context, controller),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // area Dropdown
            Row(
              children: [
                Expanded(
                  child: isAreaLoading
                      ? Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('Loading areas...'),
                            ],
                          ),
                        )
                      : areas.isEmpty
                          ? Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'No areas available',
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          : DropdownButtonFormField<int>(
                              value: areas.any((area) =>
                                      area.areaId ==
                                      controller.selectedAreaId.value)
                                  ? controller.selectedAreaId.value
                                  : areas.first.areaId,
                              decoration: InputDecoration(
                                labelText: 'Area',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              items: areas.map((area) {
                                return DropdownMenuItem<int>(
                                  value: area.areaId ?? 0,
                                  child: Text(area.areaName ?? 'Unknown'),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  final area = areas.firstWhereOrNull(
                                      (b) => b.areaId == value);
                                  controller.selectedAreaId.value = value;
                                  controller.selectedAreaName.value =
                                      area?.areaName ?? 'All Areas';
                                }
                              },
                            ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => controller.loadReportList(),
                icon: const Icon(Icons.search, color: Colors.white),
                label: const Text(
                  'Load Report',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E4A6B),
                  disabledBackgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required DateTime selectedDate,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF8E4A6B))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF8E4A6B))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Color(0xFF8E4A6B), width: 2)),
            suffixIcon: const Icon(Icons.calendar_today, size: 20),
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Future<void> _selectFromDate(
      BuildContext context, CollectionreportController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.fromDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      controller.updateFromDate(picked);
    }
  }

  Future<void> _selectToDate(
      BuildContext context, CollectionreportController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.toDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      controller.updateToDate(picked);
    }
  }
}
