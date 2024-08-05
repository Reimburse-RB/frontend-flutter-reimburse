import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';
import 'package:reimburse_rb/utility/constant.dart';

class FormDropdownFamilyMember extends StatelessWidget {
  final FamilyMemberData? value;
  final String hintText;
  final List<FamilyMemberData> items;
  final String placeholder;
  final Function(FamilyMemberData?)? onChanged;

  const FormDropdownFamilyMember({
    Key? key,
    this.value,
    required this.hintText,
    required this.items,
    this.onChanged,
    this.placeholder = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (placeholder.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 12),
            child: Text(
              placeholder,
              textAlign: TextAlign.start,
              style: Constant.mainTitleStyle,
            ),
          ),
        DropdownButtonFormField<FamilyMemberData>(
          borderRadius: BorderRadius.circular(24),
          value: value,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Constant.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Constant.greenMedium,
              ),
            ),
            hintText: hintText,
          ),
          focusColor: Constant.greenDark,
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.arrow_drop_down_rounded,
            color: Constant.green,
          ),
          items: items.map((option) {
            bool isSelected = value != null && value == option;
            return DropdownMenuItem<FamilyMemberData>(
              value: option,
              child: Text(
                option.name,
                style: isSelected
                    ? Constant.selectedDropdownItemStyle
                    : Constant.unselectedDropdownItemStyle,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
