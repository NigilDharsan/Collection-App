import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/widgets/custom_app_bar.dart';
import 'controller/Customer_Join_Controller.dart';


class CustomerJoinScreen extends StatefulWidget {
  const CustomerJoinScreen({super.key});

  @override
  State<CustomerJoinScreen> createState() => _CustomerJoinScreenState();
}

class _CustomerJoinScreenState extends State<CustomerJoinScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Customer Joining',
          isBackButtonExist: true,
        ),
      ),
      body: GetBuilder<CustomerJoinController>(
        builder: (controller) {
          if (controller.isLoading && controller.countryList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First Name
                  _buildTextField(
                    controller: controller.firstNameController,
                    label: 'First Name',
                    hint: 'Enter first name',
                    icon: Icons.person,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Last Name
                  _buildTextField(
                    controller: controller.lastNameController,
                    label: 'Last Name',
                    hint: 'Enter last name',
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Mobile Number
                  _buildTextField(
                    controller: controller.mobileController,
                    label: 'Mobile Number',
                    hint: 'Enter 10-digit mobile number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter mobile number';
                      }
                      if (value.length != 10) {
                        return 'Mobile number must be 10 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email
                  _buildTextField(
                    controller: controller.emailController,
                    label: 'Email',
                    hint: 'Enter email address',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Date of Birth
                  _buildDateField(
                    controller: controller.dobController,
                    label: 'Date of Birth',
                    hint: 'Select date of birth',
                    onTap: () => _selectDate(context, controller),
                  ),
                  const SizedBox(height: 16),

                  // Country Dropdown
                  _buildDropdown<int>(
                    label: 'Country',
                    hint: 'Select country',
                    value: controller.selectedCountryId,
                    items: controller.countryList
                        .map((country) => DropdownMenuItem<int>(
                              value: country.idCountry,
                              child: Text(country.name ?? ''),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.loadStates(value);
                      }
                    },
                    icon: Icons.public,
                  ),
                  const SizedBox(height: 16),

                  // State Dropdown
                  Builder(
                    builder: (context) {
                      final filteredStates = controller.stateList
                          .where((state) =>
                              state.country == controller.selectedCountryId)
                          .toList();
                      final stateIds =
                          filteredStates.map((state) => state.idState).toList();
                      final validStateValue =
                          stateIds.contains(controller.selectedStateId)
                              ? controller.selectedStateId
                              : null;

                      return _buildDropdown<int>(
                        label: 'State',
                        hint: 'Select state',
                        value: validStateValue,
                        items: filteredStates
                            .map((state) => DropdownMenuItem<int>(
                                  value: state.idState,
                                  child: Text(state.name ?? ''),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.loadCities(value);
                          }
                        },
                        icon: Icons.location_city,
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // City Dropdown
                  Builder(
                    builder: (context) {
                      final filteredCities = controller.cityList
                          .where((city) =>
                              city.state == controller.selectedStateId)
                          .toList();
                      final cityIds =
                          filteredCities.map((city) => city.idCity).toList();
                      final validCityValue =
                          cityIds.contains(controller.selectedCityId)
                              ? controller.selectedCityId
                              : null;

                      return _buildDropdown<int>(
                        label: 'City',
                        hint: 'Select city',
                        value: validCityValue,
                        items: filteredCities
                            .map((city) => DropdownMenuItem<int>(
                                  value: city.idCity,
                                  child: Text(city.name ?? ''),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectCity(value);
                          }
                        },
                        icon: Icons.apartment,
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Area Dropdown - Independent
                  _buildDropdown<int>(
                    label: 'Area',
                    hint: 'Select area',
                    value: controller.areaList.isNotEmpty &&
                            controller.areaList.any(
                                (a) => a.areaId == controller.selectedAreaId)
                        ? controller.selectedAreaId
                        : null,
                    items: controller.areaList.isEmpty
                        ? [
                            const DropdownMenuItem<int>(
                              value: null,
                              enabled: false,
                              child: Text('No areas available'),
                            )
                          ]
                        : controller.areaList
                            .map((area) => DropdownMenuItem<int>(
                                  value: area.areaId,
                                  child: Text(area.areaName ?? ''),
                                ))
                            .toList(),
                    onChanged: controller.areaList.isEmpty
                        ? null
                        : (value) {
                            if (value != null) {
                              controller.selectArea(value);
                            }
                          },
                    icon: Icons.place,
                  ),

                  const SizedBox(height: 16),

                  // Pincode
                  _buildTextField(
                    controller: controller.pincodeController,
                    label: 'Pincode',
                    hint: 'Enter 6-digit pincode',
                    icon: Icons.pin_drop,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter pincode';
                      }
                      if (value.length != 6) {
                        return 'Pincode must be 6 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // addressline 1
                  _buildTextField(
                    controller: controller.line1Controller,
                    label: 'Address Line 1',
                    hint: 'Enter Address',
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: controller.line2Controller,
                    label: 'Address Line 2',
                    hint: 'Enter Address ',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 16),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                controller.createCustomer();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8D3D5B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: controller.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Create Customer',
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please select date of birth';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            suffixIcon: const Icon(Icons.calendar_today, size: 20),
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required String hint,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?>? onChanged,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          validator: (value) {
            if (value == null) {
              return 'Please select $label';
            }
            return null;
          },
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(
      BuildContext context, CustomerJoinController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formatted = DateFormat('dd/MM/yyyy').format(picked);
      controller.dobController.text = formatted;
      controller.selectDOB(picked);
    }
  }
}
