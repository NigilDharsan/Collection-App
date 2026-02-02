import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/widgets/custom_app_bar.dart';
import 'controller/CollectionReport_Controller.dart';


class ChitCollectionSummaryReport extends StatefulWidget {
  const ChitCollectionSummaryReport({super.key});

  @override
  State<ChitCollectionSummaryReport> createState() =>
      _ChitCollectionSummaryReportState();
}

class _ChitCollectionSummaryReportState
    extends State<ChitCollectionSummaryReport> {
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
          title: 'CHIT COLLECTION REPORT',
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
              _buildChitTable(controller),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildChitTable(CollectionreportController controller) {
    final dataList = controller.chitCollectionReportModel?.data ?? [];

    if (dataList.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
              'No chit collection records found for the selected criteria.'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final item = dataList[index];
          return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            item.schemeName ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                controller.generateChitCollectionReportPdf(
                                  item.paymentId ?? 0,
                                );
                              },
                              child: Icon(Icons.receipt,
                                  color: Colors.grey.shade600)),
                        ],
                      ),
                      _buildSchemeItem(
                        receiptno: item.receiptNo ?? '',
                        name: item.accountName ?? '',
                        mobno: item.accountNo ?? '',
                        amount: item.paidAmount?.toString() ?? '0',
                        weight: item.metalWeight?.toString() ?? '0',
                        customername: item.customerName ??
                            "", // Add date if available in the model
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget _buildSchemeItem({
    required String receiptno,
    required String name,
    required String mobno,
    required String amount,
    required String weight,
    required String customername,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  receiptno,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  customername,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  mobno,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  weight,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 12,
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
      buildColumn("Receipt No", align: TextAlign.center),
      buildColumn("Scheme Name", align: TextAlign.center),
      buildColumn("Account Name", align: TextAlign.center),
      buildColumn("Account No", align: TextAlign.center),
      buildColumn("Paid Amt", align: TextAlign.center),
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
                onPressed: () => controller.loadChitCollectionReportList(),
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
