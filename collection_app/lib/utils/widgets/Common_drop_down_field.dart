import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final int? selectedId; // Allow null to avoid assertion
  final List<Map<String, dynamic>> items;
  final ValueChanged<int> onChanged;

  const CustomDropdown({
    Key? key,
    required this.title,
    required this.selectedId,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dropdownItems = items.map<DropdownMenuItem<int>>((item) {
      final id = int.tryParse(item['id'].toString()) ?? -1;
      final name = item['name']?.toString() ?? '';
      return DropdownMenuItem<int>(
        value: id,
        child: Text(name, style: const TextStyle(color: brandGreySoftColor)),
      );
    }).toList();

    final validItemValues = dropdownItems.map((e) => e.value).toSet();
    final isValid = selectedId != null && validItemValues.contains(selectedId);
    final safeValue = isValid ? selectedId : null;

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'JosefinSans',
              fontSize: 13,
              color: brandGreyColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<int>(
                  isExpanded: true,
                  value: safeValue,
                  hint: const Text(
                    "Select",
                    style: TextStyle(
                      color: brandGreySoftColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  items: dropdownItems,
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      onChanged(newValue);
                    }
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                  dropdownStyleData: const DropdownStyleData(
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildTextField({
  required String title,
  required String hint,
  required TextEditingController controller,
  FocusNode? focusNode,
  TextInputType keyboardType = TextInputType.number,
  bool readOnly = false,
  bool isValidator = false,
  String errorMsg = "",
  Function(String)? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'JosefinSans',
                fontSize: 13,
                color: brandGreyColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              readOnly: readOnly,
              enableInteractiveSelection: !readOnly, // IMPORTANT
              onChanged: onTap,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
              ],
              keyboardType: keyboardType,
              style: const TextStyle(
                fontFamily: 'JosefinSans',
                color: brandGreySoftColor,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  fontFamily: 'JosefinSans',
                  color: brandGreySoftColor,
                ),
                border: InputBorder.none,
              ),
              validator: isValidator == true
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return errorMsg;
                      }
                      return null;
                    }
                  : null,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget grossWeight({
  required String title,
  required String hint,
  required int selectedId,
  required List<Map<String, dynamic>> items,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'JosefinSans',
            fontSize: 13,
            color: brandGreyColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Text(
              items.firstWhere(
                    (item) => item['id'] == selectedId,
                    orElse: () => {'name': hint},
                  )['name'] ??
                  hint,
              style: const TextStyle(
                fontFamily: 'JosefinSans',
                color: brandGreySoftColor,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget SearchBox({
  required String hintText,
  required String headline,
  required TextEditingController controller,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headline,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            readOnly: true,
            onTap: onTap,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: brandGreySoftColor,
                fontWeight: FontWeight.w500,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
      ],
    ),
  );
}
