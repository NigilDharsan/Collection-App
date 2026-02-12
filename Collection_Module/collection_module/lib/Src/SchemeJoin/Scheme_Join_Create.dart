import 'package:collection_module/Src/auth/signIn/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/custom_app_bar.dart';
import 'controller/Scheme_Join_Controller.dart';

class SchemeJoinCreate extends StatefulWidget {
  const SchemeJoinCreate({super.key});

  @override
  State<SchemeJoinCreate> createState() => _SchemeJoinCreateState();
}

class _SchemeJoinCreateState extends State<SchemeJoinCreate> {
  final TextEditingController _customerSearchController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _refNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();

  bool _showCustomerDropdown = false;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    Get.find<SchemeJoinController>().getBranchList();
    // Set default start date to today
    _selectedDate = DateTime.now();
    _startDateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
  }

  @override
  void dispose() {
    _customerSearchController.dispose();
    _accountNameController.dispose();
    _refNameController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _startDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _submitForm() {
    final controller = Get.find<SchemeJoinController>();

    // Validation
    if (controller.selectedCustomerId == null) {
      Get.snackbar(
        'Error',
        'Please select a customer',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (controller.selectedSchemeId == null) {
      Get.snackbar(
        'Error',
        'Please select a scheme',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (controller.selectedBranchId == null) {
      Get.snackbar(
        'Error',
        'Please select a branch',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (_accountNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter account name',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // if (_selectedDate == null) {
    //   Get.snackbar('Error', 'Please select start date',
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.red,
    //       colorText: Colors.white);
    //   return;
    // }

    // Create scheme
    controller.createScheme(
      accountName: _accountNameController.text.trim(),
      // refNo: _refNameController.text.trim().isEmpty
      //     ? null
      //     : _refNameController.text.trim(),
      startDate: DateFormat('yyyy-MM-dd').format(_selectedDate!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: 'Scheme Joining', isBackButtonExist: true),
      ),
      body: GetBuilder<SchemeJoinController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Customer Field
                _buildLabel('Customer', isRequired: true),
                const SizedBox(height: 8),
                _buildCustomerSearchField(controller),
                const SizedBox(height: 20),

                // Scheme Field
                _buildLabel('Scheme', isRequired: true),
                const SizedBox(height: 8),
                _buildSchemeDropdown(controller),
                const SizedBox(height: 20),

                // Branch Field
                _buildLabel('Branch', isRequired: true),
                const SizedBox(height: 8),
                _buildBranchDropdown(controller),
                const SizedBox(height: 20),

                // Account Name Field
                _buildLabel('Acc.Name', isRequired: true),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _accountNameController,
                  hint: 'Account Name',
                ),
                const SizedBox(height: 20),

                // Ref Name Field
                // _buildLabel('Ref.Name'),
                // const SizedBox(height: 8),
                // _buildTextField(
                //   controller: _refNameController,
                //   hint: 'Ref. Name',
                // ),
                // const SizedBox(height: 20),

                // // Start Date Field
                // _buildLabel('Start Date', isRequired: true),
                // const SizedBox(height: 8),
                // _buildDateField(),
                // const SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8D3D5B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Create Scheme',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        if (isRequired)
          const Text(
            '*',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget _buildCustomerSearchField(SchemeJoinController controller) {
    return Column(
      children: [
        TextField(
          controller: _customerSearchController,
          decoration: InputDecoration(
            hintText: 'Choose a customer...',
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            suffixIcon: controller.selectedCustomerId != null
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _customerSearchController.clear();
                        _showCustomerDropdown = false;
                      });
                      controller.clearSelection();
                      controller.clearSchemeSelection();
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            if (value.length >= 3) {
              controller.customerList(mobNum: value);
              setState(() {
                _showCustomerDropdown = true;
              });
            } else {
              setState(() {
                _showCustomerDropdown = false;
              });
              controller.clearOldSelection();
            }
          },
          readOnly: controller.selectedCustomerId != null,
        ),
        if (_showCustomerDropdown && controller.searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.searchResults.length,
              itemBuilder: (context, index) {
                final customer = controller.searchResults[index];
                return ListTile(
                  title: Text(customer.firstname ?? ''),
                  subtitle: Text(customer.mobile ?? ''),
                  onTap: () {
                    setState(() {
                      _customerSearchController.text =
                          ' ${customer.firstname}- ${customer.mobile}';
                      _showCustomerDropdown = false;
                    });
                    controller.selectedCustomerId = customer.value;
                    controller.selectedCustomerName = customer.firstname;
                    controller.selectedCustomerMobile = customer.mobile;
                    controller.update();
                    // Load schemes for selected customer
                    controller.getSchemeList(customer.value!);
                  },
                );
              },
            ),
          ),
        if (controller.searchResults.isEmpty &&
            _customerSearchController.text.length >= 10)
          Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "No account for ${_customerSearchController.text} number",
                style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: 15,
                  color: brandGreyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  Get.to(
                    () =>
                        RegisterScreen(mobile: _customerSearchController.text),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  "Create New Account",
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandPrimaryColor,
                  foregroundColor: brandPrimaryColor,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildSchemeDropdown(SchemeJoinController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Select Scheme',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          value: controller.selectedSchemeId,
          items: controller.schemeList.map((scheme) {
            return DropdownMenuItem<int>(
              value: scheme.idAccScheme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(scheme.schemeName ?? ''),
              ),
            );
          }).toList(),
          onChanged: controller.selectedCustomerId == null
              ? null
              : (value) {
                  controller.selectedSchemeId = value;
                  controller.selectedSchemeName = controller.schemeList
                      .firstWhere((s) => s.idAccScheme == value)
                      .schemeName;
                  controller.update();
                },
          icon: const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ),
    );
  }

  Widget _buildBranchDropdown(SchemeJoinController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Select Branch',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          value: controller.selectedBranchId,
          items: controller.branchModel?.data?.map((branch) {
            return DropdownMenuItem<int>(
              value: branch.idBranch,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(branch.name ?? ''),
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.selectedBranchId = value;
            controller.selectedBranchName = controller.branchModel?.data
                ?.firstWhere((b) => b.idBranch == value)
                .name;
            controller.update();
          },
          icon: const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return TextField(
      controller: _startDateController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'DD/MM/YYYY',
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () => _selectDate(context),
    );
  }
}
